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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setGraphicsAndCPU()
        
        let now = Date()
        let timerStamp : TimeInterval = now.timeIntervalSince1970
        
        let timeStamp = Int(timerStamp)
        
        CCog(message: timeStamp)
        
        
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
//        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
//                                         "token" : (AccountModel.shared()?.Token)!,
//                                         "phone" : "15960005714",
//                                         "code" : "",
//                                         "ac" : "smsg"]
//        CCog(message: param)
//        NetWorkTool.shared.postWithPath(path: DOB_AUTH, paras: param, success: { (result) in
//            CCog(message: result)
//        }) { (error) in
//            CCog(message: error.localizedDescription)
//        }
        
//        NetWorkTool.shared.postWithPath(path: LOGIN_URL, paras: ["email" : "18259129536@163.com","pwd" : "123".md5()], success: { (result) in
//            CCog(message: result)
//            
//            CCog(message: "123".md5())
//            guard let resultData = result as? NSDictionary else {
//                CCog(message: "格式不对")
//                return
//            }
//
//            
//        }) { (error) in
//            CCog(message: error.localizedDescription)
//        }
        
//        NetWorkTool.shared.postWithPath(path: RIGISTER_URL, paras: ["email" : "18259129536.com","pwd" : "123".md5(),"referee" : ""], success: { (result) in
//            CCog(message: result)
//        }) { (error) in
//            CCog(message: error.localizedDescription)
//        }
        
        
//        
//        NetWorkTool.shared.postWithPath(path: FORGETPASS_URL, paras: ["email" : "946737816@qq.com","pwd" : "123456".md5(),"code" : "RN6240","ac" : "femail"], success: { (result) in
//            CCog(message: result)
//        }) { (error) in
//            CCog(message: error.localizedDescription)
//        }
        
//        let param = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
//                     "token" : (AccountModel.shared()?.Token)!,
//                     "oldpwd" : "123456".md5(),
//                     "newpwd" : "123".md5()]
//        NetWorkTool.shared.postWithPath(path: CHANGELOGIN_PASS, paras: param, success: { (result) in
//            CCog(message: result)
//        }) { (error) in
//            CCog(message: error.localizedDescription)
//        }
        
//        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
//                                         "token" : (AccountModel.shared()?.Token)!,
//                                         "phone" : "18905036476",
//                                         "code" : "446652",
//                                         "ac" : "bpon"]
//        CCog(message: param)
//        NetWorkTool.shared.postWithPath(path: BIND_PHONE, paras: param, success: { (result) in
//            CCog(message: result)
//
//        }) { (error) in
//            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
//            toast(toast: alertMsg! as! String)
//        }
        
        
//        let param = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
//                     "token" : (AccountModel.shared()?.Token)!,
//                     "oldpwd" : "123".md5(),
//                     "newpwd" : "123456".md5(),
//            "ac" : "rpd"]
//        
//        CCog(message: param)
//        
//        
//        NetWorkTool.shared.postWithPath(path: PAY_PASS, paras: param, success: { (result) in
//            CCog(message: result)
//
//        }) { (error) in
//            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
//            toast(toast: alertMsg! as! String)
//        }
        
        let compresImage = UIImageJPEGRepresentation(#imageLiteral(resourceName: "Mine_add"), 1.0)
        NetWorkTool.shared.postWithImageWithData(imgData: compresImage!, path: UPLOAD_IMGDATA, success: { (result) in
            CCog(message: result)
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
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


extension String {
    
}
