//
//  HLPDFCatagoryHeadView.m
//  heletalk-doctor
//
//  Created by Damon on 16/1/8.
//  Copyright © 2016年 heletech. All rights reserved.
//

//#import "HLPDFCatagoryHeadView.h"
//
//@implementation HLPDFCatagoryHeadView
//
//@end


#import "HLPDFCatagoryHeadView.h"

#import "HLPDFCatagory.h"

@interface HLPDFCatagoryHeadView ()

@property (nonatomic, weak) UIButton *bgButton;/**< 按钮 */


@end

@implementation HLPDFCatagoryHeadView

+(instancetype)HLPDFCatagoryHeadViewWithTableView:(UITableView *)tableView
{
    static NSString *headIdentifier = @"header";

    HLPDFCatagoryHeadView *headView = [[HLPDFCatagoryHeadView alloc] initWithReuseIdentifier:headIdentifier];

    //    headView.open = NO;


    return headView;
}


-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {

        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];

        [bgButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);

        [bgButton setBackgroundColor:[UIColor whiteColor]];

        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];


        self.bgButton = bgButton;
//        self.backgroundColor = [UIColor whiteColor];

    }
    return self;
}


-(void)headBtnClick
{

    self.pdfCatagory.opened = !self.pdfCatagory.isOpened;
    if ([self.delegate respondsToSelector:@selector(clickHeadView:)]) {
        [self.delegate clickHeadView:self];
    }

}


-(void)setPdfCatagory:(HLPDFCatagory *)pdfCatagory{

    _pdfCatagory = pdfCatagory;
    [self.bgButton setTitle:self.pdfCatagory.name forState:UIControlStateNormal];
    self.bgButton.titleLabel.font = [UIFont systemFontOfSize: 17.0];

}




- (void)didMoveToSuperview
{
    self.bgButton.imageView.transform = self.pdfCatagory.isOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _bgButton.frame = self.bounds;
}

@end