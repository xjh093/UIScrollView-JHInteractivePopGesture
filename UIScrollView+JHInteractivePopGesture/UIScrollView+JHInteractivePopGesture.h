//
//  UIScrollView+JHInteractivePopGesture.h
//  Haomissyou
//
//  Created by Hao on 2025/3/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (JHInteractivePopGesture)

/**
 作用：让 UIScrollView 的滚动，与控制器的左滑返回，同时生效。
 
 调用时机一：
 在控制器中：
 
 - (void)viewDidLoad {
     [super viewDidLoad];
     
     // 让 scrollView 支持左滑返回
     [self.scrollView enableInteractivePopGesture];
 }
 
 调用时机二：
 // 在自定义的 View 中：
 - (void)didMoveToWindow {
     [super didMoveToWindow];
 
     if (self.window) {
        // 让 scrollView 支持左滑返回
        [self.scrollView enableInteractivePopGesture];
     }
 }
 */
- (void)jh_enableInteractivePopGesture;

@end

NS_ASSUME_NONNULL_END
