//
//  UIViewController+NB.m
//  shunLiuTools
//
//  Created by shun on 2022/8/5.
//

#import "UIViewController+NB.h"
#import <objc/runtime.h>

@implementation UIViewController (NB)

+ (void)load{
    [super load];
    SEL exchangeSel = @selector(nb_presentViewController: animated: completion:);
    SEL originalSel = @selector(presentViewController: animated: completion:);
    method_exchangeImplementations(class_getInstanceMethod(self.class, originalSel), class_getInstanceMethod(self.class, exchangeSel));
}

- (UIModalPresentationStyle)modalPresentationStyle{
    return [objc_getAssociatedObject(self, @selector(modalPresentationStyle)) integerValue];
}

- (void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle{
    objc_setAssociatedObject(self, @selector(modalPresentationStyle), @(modalPresentationStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (void)nb_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^ __nullable)(void))completion{
    if (@available(iOS 13.0, *)) {
        viewControllerToPresent.modalPresentationStyle = self.modalPresentationStyle;
    }
    [self nb_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
