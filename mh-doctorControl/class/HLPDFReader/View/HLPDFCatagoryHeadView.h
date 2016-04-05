//
//  HLPDFCatagoryHeadView.h
//  heletalk-doctor
//
//  Created by Damon on 16/1/8.
//  Copyright © 2016年 heletech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HLPDFCatagory,HLPDFCatagoryHeadView;

@protocol HLPDFCatagoryHeadViewDelegate <NSObject>

@optional

- (void)clickHeadView:(HLPDFCatagoryHeadView *)HLPDFCatagoryHeadView;

@end

@interface HLPDFCatagoryHeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) HLPDFCatagory *pdfCatagory;

@property (nonatomic, weak) id<HLPDFCatagoryHeadViewDelegate> delegate;



+(instancetype)HLPDFCatagoryHeadViewWithTableView:(UITableView *)tableView;

@end