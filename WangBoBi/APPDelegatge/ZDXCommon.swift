//
//  ZDXCommon.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import Foundation

// MARK:- 网络工具类
//POST请求
func postWithPath(path: String,paras: Dictionary<String,Any>?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {

    //(1）设置请求路径
    let url:NSURL = NSURL(string:path)!//不需要传递参数
    
    //(2) 创建请求对象
    let request:NSMutableURLRequest = NSMutableURLRequest(url: url as URL) //默认为get请求
    request.timeoutInterval = 5.0 //设置请求超时为5秒
    request.httpMethod = "POST"  //设置请求方法
    
    
    //设置请求体
    //拼接URL
    var i = 0
    var address: String = ""
    
    if let paras = paras {
        
        for (key,value) in paras {
            
            if i == 0 {
                
                address += "\(key)=\(value)"
            }else {
                
                address += "&\(key)=\(value)"
            }
            
            i += 1
        }
    }
    
    //把拼接后的字符串转换为data，设置请求体
    request.httpBody = address.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
    
    //(3) 发送请求
    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue:OperationQueue()) { (res, data, error)in
        //返回主线程执行
        DispatchQueue.main.sync {
            
            if let data = data {
                
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    
                    success(result)
                    
                }
                
            }else {
                failure(error!)
            }
            
        }
    }
    
    
}

// MARK:- get请求
func getWithPath(path: String,paras: Dictionary<String,Any>?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
    
    var i = 0
    var address = path
    if let paras = paras {
        
        for (key,value) in paras {
            
            if i == 0 {
                
                address += "?\(key)=\(value)"
            }else {
                
                address += "&\(key)=\(value)"
            }
            
            i += 1
        }
    }
    
    let url = URL(string: address.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
    
    let session = URLSession.shared
    
    let dataTask = session.dataTask(with: url!) { (data, respond, error) in
        
        if let data = data {
            
            if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                
                success(result)
            }
        }else {
            
            failure(error!)
        }
    }
    dataTask.resume()
    
}



/// 打印日志封装 - 打包的时候注释掉
///
/// - Parameter string: 需要打印的字符串
func log(_ string: Any?) {
    
    let dformatter = DateFormatter()
    dformatter.dateFormat = "HH:mm:ss"
    
    print("\(dformatter.string(from: Date()))","\((#file as NSString).lastPathComponent):",string as Any)
}

/**
 给控件添加弹簧动画
 */
func jf_setupButtonSpringAnimation(_ view: UIView) {
    let sprintAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
    sprintAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 0.8, y: 0.8))
    sprintAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
    sprintAnimation?.velocity = NSValue(cgPoint: CGPoint(x: 30, y: 30))
    sprintAnimation?.springBounciness = 20
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
