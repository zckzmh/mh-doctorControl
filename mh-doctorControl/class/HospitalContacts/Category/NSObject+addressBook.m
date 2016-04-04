//
//  NSObject+addressBook.m
//  ContactsDemo
//
//  Created by Damon on 15/12/4.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import "NSObject+addressBook.h"
#import <AddressBook/AddressBook.h>

@implementation NSObject (addressBook)


+(void)hl_savePhoneNumber:(NSString *)telphoneNumber
                labelName:(NSString *)labelName
                     name:(NSString *)name
        alertViewDelegate:(id)delegate
               completion:(void (^) (NSString *resultAsString))completion{

    //这个变量用于记录授权是否成功，即用户是否允许我们访问通讯录


//    void(^completion)(void) = ^(void) {
//        <#statements#>
//    };
//
//    void (^) (NSString *resultAsString)
    int __block tip = 0;

    ABAddressBookRef addBook =nil;
    addBook = ABAddressBookCreateWithOptions(NULL, NULL);
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(addBook, ^(bool greanted, CFErrorRef error){
        if (!greanted) {
            tip = 1;
        }
        dispatch_semaphore_signal(sema);
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

    if (tip) {
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的通讯录\n" delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];

        return;
    }


    //创建一个联系人引用
    ABRecordRef person = ABPersonCreate();
    NSString *firstName = name;

    // 电话号码数组
    NSArray *phones = [NSArray arrayWithObjects:telphoneNumber,nil];
    NSArray *labels = [NSArray arrayWithObjects:labelName,nil];

    ABRecordSetValue(person, kABPersonFirstNameProperty,(__bridge CFStringRef)firstName, NULL);

    // 字典引用
    ABMultiValueRef dic = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    for (int i = 0; i < [phones count]; i ++) {
        ABMultiValueIdentifier obj = ABMultiValueAddValueAndLabel(dic,(__bridge CFStringRef)[phones objectAtIndex:i], (__bridge CFStringRef)[labels objectAtIndex:i], &obj);
    }

    ABRecordSetValue(person, kABPersonPhoneProperty, dic, NULL);
    ABAddressBookAddRecord(addBook, person, NULL);
    ABAddressBookSave(addBook, NULL);

    CFRelease(addBook);
    CFRelease(person);
    CFRelease(dic);

    completion(@"1");
}

@end
