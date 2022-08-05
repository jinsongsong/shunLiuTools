//
//  UIButton+NB.h
//  shunLiuTools
//
//  Created by shun on 2022/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,ButtonEdgeInsetsStyle){
     ButtonEdgeInsetsStyleImageLeft,
     ButtonEdgeInsetsStyleImageRight,
     ButtonEdgeInsetsStyleImageTop,
     ButtonEdgeInsetsStyleImageBottom
};

@interface UIButton (NB)

- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
