//
//  TTCollectionViewLayout.m
//  CustomCollectionView
//
//  Created by 光之晨曦 on 15/12/15.
//  Copyright © 2015年 光之晨曦. All rights reserved.
//

#import "TTCollectionViewLayout.h"
#import "Goods.h"
#import <objc/runtime.h>
@interface TTCollectionViewLayout()
/**
 *  内容高度
 */
@property (nonatomic, assign) CGFloat contentHeight;
/**
 *  每一列的宽度
 */
@property (nonatomic, assign) CGFloat columnWidth;
/**
 *  缓存高度数组
 */
@property (nonatomic, strong) NSMutableArray *cache;

@end
@implementation TTCollectionViewLayout

- (void)prepareLayout
{
    if (self.cache.count == 0) {
        // 计算每列的宽度
        CGFloat columnWidth = (self.contentWidth - ((self.numberOfColumns + 1)*self.cellMargin))/self.numberOfColumns;
        // 每列item的x坐标
        NSMutableArray *xOffset = [NSMutableArray array];
        for (int i = 0; i < self.numberOfColumns; i++) {
            [xOffset addObject:@(i*(columnWidth + self.cellMargin) + self.cellMargin)];
        }
        // 每列item的y坐标
        int column = 0;
        NSMutableArray *yOffset = [NSMutableArray array];
        for (int i = 0; i < self.numberOfColumns; i++) {
            [yOffset addObject:@(0)];
        }
        
        for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
            // 从第二行开始寻找合适的列
            if (i >= self.numberOfColumns){
                float minY= [[yOffset valueForKeyPath:@"@min.floatValue"] floatValue];
                __block NSUInteger index = 0;
                [yOffset enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([(NSNumber *)obj floatValue] == minY) {
                        index = idx;
                    }
                }];
                column = (int)index;
            }
            // 设置item的属性
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            CGFloat itemFrameHeight = 0;
            if (self.dataSource.count > 0) { // 如果高度放在模型里就从模型里面取
                id model = self.dataSource[indexPath.row];
                unsigned int count;
                objc_property_t *propertys = class_copyPropertyList([model class], &count);
                for (int i = 0; i < count; i++) {
                    objc_property_t property = propertys[i];
                    NSString *name = [NSString stringWithUTF8String:property_getName(property)];
                    NSString *key = @"height";
                    if ([name isEqualToString:key]) {
                        itemFrameHeight = [[model valueForKey:key] floatValue];
                    }
                }
            } else { // 使用给定的高度
                itemFrameHeight = self.cellHeight;
            }
            CGRect itemFrame = CGRectMake([xOffset[column] floatValue], [yOffset[column] floatValue], columnWidth, itemFrameHeight);
            UICollectionViewLayoutAttributes *attaibutes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attaibutes.frame = CGRectOffset(itemFrame, 0, 0);
            
            // 放入缓存数组中
            [self.cache addObject:attaibutes];
            self.contentHeight = MAX(self.contentHeight, CGRectGetMaxY(itemFrame));
            
            // 拿出数组中的所有y比较，找出最小得一列，将下一个item放入该列
            if (i < self.numberOfColumns) { // 第一行
                yOffset[column] = @([yOffset[column] floatValue] + itemFrameHeight + self.cellMargin);
                if (i == 2) {
                    continue;
                }
                column++;
            } else {// 第二行...
                yOffset[column] = @([yOffset[column] floatValue] + itemFrameHeight + self.cellMargin);
            }
        }

    }
}

/**
 *  确定滚动区域
 */
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.contentWidth, self.contentHeight);
}
/**
 *  显示范围内的item布局
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attaibutes in self.cache) {
        if (CGRectIntersectsRect(attaibutes.frame, rect)) {
            [layoutAttributes addObject:attaibutes];
        }
    }
    return layoutAttributes;
}
/**
 *  当需要更新layout时 YES
 */
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}
- (NSMutableArray *)cache
{
    if (_cache == nil) {
        _cache = [NSMutableArray array];
    }
    return _cache;
}
- (CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        _cellHeight = 50;
    }
    return _cellHeight;
}
- (CGFloat)numberOfColumns
{
    if (_numberOfColumns == 0) {
        _numberOfColumns = 3;
    }
    return _numberOfColumns;
}
- (CGFloat)contentWidth
{
    if (_contentWidth == 0) {
        _contentWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return _contentWidth;
}

@end
