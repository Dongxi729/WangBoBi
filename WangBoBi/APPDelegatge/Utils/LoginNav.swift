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
        
        let navBar = navigationBar
        navBar.barTintColor = UIColor.clear
        navBar.isTranslucent = true
        
        
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar.shadowImage = UIImage()
        
        navBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
        ]

        
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
        
        // 压入栈后创建返回按钮
//        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
//            image: UIImage(named: "")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
//            style: UIBarButtonItemStyle.done,
//            target: self,
//            action: #selector(back)
//        )
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

        CCog(message: "=======-------")
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
        CCog(message: "返回事件")
        popViewController(animated: true)
    }
    
}
