//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/// 打印日志封装 - 打包的时候注释掉
///
/// - Parameter string: 需要打印的字符串
func log(_ string: Any?) {
    
    let dformatter = DateFormatter()
    dformatter.dateFormat = "HH:mm:ss"
    
    print("\(dformatter.string(from: Date()))","\((#file as NSString).lastPathComponent):",string as Any)
}