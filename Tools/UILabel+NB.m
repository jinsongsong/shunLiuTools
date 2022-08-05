//
//  UILabel+NB.m
//  NiceIM
//
//  Created by mac on 2020/5/7.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UILabel+NB.h"
#import <objc/runtime.h>

@implementation UILabel (NB)

- (BOOL)enabledCopy{
    return [objc_getAssociatedObject(self, @selector(enabledCopy)) boolValue];
}

- (void)setEnabledCopy:(BOOL)enabledCopy{
    objc_setAssociatedObject(self, @selector(enabledCopy), @(enabledCopy), OBJC_ASSOCIATION_ASSIGN);
    //添加手势
    if (enabledCopy){
        [self attachTapHandler];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideMenuNotification) name:UIMenuControllerWillHideMenuNotification object:nil];
    }
}

- (BOOL)canBecomeFirstResponder {
    return [objc_getAssociatedObject(self, @selector(enabledCopy)) boolValue];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return (action == @selector(copyText:));
}

- (void)attachTapHandler {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *g = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:g];
}

- (void)longPress:(UILongPressGestureRecognizer *)press{
    if (press.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha: .1];
        UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)];
        [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:item]];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    }
}

#pragma mark- 复制时执行的方法
- (void)copyText:(id)sender {
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    if (self.text) {
        pBoard.string = self.text;
    }
    else {
        pBoard.string = self.attributedText.string;
    }
}

- (void)willHideMenuNotification {
    self.backgroundColor = [UIColor clearColor];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
    
@end
