//
//  UITextField+NB.m
//  NiceIM
//
//  Created by mac on 2020/3/27.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UITextField+NB.h"
#import <objc/runtime.h>

@implementation UITextField (NB)

- (BOOL)disabledMenu{
    return [objc_getAssociatedObject(self, @selector(disabledMenu)) boolValue];
}

-(void)setDisabledMenu:(BOOL)disabledMenu{
    objc_setAssociatedObject(self, @selector(disabledMenu), @(disabledMenu), OBJC_ASSOCIATION_ASSIGN);
}

//禁止粘贴复制全选等
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    BOOL disabledMenu = [objc_getAssociatedObject(self, @selector(disabledMenu)) boolValue];
    if (disabledMenu) {
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        if (menuController) {
            [UIMenuController sharedMenuController].menuVisible = NO;
        }
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

@end
