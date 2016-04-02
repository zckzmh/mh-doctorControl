//
//  MHSearchBar.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/23.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "MHSearchBar.h"

@implementation MHSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    self  = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    
    self.placeholder = @"请输入医生姓名";
    self.borderStyle = UITextBorderStyleRoundedRect;
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-sousuo"]];
    icon.frame = CGRectMake(0, 0, 20 , 20);
//    tempFrame.size.width = 30;
//    icon.frame = tempFrame;
    self.leftView = icon;
    self.leftViewMode  = UITextFieldViewModeAlways;
    self.clearButtonMode = UITextFieldViewModeAlways;
    self.returnKeyType = UIReturnKeySearch;
}
@end
