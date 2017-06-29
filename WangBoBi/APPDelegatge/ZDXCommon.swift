//
//  ZDXCommon.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import Foundation

//    /// 邮箱
var tfemail : String?


/// 验证码
var authCode :String?

/// 判断是否是模拟器
struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

/// 输出日志
///
/// - Parameters:
///   - message: 输出日志
///   - logError: 错误标记，默认是 false，如果是 true，发布时仍然会输出
///   - file: 文件名
///   - method: 方法名
///   - line: 代码行数
func CCog(message : Any,
              logError: Bool = false,
              file: String = #file,
              method: String = #function,
              line: Int = #line)
{
    if logError {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "HH:mm:ss"
        
        print("\(dformatter.string(from: Date()))","\((file as NSString).lastPathComponent) : \(line), \(method) : \(message)")
    } else {
        #if DEBUG
            let dformatter = DateFormatter()
            dformatter.dateFormat = "HH:mm:ss"
            print("\(dformatter.string(from: Date()))","\((file as NSString).lastPathComponent) : \(line), \(method) : \(message)")
        #endif
    }
}

/**
 给控件添加弹簧动画
 */
func zdx_setupButtonSpringAnimation(_ view: UIView) {
    let sprintAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
    sprintAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 0.8, y: 0.8))
    sprintAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
    sprintAnimation?.velocity = NSValue(cgPoint: CGPoint(x: 30, y: 30))
    
    /// 弹性系数
    sprintAnimation?.springBounciness = 5
    view.pop_add(sprintAnimation, forKey: "springAnimation")
}


/// 全局边距
let MARGIN: CGFloat = 12

/// 全局圆角
let CORNER_RADIUS: CGFloat = 5

/// 屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.width

/// 屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.height

/// 屏幕bounds
let SCREEN_BOUNDS = UIScreen.main.bounds

/// 全局遮罩透明度
let GLOBAL_SHADOW_ALPHA: CGFloat = 0.5

/// 导航栏背景颜色
let NAVIGATIONBAR_COLOR = UIColor(red:1,  green:1,  blue:1, alpha:1)

// MARK:- 背景颜色
let TABBAR_BGCOLOR = UIColor.init(red: 118/255, green: 200/255, blue: 218/255, alpha: 1)

// MARK: - 通用逻辑 间距
let COMMON_MARGIN : CGFloat = 12

// MARK: - 登录时间
let LOGIN_TIME : CGFloat = 0

// MARK: - 共同的背景颜色
let COMMON_BGCOLOR = UIColor.colorWithHexString("1693D9")

// MARK: - 表格背景颜色
let COMMON_TBBGCOLOR = UIColor.colorWithHexString("F7F6F7")

/// 基于iPhone6水平方向适配
///
/// - Parameter iPhone6: iPhone6水平方向尺寸
/// - Returns: 其他型号尺寸
func layoutHorizontal(iPhone6: CGFloat) -> CGFloat {
    
    var newWidth: CGFloat = 0
    
    switch iPhoneModel.getCurrentModel() {
    case .iPhone5:
        newWidth = iPhone6 * (320.0 / 375.0)
    case .iPhone6:
        newWidth = iPhone6
    case .iPhone6p:
        newWidth = iPhone6 * (414.0 / 375.0)
    default:
        newWidth = iPhone6 * (768.0 / 375.0 * 0.9)
    }
    
    return newWidth
    
}

/// 基于iPhone6字体的屏幕适配
///
/// - Parameter iPhone6: iPhone字体大小
/// - Returns: 其他型号字体
func layoutFont(iPhone6: CGFloat) -> CGFloat {
    
    var newFont: CGFloat = 0
    
    switch iPhoneModel.getCurrentModel() {
    case .iPhone5:
        newFont = iPhone6 * (320.0 / 375.0)
    case .iPhone6:
        newFont = iPhone6
    case .iPhone6p:
        newFont = iPhone6 * (414.0 / 375.0)
    default:
        newFont = iPhone6 * 1.2
    }
    
    return newFont
}

/**
 手机型号枚举
 */
enum iPhoneModel {
    
    case iPhone4
    case iPhone5
    case iPhone6
    case iPhone6p
    case iPad
    
    /**
     获取当前手机型号
     
     - returns: 返回手机型号枚举
     */
    static func getCurrentModel() -> iPhoneModel {
        switch SCREEN_HEIGHT {
        case 480:
            return .iPhone4
        case 568:
            return .iPhone5
        case 667:
            return .iPhone6
        case 736:
            return .iPhone6p
        default:
            return .iPad
        }
    }
}

// MARK:- 屏幕放大比例
let SCREEN_SCALE = UIScreen.main.bounds.width / 320


// MARK: - 提示信息
func toast(toast str : String) {
    FTIndicator.showToastMessage(str)
    FTIndicator.setIndicatorStyleToDefaultStyle()
}
