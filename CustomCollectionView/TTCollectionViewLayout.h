//
//  TTCollectionViewLayout.h
//  CustomCollectionView
//
//  Created by 光之晨曦 on 15/12/15.
//  Copyright © 2015年 光之晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCollectionViewLayout : UICollectionViewLayout
/**
 *  cell之间的距离
 */
@property (nonatomic, assign) CGFloat cellMargin;
/**
 *  cell的高度（默认50）
 */
@property (nonatomic, assign) CGFloat cellHeight;
/**
 *  列数（默认3）
 */
@property (nonatomic, assign) CGFloat numberOfColumns;
/**
 *  CollectionView的宽度（默认屏幕宽度）
 */
@property (nonatomic, assign) CGFloat contentWidth;
/**
 *  数据源，里面为模型数组，如果每个cell的高度固定，不需要传此参数
 */
@property (nonatomic, strong) NSArray *dataSource;

@end
