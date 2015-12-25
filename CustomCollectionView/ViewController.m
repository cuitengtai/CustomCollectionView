//
//  ViewController.m
//  CustomCollectionView
//
//  Created by 光之晨曦 on 15/12/15.
//  Copyright © 2015年 光之晨曦. All rights reserved.
//

#import "ViewController.h"
#import "TTCollectionViewLayout.h"
#import "Goods.h"
#import "TTCollectionViewCell.h"
static NSString *const TTCellID = @"TTCellID";
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // 自定义layout
    TTCollectionViewLayout *layout = [[TTCollectionViewLayout alloc] init];
    layout.dataSource = self.goodsArray;
    layout.cellMargin = 5;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[TTCollectionViewCell class] forCellWithReuseIdentifier:TTCellID];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodsArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TTCellID forIndexPath:indexPath];
    if (indexPath.row%2) {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor blueColor];
    }

    cell.goods = self.goodsArray[indexPath.item];
    return cell;
}
#pragma mark - getter
- (NSMutableArray *)goodsArray
{
    if (_goodsArray == nil) {
        _goodsArray = [NSMutableArray array];
        for (int i = 0; i < 50; i++) {
            Goods *goods = [[Goods alloc] init];
            goods.height = 50 + arc4random_uniform(100);
            goods.number = [NSString stringWithFormat:@"%d号", i];
            [_goodsArray addObject:goods];
        }
    }
    return _goodsArray;
}
@end
