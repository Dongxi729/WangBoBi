//
//  FFriendListModel.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/8/12.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class FFriendListModel: NSObject,NSCoding {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Id, forKey: "Id")
        aCoder.encode(UserName, forKey: "UserName")
        aCoder.encode(WBCAdress, forKey: "WBCAdress")
        aCoder.encode(HeadImg, forKey: "HeadImg")
        aCoder.encode(TrueName, forKey: "TrueName")
    }
    required init?(coder aDecoder: NSCoder) {
        Id = aDecoder.decodeObject(forKey: "Id") as? NSNumber
        UserName = aDecoder.decodeObject(forKey: "UserName") as? String
        WBCAdress = aDecoder.decodeObject(forKey: "WBCAdress") as? String
        HeadImg = aDecoder.decodeObject(forKey: "HeadImg") as? String
        TrueName = aDecoder.decodeObject(forKey: "TrueName") as? String
    }
    
    /// 朋友ID
    var Id : NSNumber?
    
    /// 用户名
    var UserName : String?
    
    /// 网博币钱包地址
    var WBCAdress : String?
    
    /// 头像
    var HeadImg : String?
    
    /// 真实姓名
    var TrueName : String?
    
    // KVC 字典转模型
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    class func getFriendList() {
        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                         "token" : (AccountModel.shared()?.Token)!]
        
        NetWorkTool.shared.postWithPath(path: MY_FRIEND, paras: param, success: { (result) in
            if let resultDic = result as? NSDictionary {
                resultDic.write(toFile: accountPath, atomically: true)
                
                /// 更新本地存储信息
                let account = FFriendListModel(dict: (resultDic["Data"] as? NSArray)?[0] as? NSDictionary as! [String : Any])
                
                account.saveAccount()
                
                FFriendListModel.shared()?.updateUserInfo()
            }
            
        }) { (error) in
            CCog(message: error.localizedDescription)
        }
    }
    
    // MARK: - 保存对象
    func saveAccount() {
        
        NSKeyedArchiver.archiveRootObject(self, toFile: FFriendListModel.accountPath)
    }
    
    // 持久保存到内存中
    fileprivate static var userAccount: FFriendListModel?
    
    // 归档账号的路径
    static let accountPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! + "/FriendList.plist"
    
    /// 获取用户对象(对象静态化，保存在内存中不释放)
    static func shared() -> FFriendListModel? {
        if userAccount == nil {
            /// 从本地取出数据
            userAccount = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? FFriendListModel
            dump(userAccount)
            return userAccount
        } else {
            return userAccount
        }
    }
    
    /// 登录保存
    func updateUserInfo() -> Void {
        FFriendListModel.userAccount = self
        // 归档用户信息
        saveAccount()
    }
}
