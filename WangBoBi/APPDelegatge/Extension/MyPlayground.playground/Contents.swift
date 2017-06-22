//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"






extension String {
    /// 检查邮箱格式
    func validateEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9._%+-]+"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}

let dd = "AA3AA"

dd.characters.count
dd.validateEmail()