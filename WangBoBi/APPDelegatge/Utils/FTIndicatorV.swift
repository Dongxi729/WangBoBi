//
//  FTIndicatorV.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  设置提示信息

import UIKit

class FTIndicatorV: NSObject {
    
    /// 设置提示成功信息
    ///
    /// - Parameter str: 成功信息
    class func showSuccessWithStr(_ status : String) -> Void {
        FTIndicator.showSuccess(withMessage: status)
    }
    
    /// 设置提示失败信息
    ///
    /// - Parameter str: 失败信息
    func showFailWithStr(_ status : String) -> Void {
        FTIndicator.showError(withMessage: status)
    }
    
    /// 设置呢提示信息
    ///
    /// - Parameter status: 提示信息
    func showInfoWithStr(_ status : String) -> Void {
        FTIndicator.showInfo(withMessage: status)
    }
}
