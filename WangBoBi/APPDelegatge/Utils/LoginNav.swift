//
//  LoginNav.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  返回颜色 Hex Color:2796DD

/// http://www.jianshu.com/p/f0d3df54baa6

import UIKit

class LoginNav: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //设置导航栏背景颜色透明
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 全屏返回手势
        panGestureBack()
    }
    
    /**
     拦截push操作
     
     - parameter viewController: 即将压入栈的控制器
     - parameter animated:       是否动画
     */
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        } else {
            viewController.hidesBottomBarWhenPushed = false
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    /**
     全屏返回手势
     */
    private func panGestureBack() {
        let target = interactivePopGestureRecognizer?.delegate
        let pan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        pan.delegate = self
        view.addGestureRecognizer(pan)
        interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(_ gesture: UIGestureRecognizer) -> Bool {
        if childViewControllers.count == 1 {
            return false
        } else {
            return true
        }
    }
    
    /**
     全局返回操作
     */
    @objc fileprivate func back() {
        popViewController(animated: true)
    }
    
    /// 监听视图变化
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let rect = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 20)
        
        if UIApplication.shared.statusBarFrame != rect {
            self.view.frame.origin.y = 20
            self.view.frame.size.height = SCREEN_HEIGHT - 20
        } else {
            self.view.frame.origin.y = 0
            self.view.frame.size.height = SCREEN_HEIGHT
            
            
        }
    }
}
