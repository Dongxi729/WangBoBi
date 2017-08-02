//
//  BaseViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/20.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,UIGestureRecognizerDelegate,UINavigationBarDelegate {
    
    /// 左上角按钮
    var leftBarItem : UIButton = UIButton()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //设置导航栏背景颜色透明
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        if self.navigationController?.viewControllers != nil && (self.navigationController?.viewControllers.count)! > 1 {
            /// 设置左上角按钮
            
            leftBarItem.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT * 0.01, width: SCREEN_WIDTH * 0.15, height: 20 * SCREEN_SCALE)
            
            leftBarItem.addTarget(self, action:#selector(back), for: .touchUpInside)
            leftBarItem.setBackgroundImage(UIImage.init(named: "rean"), for: .normal)
            
            let rightFooBarButtonItem : UIBarButtonItem = UIBarButtonItem.init(customView: leftBarItem)
            
            self.navigationItem.setLeftBarButton(rightFooBarButtonItem, animated: true)
        }
        
        
        /// 判断当前类名是否为协议的那个页面.
        if NSStringFromClass(self.classForCoder).contains("AgreeMentVC") {
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            
            /// 为那个页面则修改左上角图标
            self.leftBarItem.setBackgroundImage(UIImage.init(named: "back"), for: .normal)
            
            let navBar = navigationController?.navigationBar
            navBar?.barTintColor = UIColor.clear
            navBar?.isTranslucent = true
            
            /// 修改导航栏文字样式（富文本）
            navBar?.titleTextAttributes = [
                NSForegroundColorAttributeName : UIColor.black,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            /// 设置
            navBar?.tintColor = UIColor.white
            
        } else {
            
            let navBar = navigationController?.navigationBar
            navBar?.barTintColor = UIColor.white
            navBar?.isTranslucent = true
            navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navBar?.shadowImage = UIImage()
            
            navBar?.titleTextAttributes = [
                NSForegroundColorAttributeName : UIColor.white,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
        }
        
        //DetailViewController2
        
        /// 判断当前类名是否为协议的那个页面.--- 我的信息页面
        if NSStringFromClass(self.classForCoder).contains("MainPageVC") ||
            NSStringFromClass(self.classForCoder).contains("MyInfoVC") ||
            NSStringFromClass(self.classForCoder).contains("ScanCodeController") ||
            NSStringFromClass(self.classForCoder).contains("DetailViewController2") || NSStringFromClass(self.classForCoder).contains("DetailReplaceVC") || NSStringFromClass(self.classForCoder).contains("FriendMainVC")
        || NSStringFromClass(self.classForCoder).contains("AddFriendInfoVC") {
            
            
            /// 为那个页面则修改左上角图标
            self.leftBarItem.setBackgroundImage(UIImage.init(named: "rean"), for: .normal)
            
            let navBar = navigationController?.navigationBar
            
            
            /// 扫一扫界面
            if NSStringFromClass(self.classForCoder).contains("ScanCodeController") {
                navBar?.barTintColor = UIColor.black
                navBar?.isTranslucent = false
            }
            
            
            /// 细节
            if NSStringFromClass(self.classForCoder).contains("DetailViewController2") {
                navBar?.barTintColor = UIColor.colorWithHexString("2796DC")
                navBar?.isTranslucent = false
            }
            
            /// 朋友界面
            if NSStringFromClass(self.classForCoder).contains("FriendMainVC") {
                navBar?.barTintColor = UIColor.colorWithHexString("2796DC")
                navBar?.isTranslucent = false
            }

            
            /// 修改导航栏文字样式（富文本）
            navBar?.titleTextAttributes = [
                
                NSForegroundColorAttributeName : UIColor.white,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            /// 设置
            navBar?.tintColor = UIColor.white
        }
        
        
        /// 实名认证
        ///PushingMoneyVC
        
        
        if NSStringFromClass(self.classForCoder).contains("TrueNameCertifiedVC") || NSStringFromClass(self.classForCoder).contains("PushingMoneyVC") ||
            NSStringFromClass(self.classForCoder).contains("AgreeMentVC") ||
            NSStringFromClass(self.classForCoder).contains("WKVC") ||
            NSStringFromClass(self.classForCoder).contains("ReceiveMonVC") ||
            NSStringFromClass(self.classForCoder).contains("FriendGroupVC") ||
            NSStringFromClass(self.classForCoder).contains("NewFriendVC") ||
                NSStringFromClass(self.classForCoder).contains("AddFrienVC") ||
            NSStringFromClass(self.classForCoder).contains("PushMoneyDetailVC") ||
            NSStringFromClass(self.classForCoder).contains("CountDetailVC") ||
            NSStringFromClass(self.classForCoder).contains("AddFriendMarkVC") {
            
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            
            /// 为那个页面则修改左上角图标
            leftBarItem.setBackgroundImage(UIImage.init(named: "back"), for: .normal)
            
            let navBar = navigationController?.navigationBar
            
            DispatchQueue.main.async {
                if NSStringFromClass(self.classForCoder).contains("PushingMoneyVC") || NSStringFromClass(self.classForCoder).contains("ReceiveMonVC")  ||
                    NSStringFromClass(self.classForCoder).contains("DetailViewController2") {
                    navBar?.barTintColor = UIColor.white
                } else {
                    navBar?.barTintColor = UIColor.clear
                }
            }
            
            /// 修改导航栏文字样式（富文本）
            navBar?.titleTextAttributes = [
                
                NSForegroundColorAttributeName : UIColor.black,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            /// 设置
            navBar?.tintColor = UIColor.white
        }
        
        /// 朋友界面导航栏处理
        if NSStringFromClass(self.classForCoder).contains("FriendMainVC") {
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //启用滑动返回（swipe back）
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        
        /// 解决导航栏跳转后，控件下移64 的Bug
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        
    }
    
    
    
    /// 视图消失。将整个屏幕的大小改为最初的。
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.frame = (UIApplication.shared.keyWindow?.rootViewController?.view.bounds)!
        }
    }
    
    @objc fileprivate func back() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //修复返回失效
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if childViewControllers.count == 1 {
            return false
        } else {
            return true
        }
    }
    
}
