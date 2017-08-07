//
//  AppDelegate.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import UserNotifications


var statusframe_changed = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var nav : UINavigationController?
    
    // MARK: - 设置未登录主界面
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
            if (timeStamp - lastLoginTime) <= 3600 * 24 * 30 {
                
                UserDefaults.standard.set(timeStamp, forKey: "loginTime")
                UserDefaults.standard.synchronize()
                
                /// 取出本地的账号密码重新登录，刷新本地的token
                if AccountModel.isLogin() {
                    UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
                    
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
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /// 极光推送
    //key
    let appKey = "e698eb8190760ea5b56a8f5c"
    
    //channel
    let channel = "Publish channel"
    
    //是否生产
    let isProduct : Bool = false
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // MARK: - 程序入口
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// 设置未登录主界面
        setUnlogedMain()
        
        /// 检查登录时间
        checkLoginTim()
        
        //        testComplement()
        TestModelData.TextMethod { (model) in
            CCog(message: model.count)
            let cellModel : [ZDxListData] = model[0].data
        }
        
        /// 极光推送注入
        injectJPush(didFinishLaunchingWithOptions: launchOptions)
        
        CCog(message: UIApplication.shared.statusBarFrame)
        
        /// 鉴别是否状态栏高度变化
        let rect = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 40)
        
        if UIApplication.shared.statusBarFrame == rect {
            statusframe_changed = true
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect) {
        CCog(message: "didChangeStatusBarFrame")
        UIApplication.shared.keyWindow?.rootViewController?.view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT + 20)
    }
    
    
    
    //// 测试接口
    func testComplement() {
        
        let param : [String : Any] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                      "token" : (AccountModel.shared()?.Token)!]
        
        CCog(message: param)
        
        NetWorkTool.shared.postWithPath(path: MY_FRIEND, paras: param, success: { (result) in
            CCog(message: result)
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
        
    }
    
    // MARK: - JPush
    private func injectJPush(didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Void {
        //Required
        //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
        let entity : JPUSHRegisterEntity = JPUSHRegisterEntity()
        
        
        if #available(iOS 10, *) {
            let entity = JPUSHRegisterEntity()
            entity.types = NSInteger(UNAuthorizationOptions.alert.rawValue) |
                NSInteger(UNAuthorizationOptions.sound.rawValue) |
                NSInteger(UNAuthorizationOptions.badge.rawValue)
            JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
            
        } else if #available(iOS 8, *) {
            // 可以自定义 categories
            JPUSHService.register(
                forRemoteNotificationTypes: UIUserNotificationType.badge.rawValue |
                    UIUserNotificationType.sound.rawValue |
                    UIUserNotificationType.alert.rawValue,
                categories: nil)
        } else {
            // ios 8 以前 categories 必须为nil
            JPUSHService.register(
                forRemoteNotificationTypes: UIRemoteNotificationType.badge.rawValue |
                    UIRemoteNotificationType.sound.rawValue |
                    UIRemoteNotificationType.alert.rawValue,
                categories: nil)
        }
        
        // Required
        // init Push
        // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
        // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
        JPUSHService.setup(withOption: launchOptions, appKey: appKey, channel: channel, apsForProduction: isProduct)
        
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        
        
        /// 接收自定义推送消息
        //获取自定义消息推送内容
        NotificationCenter.default.addObserver(self, selector: #selector(networkDidReceiveMessage(notification:)), name: NSNotification.Name.jpfNetworkDidReceiveMessage, object: nil)
        
    }
    
    
    /// 极光自定义推送消息
    
    func networkDidReceiveMessage(notification : Notification) -> Void {
        let userInfo = notification.userInfo
        let content = userInfo?["content"] as? String
        let extras = userInfo?["extras"] as? NSDictionary
        let customizeField = extras?["customizeField1"] as? String
        
        let alVC : UIAlertController = UIAlertController.init(title: content, message: customizeField, preferredStyle: .alert)
        
        alVC.addAction(UIAlertAction.init(title: "好的", style: .default, handler: nil))
        
        
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(alVC, animated: true, completion: nil)
        }
        
        CCog(message: notification.userInfo as Any)
    }
}


// MARK: - 推送
// MARK:- 注册token
extension AppDelegate {
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("get the deviceToken  \(deviceToken)")
        
        let token = String(data: deviceToken.base64EncodedData(), encoding: .utf8)?.trimmingCharacters(in: CharacterSet.whitespaces).trimmingCharacters(in: CharacterSet(charactersIn: "<>"))

        NotificationCenter.default.post(name: Notification.Name(rawValue: "DidRegisterRemoteNotification"), object: deviceToken)
        JPUSHService.registerDeviceToken(deviceToken)
        print(deviceToken)
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("did fail to register for remote notification with error ", error)
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        JPUSHService.handleRemoteNotification(userInfo)
        print("受到通知", userInfo)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "AddNotificationCount"), object: nil)  //把  要addnotificationcount
        print(userInfo)
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}


// MARK:- ios10 适配
extension AppDelegate :JPUSHRegisterDelegate {
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        //    let userInfo = response.notification.request.content.userInfo
        //    let request = response.notification.request // 收到推送的请求
        //    let content = request.content // 收到推送的消息内容
        //
        //    let badge = content.badge // 推送消息的角标
        //    let body = content.body   // 推送消息体
        //    let sound = content.sound // 推送消息的声音
        //    let subtitle = content.subtitle // 推送消息的副标题
        //    let title = content.title // 推送消息的标题
        
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!,
                                 withCompletionHandler completionHandler: ((Int) -> Void)!) {
        //    let userInfo = notification.request.content.userInfo
        //
        //    let request = notification.request // 收到推送的请求
        //    let content = request.content // 收到推送的消息内容
        //
        //    let badge = content.badge // 推送消息的角标
        //    let body = content.body   // 推送消息体
        //    let sound = content.sound // 推送消息的声音
        //    let subtitle = content.subtitle // 推送消息的副标题
        //    let title = content.title // 推送消息的标题
    }
    
}
