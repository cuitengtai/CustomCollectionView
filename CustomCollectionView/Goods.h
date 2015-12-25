//
//  Goods.h
//  CustomCollectionView
//
//  Created by 光之晨曦 on 15/12/18.
//  Copyright © 2015年 光之晨曦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject
/**
 *  cell高度 只要模型里面有这个属性layout类就可以找到
 */
@property (nonatomic, assign) float height;
@property (nonatomic, copy) NSString *number;

@end
