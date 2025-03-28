//
//  UIScrollView+JHInteractivePopGesture.swift
//  Haomissyou
//
//  Created by Hao on 2025/3/27.
//

import UIKit

private var interactivePopGestureConfiguredKey: UInt8 = 0

extension UIScrollView {
    
    /**
     作用：让 UIScrollView 的滚动，与控制器的左滑返回，同时生效。
     
     // 在视图控制器中使用
     override func viewDidLoad() {
         super.viewDidLoad()
         scrollView.jh_enableInteractivePopGesture()
     }
     
     // 在自定义的 View 中：
     override func didMoveToWindow() {
         super.didMoveToWindow()
         if window != nil {
            scrollView.jh_enableInteractivePopGesture()
         }
     }
     */
    func jh_enableInteractivePopGesture() {
        // 防重检查
        if isInteractivePopGestureConfigured {
            return
        }
        
        guard let viewController = findViewController(),
              let navigationController = viewController.navigationController,
              let popGesture = navigationController.interactivePopGestureRecognizer else {
            return
        }
        
        // 设置手势优先级
        panGestureRecognizer.require(toFail: popGesture)
        
        // 标记已配置
        isInteractivePopGestureConfigured = true
    }
    
    // MARK: - Private Properties
    private var isInteractivePopGestureConfigured: Bool {
        get {
            return objc_getAssociatedObject(self, &interactivePopGestureConfiguredKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &interactivePopGestureConfiguredKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 查找所属的视图控制器
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            responder = nextResponder
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
