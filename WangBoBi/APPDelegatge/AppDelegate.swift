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
    
    // MARK: - 设置已经登录主界面
    fileprivate func setLogedMain() -> Void {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        nav = JFNavigationController.init(rootViewController: MainTabBarViewController())
        window?.rootViewController = nav
        
        /// 请求首页数据
        /// 请求首页数据
        //        AccountModel.shared()?.indexInfo()
        
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        
        // 设置全局颜色
        UITabBar.appearance().tintColor = TABBAR_BGCOLOR
    }
    
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
        
        nav = LoginNav.init(rootViewController: LoginViewController())
        window?.rootViewController = nav
        
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        
        // 设置全局颜色
        UITabBar.appearance().tintColor = TABBAR_BGCOLOR
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let now = Date()
        let timerStamp : TimeInterval = now.timeIntervalSince1970
        
        let timeStamp = Int(timerStamp)
        
        CCog(message: timeStamp)
        
        //
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
        
        
//        testComplement()
        return true
        
    }
    
    //// 测试接口
    func testComplement() {
        let compresImage = UIImageJPEGRepresentation(#imageLiteral(resourceName: "forgetPass3"), 1.0)
        
        let request = "http://192.168.1.10:8010/ifs/headimg.ashx?uid=\((AccountModel.shared()?.Id.stringValue)!)&token=\((AccountModel.shared()?.Token)!)&ac=dd"
        CCog(message: request)
        
        NetWorkTool.shared.postWithImageWithData(imgData: compresImage!, path: request, success: { (result) in
            CCog(message: result)
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
        
    }
}




