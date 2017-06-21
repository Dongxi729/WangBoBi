//
//  AppDelegate.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    /// 性能占用显示。
    var performanceView: GDPerformanceMonitor?
    
    var nav : LoginNav?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setGraphicsAndCPU()
        
        CCog(message: AccountModel.isLogin())
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        nav = LoginNav.init(rootViewController: LoginViewController())
        window?.rootViewController = nav
        
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        
        // 设置全局颜色
        UITabBar.appearance().tintColor = TABBAR_BGCOLOR
        
//        NetWorkTool.shared.postWithPath(path: LOGIN_URL, paras: ["email" : "18259129536@163.com","pwd" : "123".md5()], success: { (result) in
//            CCog(message: result)
//        }) { (error) in
//            CCog(message: error.localizedDescription)
//        }
        
        NetWorkTool.shared.postWithPath(path: RIGISTER_URL, paras: ["email" : "18259129536@163.com","pwd" : "123".md5(),"referee" : ""], success: { (result) in
            CCog(message: result)
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
        
        
        return true
    }
    
    /// 设置显示和处理器性能
    private func setGraphicsAndCPU() -> Void {
        #if DEBUG
            GDPerformanceMonitor.sharedInstance.startMonitoring()
            GDPerformanceMonitor.sharedInstance.configure(configuration: { (textLabel) in
                textLabel?.backgroundColor = .black
                textLabel?.textColor = .white
                textLabel?.layer.borderColor = UIColor.black.cgColor
            })
        #endif
    }
}

