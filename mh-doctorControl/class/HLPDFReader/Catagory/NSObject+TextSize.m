//
//  NSObject+TextSize.m
//  ContactsDemo
//
//  Created by Damon on 15/12/3.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import "NSObject+TextSize.h"

@implementation NSObject (TextSize)


+(CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(320, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    return rect.size;
}

@end
