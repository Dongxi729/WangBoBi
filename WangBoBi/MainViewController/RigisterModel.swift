//
//  RigisterModel.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/21.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  注册模型

import UIKit

class RigisterModel: NSObject {
    
    
    
    static let shared = RigisterModel()
    
    
    var emailAddress : String?
    
    
    
    ///
    func requestData(emailStr : String) -> Void {
        var dataS : [String : String] = [:]
    
        /// 验证邮箱
//        NetWorkTool.shared.postWithPath(path: <#T##String#>, paras: <#T##Dictionary<String, Any>?#>, success: { (<#JSON#>) in
//            <#code#>
//        }) { (<#Error#>) in
//            <#code#>
//        }
    }
    
    /// 是否验证成功
    func isEmailLogSuccess() -> Bool {
        var succesd = false
        
        
        return succesd
    }
}
