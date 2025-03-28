//
//  UIScrollView+JHInteractivePopGesture.m
//  Haomissyou
//
//  Created by Hao on 2025/3/27.
//

#import "UIScrollView+JHInteractivePopGesture.h"

// didMoveToWindow 可能会多次调用
#define kNeedCheck 0

#if kNeedCheck
#import <objc/runtime.h>
#endif

@implementation UIScrollView (JHInteractivePopGesture)

- (void)jh_enableInteractivePopGesture
{
#if kNeedCheck
    // 防重检查
    if ([self isInteractivePopGestureConfigured]) {
        return;
    }
#endif
    
    UIViewController *viewController = [self findViewController];
    if (!viewController.navigationController) {
        return;
    }
    
    UIGestureRecognizer *popGesture = viewController.navigationController.interactivePopGestureRecognizer;
    if (popGesture) {
        [self.panGestureRecognizer requireGestureRecognizerToFail:popGesture];
    }
    
#if kNeedCheck
    // 标记已配置
    [self setInteractivePopGestureConfigured:YES];
#endif
}

#pragma mark - Private Methods

#if kNeedCheck
- (BOOL)isInteractivePopGestureConfigured
{
    return [objc_getAssociatedObject(self, @selector(isInteractivePopGestureConfigured)) boolValue];
}

- (void)setInteractivePopGestureConfigured:(BOOL)configured
{
    objc_setAssociatedObject(self, @selector(isInteractivePopGestureConfigured), @(configured), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#endif

/// 获取 ScrollView 所在的控制器
- (UIViewController *)findViewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

@end
