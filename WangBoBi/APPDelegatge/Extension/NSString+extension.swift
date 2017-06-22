//
//  NSString+extension.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import Foundation

/**
 扩展String的 MD5加密
 */
extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash as String)
    }
}

// MARK: - 银行卡暗文
extension String {
    func replaceIndexStr(replaceStr newString : String,replaceLength index : Int,replaceStr stttr : String) -> String {
        var ddd : String = newString
        ddd.replaceSubrange(ddd.startIndex...ddd.index(ddd.startIndex, offsetBy: index), with: stttr)
        return ddd
    }
    
    /// 检查邮箱格式
    func validateEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    // 校验验证码
    func validateAutoCode() -> Bool {
        let emailRegex: String = "[A-Z0-9._%+-]+"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}
