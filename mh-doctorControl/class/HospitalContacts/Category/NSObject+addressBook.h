//
//  NSObject+addressBook.h
//  ContactsDemo
//
//  Created by Damon on 15/12/4.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (addressBook)

+ (void)hl_savePhoneNumber:(NSString *)telphoneNumber
                 labelName:(NSString *)labelName
                      name:(NSString *)name
         alertViewDelegate:(id)delegate
                completion:(void (^) (NSString *resultAsString))completion;

@end
