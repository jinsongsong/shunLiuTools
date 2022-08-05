//
//  NBCollectionViewLayout.h
//  NiceIM
//
//  Created by shun on 2022/7/18.
//  Copyright © 2022 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NBCollectionViewLayout;
@protocol NBWaterFallLayoutDataSource <NSObject>

@required

/// 获取item高度，返回itemWidth和indexPath去获取
- (CGFloat)waterFallLayout:(NBCollectionViewLayout *)layout itemHeightForItemWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath;

@end

@interface NBCollectionViewLayout : UICollectionViewLayout

@property(nonatomic, weak)id<NBWaterFallLayoutDataSource> dataSource;

@property(nonatomic, assign)CGFloat itemWidth;

@property(nonatomic)NSInteger column;

@property(nonatomic)UIEdgeInsets sectionInset;

/// 跟滚动方向相同的间距
@property(nonatomic)CGFloat minimumLineSpacing;

/// 跟滚动方向垂直的间距
@property(nonatomic)CGFloat minimumInteritemSpacing;

@end

NS_ASSUME_NONNULL_END
