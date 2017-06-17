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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        window?.rootViewController = SetMoneyViewController()
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        
        // 设置全局颜色
        UITabBar.appearance().tintColor = TABBAR_BGCOLOR
        
        
        return true
    }
}

