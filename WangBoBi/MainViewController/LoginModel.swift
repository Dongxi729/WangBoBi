//
//  LoginModel.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/20.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  登录模型

import UIKit

class LoginModel: NSObject {
    
    // MARK: - 邮箱地址
    var address : String?
    
    // MARK: - 登录密码
    var loginPass : String?
    
    static let shared = LoginModel()
    
    
    
    /// 获取数据
    func getInfo() -> [String : String] {
        
        var dataSource : [String : String] = [ : ]
        
        /// 返回数据
//        NetWorkTool.shared.getWithPath(path: LOGIN_URL, paras: [:], success: { (response) in
//            
//        }) { (error) in
//            
//        }
        
        
        return dataSource
    }
    
    
    /// 是否登录成功
    func loginSuccess() -> Bool {
        /// 取出数据，邮箱、密码、返回结果
        let loged = true
        
        /// 鉴别邮箱、密码是否为空
//        if getInfo().count == 0 {
            //            self.getInfo(requestURL: <#T##String#>)
            //            重新请求数据
//        }
        
        /// 取出返回的结果,赋值
        return loged
    }

}
