//
//  NBCollectionViewLayout.m
//  NiceIM
//
//  Created by shun on 2022/7/18.
//  Copyright © 2022 mac. All rights reserved.
//

#import "NBCollectionViewLayout.h"

@interface NBCollectionViewLayout ()

@property(nonatomic, strong)NSMutableDictionary *maxYDic;

@property(nonatomic, strong)NSMutableArray *attributesArr;

@end

@implementation NBCollectionViewLayout

- (instancetype)init{
    if (self = [super init]) {
        _column = 2;
    }
    return self;
}

- (void)setColumn:(NSInteger)column{
    if (column != _column) {
        _column = column;
        self.itemWidth = 0;
    }
}

- (void)prepareLayout{
    [super prepareLayout];
    [self.attributesArr removeAllObjects];
    
    // 初始化字典，有几列就有几个键值对，key为列，value为列的最大y值，
    // 初始值为上内边距
    for (NSInteger i = 0; i<self.column; i++) {
        self.maxYDic[@(i)] = @(self.sectionInset.top);
    }
    // 获取item总数
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    // 为每个Item创建attributes存入数组中
    for (NSInteger i = 0; i < itemCount; i++) {
        // 循环调用2去计算item attribute
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attributesArr addObject:attributes];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
     UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSAssert([self.dataSource respondsToSelector:@selector(waterFallLayout:itemHeightForItemWidth:atIndexPath:)], @"you must override waterFallLayout:itemHeightForItemWidth:atIndexPath: methods  - Warning : 需要重写瀑布流的返回高度代理方法!");
    
    CGFloat itemWidth = self.itemWidth;
    CGFloat itemHeight = [self.dataSource waterFallLayout:self itemHeightForItemWidth:itemWidth atIndexPath:attributes.indexPath];
    
    /// 找出最短的一列
    __block NSNumber *minIndex = @(0);
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL * _Nonnull stop) {
        if ([self.maxYDic[minIndex] floatValue] > [obj floatValue]) {
            minIndex = key;
        }
    }];
    // 根据最短列去计算itemX
    CGFloat itemX = self.sectionInset.left + (self.minimumInteritemSpacing + itemWidth) * minIndex.intValue;
    CGFloat itemY = 0;
    if (self.column == 1) {
        // 一列情况
        if (indexPath.row == 0 ) {
            itemY = [self.maxYDic[minIndex] floatValue];
        }else{
            itemY = [self.maxYDic[minIndex] floatValue] + self.minimumLineSpacing;
        }
    }
    else{
        // 瀑布流多列情况
        // 第一行Cell不需要添加RowSpacing, 对应的indexPath.row = 0 && =1;
        if (indexPath.row == 0 || indexPath.row == 1) {
            itemY = [self.maxYDic[minIndex] floatValue];
        }
        else{
            itemY = [self.maxYDic[minIndex] floatValue] + self.minimumLineSpacing;
        }
    }
    attributes.frame = CGRectMake(itemX, itemY , itemWidth, itemHeight);
    // 更新maxY
    self.maxYDic[minIndex] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributesArr;
}

- (CGSize)collectionViewContentSize{
    __block NSNumber *maxIndex = @(0);
    // 找到最长的一列
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL * _Nonnull stop) {
        if ([self.maxYDic[maxIndex] floatValue] < [obj floatValue]) {
            maxIndex = key;
        }
    }];
    CGFloat contentSizeY = [self.maxYDic[maxIndex] floatValue] + self.sectionInset.bottom;
    return CGSizeMake(self.collectionView.frame.size.width, contentSizeY);
}

- (NSMutableDictionary *)maxYDic{
    if (!_maxYDic) {
        _maxYDic = [[NSMutableDictionary alloc] init];
    }
    return _maxYDic;
}

- (NSMutableArray *)attributesArr{
    if (!_attributesArr) {
        _attributesArr = [NSMutableArray array];
    }
    return _attributesArr;
}

- (CGFloat)itemWidth{
    if (!_itemWidth) {
        CGFloat collectionViewWidth = self.collectionView.frame.size.width;
        if (collectionViewWidth == 0) {
            collectionViewWidth = [UIScreen mainScreen].bounds.size.width;
        }
        CGFloat width = (collectionViewWidth - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing*(self.column-1))/self.column;
        _itemWidth = floor(width);
    }
    return _itemWidth;
}

@end
