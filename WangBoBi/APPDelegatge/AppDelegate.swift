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
    
    var nav : UINavigationController?
    
    // MARK: - 设置未主界面
    func setUnlogedMain() -> Void {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        nav = LoginNav.init(rootViewController: LoginViewController())
        window?.rootViewController = nav
        
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        
        // 设置全局颜色
        UITabBar.appearance().tintColor = TABBAR_BGCOLOR
    }
    
    /// 测试
    func testPae() -> Void {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        nav = LoginNav.init(rootViewController: MainTabBarViewController())
        window?.rootViewController = nav
        
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        
        // 设置全局颜色
        UITabBar.appearance().tintColor = TABBAR_BGCOLOR
        
    }
    
    /// 检查登录时间
    func checkLoginTim() -> Void {
        
        
        let now = Date()
        let timerStamp : TimeInterval = now.timeIntervalSince1970
        
        let timeStamp = Int(timerStamp)
        
        CCog(message: timeStamp)
        
        // 取出本地时间对比操作
        if let lastLoginTime = UserDefaults.standard.object(forKey: "loginTime") as? Int {
            CCog(message: lastLoginTime)
            
            CCog(message: (timeStamp - lastLoginTime))
            
            /// 检查登录时间，小于10分钟直接登录。
            if (timeStamp - lastLoginTime) <= 60 * 10 {
                
                UserDefaults.standard.set(timeStamp, forKey: "loginTime")
                UserDefaults.standard.synchronize()
                
                /// 取出本地的账号密码重新登录，刷新本地的token
                if AccountModel.isLogin() {
                    AccountModel.loginWithLocalPassAndAccount()
                    
                } else {
                    setUnlogedMain()
                    AccountModel.logout()
                }
                
            } else {
                AccountModel.logout()
                setUnlogedMain()
            }
        } else {
            setUnlogedMain()
            AccountModel.logout()
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //                testComplement()
        //        testPae()
        
        /// 当前登录时间检验
        //        checkLoginTim()
        
        //                testComplement()
        
        setUnlogedMain()
        
        checkLoginTim()
        return true
    }
    
    //// 测试接口
    func testComplement() {
        
        let param : [String : Any] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                      "token" : (AccountModel.shared()?.Token)!,
                                      "topayads" : "wbp://3698ae12-5cec-48a6-bcf4-0d7f13a4e90b",
                                      "wbc" : "2",
                                      "paypass" : "123456".md5()]
        
        CCog(message: param)
        
        NetWorkTool.shared.postWithPath(path: TELLTOPAY, paras: param, success: { (result) in
            CCog(message: result)
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
        
    }
}
