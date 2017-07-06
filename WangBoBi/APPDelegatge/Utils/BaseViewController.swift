//
//  BaseViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/20.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,UIGestureRecognizerDelegate,UINavigationBarDelegate {
    
    var leftBarItem : UIButton = UIButton()
    
    /// 分割线
    lazy var separatorLine: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 1))
        d.backgroundColor = UIColor.gray
        return d
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //设置导航栏背景颜色透明
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
  
        
        /// 设置左上角按钮
        let btnn = CommonBtn()
        btnn.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT * 0.01, width: SCREEN_WIDTH * 0.15, height: 20 * SCREEN_SCALE)
        
        btnn.addTarget(self, action:#selector(back), for: .touchUpInside)
        
        btnn.setBackgroundImage(UIImage.init(named: "rean"), for: .normal)
        
        let rightFooBarButtonItem : UIBarButtonItem = UIBarButtonItem.init(customView: btnn)
        

        
        /// 页面大于1，显示否则相反
        if self.navigationController?.viewControllers != nil && (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationItem.setLeftBarButton(rightFooBarButtonItem, animated: true)
        }
        
        
        /// 判断当前类名是否为协议的那个页面.
        if NSStringFromClass(self.classForCoder).contains("AgreeMentVC") {

            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            
            /// 为那个页面则修改左上角图标
            btnn.setBackgroundImage(UIImage.init(named: "back"), for: .normal)
            
            let navBar = navigationController?.navigationBar
            navBar?.barTintColor = UIColor.clear
            navBar?.isTranslucent = true

            view.addSubview(separatorLine)
            
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
        
        /// 判断当前类名是否为协议的那个页面. --- 扫描视图
        if NSStringFromClass(self.classForCoder).contains("ScanViewController") {
            /// 为那个页面则修改左上角图标
            btnn.setBackgroundImage(UIImage.init(named: "back"), for: .normal)
            
            let navBar = navigationController?.navigationBar
            navBar?.barTintColor = UIColor.clear

            view.addSubview(separatorLine)
            
            /// 修改导航栏文字样式（富文本）
            navBar?.titleTextAttributes = [
                NSForegroundColorAttributeName : UIColor.black,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            /// 设置
            navBar?.tintColor = UIColor.white
        }
        
        /// 判断当前类名是否为协议的那个页面.--- 我的信息页面
        if NSStringFromClass(self.classForCoder).contains("MainPageVC") {
            /// 为那个页面则修改左上角图标
            btnn.setBackgroundImage(UIImage.init(named: "rean"), for: .normal)
            
            let navBar = navigationController?.navigationBar
            navBar?.barTintColor = UIColor.clear

            view.addSubview(separatorLine)
            
            /// 修改导航栏文字样式（富文本）
            navBar?.titleTextAttributes = [
                
                NSForegroundColorAttributeName : UIColor.white,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            /// 设置
            navBar?.tintColor = UIColor.white
        }
        
        /// 判断当前类名是否为协议的那个页面.--- 我的信息页面
        if NSStringFromClass(self.classForCoder).contains("MyInfoVC") {
            /// 为那个页面则修改左上角图标
            btnn.setBackgroundImage(UIImage.init(named: "rean"), for: .normal)
            
            let navBar = navigationController?.navigationBar
            navBar?.barTintColor = UIColor.clear
            
            view.addSubview(separatorLine)
            
            /// 修改导航栏文字样式（富文本）
            navBar?.titleTextAttributes = [
                
                NSForegroundColorAttributeName : UIColor.white,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            /// 设置
            navBar?.tintColor = UIColor.white
        }
        
        /// 实名认证
        if NSStringFromClass(self.classForCoder).contains("TrueNameCertifiedVC") {
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            
            /// 为那个页面则修改左上角图标
            btnn.setBackgroundImage(UIImage.init(named: "back"), for: .normal)
            
            let navBar = navigationController?.navigationBar
            navBar?.barTintColor = UIColor.clear
            
            view.addSubview(separatorLine)
            
            /// 修改导航栏文字样式（富文本）
            navBar?.titleTextAttributes = [
                
                NSForegroundColorAttributeName : UIColor.black,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            /// 设置
            navBar?.tintColor = UIColor.white
        }
        
        ///PushingMoneyVC
        /// 实名认证
        if NSStringFromClass(self.classForCoder).contains("PushingMoneyVC") {
            
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            
            /// 为那个页面则修改左上角图标
            btnn.setBackgroundImage(UIImage.init(named: "back"), for: .normal)
            
            let navBar = navigationController?.navigationBar
            navBar?.barTintColor = UIColor.white
            
            view.addSubview(separatorLine)
            
            /// 修改导航栏文字样式（富文本）
            navBar?.titleTextAttributes = [
                
                NSForegroundColorAttributeName : UIColor.black,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            /// 设置
            navBar?.tintColor = UIColor.white
        }
        
        /// ScanCodeController
        if NSStringFromClass(self.classForCoder).contains("ScanCodeController") {
            
            /// 为那个页面则修改左上角图标
            btnn.setBackgroundImage(UIImage.init(named: "rean"), for: .normal)
            
            let navBar = navigationController?.navigationBar
            navBar?.barTintColor = UIColor.black
            navBar?.isTranslucent = false
            
            view.addSubview(separatorLine)
            
            /// 修改导航栏文字样式（富文本）
            navBar?.titleTextAttributes = [
                NSForegroundColorAttributeName : UIColor.white,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            /// 设置
            navBar?.tintColor = UIColor.white
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
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//        UIView.animate(withDuration: 0.5) {
//            UIApplication.shared.keyWindow?.frame = (UIApplication.shared.keyWindow?.rootViewController?.view.bounds)!
//        }
//        
//        let touch: UITouch? = touches.first
//        let touchPoint: CGPoint? = touch?.location(in: self.view)
//        print("\((touchPoint?.x)! / SCREEN_WIDTH)==\((touchPoint?.y)! / SCREEN_HEIGHT)")
//        let stringFloat = Int((touchPoint?.x)!)
//        let stringFloat1 = Int((touchPoint?.y)!)
//        print("\(stringFloat)\(stringFloat1)")
//    }
    
    @objc fileprivate func back() {

        self.navigationController?.popViewController(animated: true)
    }
    
    //修复返回失效
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return (self.navigationController?.viewControllers.count)! > 1
        }
        return true
    }

}
