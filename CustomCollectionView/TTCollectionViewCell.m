//
//  TTCollectionViewCell.m
//  CustomCollectionView
//
//  Created by 光之晨曦 on 15/12/18.
//  Copyright © 2015年 光之晨曦. All rights reserved.
//

#import "TTCollectionViewCell.h"
#import "Goods.h"
#import "Masonry.h"
@interface TTCollectionViewCell()
@property (nonatomic, strong) UILabel *lable;

@end
@implementation TTCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        _lable = [[UILabel alloc] init];
        [self.contentView addSubview:_lable];
        [_lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self.contentView);
        }];
        _lable.textColor = [UIColor whiteColor];
        _lable.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setGoods:(Goods *)goods
{
    _goods = goods;
    self.lable.text = goods.number;
}

@end
