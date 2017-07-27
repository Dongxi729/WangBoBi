//
//  ScanModel.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/7.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  扫描模型

import UIKit

class ScanModel: NSObject {
    static let shared = ScanModel()
    
    /// 扫描的二维码
    var codeStr : String?
    
    /// 好友账号
    static var friemdIDStr : String?
    
    /// 好友邮箱地址
    static var friendEamil : String?
}
