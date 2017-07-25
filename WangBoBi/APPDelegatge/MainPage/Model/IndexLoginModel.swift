//
//  IndexLoginModel.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  {
//CommendTop =         (
//    {
//        HeadImg = "http://192.168.1.10:8010/UploadFile/image/20170629/20170629105511_3024.jpg";
//        Href = "http://sale.jd.com/act/4kIOxPynN5TQjMf0.html?cpdad=1DLSUE";
//        Num = 0;
//        Title = "这才是深夜食堂";
//    }
//);
//MerTop =         (
//    {
//        Company = "麦当劳";
//        LogoImg = "http://192.168.1.10:8010/UploadFile/20170629100038.jpg";
//        Num = 0;
//    }
//);
//};

import UIKit

class IndexLoginModel: NSObject {
    var CommendTop : IndexCommentTopModel?
    var MerTop : IndexMertopModel?
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}

class IndexCommentTopModel: NSObject {
    /// 头像
    var HeadImg : String?
    
    /// 链接
    var Href : String?
    
    /// 评论
    var Num : String?
    
    /// 标题
    var Title : String?

    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}


class IndexMertopModel : NSObject {
    /// 公司
    var Company : String?
    
    /// logo
    var LogoImg : String?
    
    /// 评论数量
    var Num : String?

    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

// MARK: - 朋友列表模型
class FriendListModel : NSObject {
    /// 钱
    var moneyCount : String?
    
    /// 日期
    var dateTime : String?
    
    /// 描述文本
    var descStr : String?
    
    /// 是否接收、转账
    var isSend : String?
    
    /// 朋友名字
    var friendName : String?
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

// MARK: - 添加好友返回模型
class AddFriendModel : NSObject {
//    Email = "18259129536@163.com";
//    HeadImg = "http://192.168.1.10:8010/UploadFile/image/20170718092329.png";
//    IsFriend = 0;
//    TrueName = "";
//    VerifiStatus = 0;
//    WBCAdress = WZuEMHx9m9yyK7ZsJuX5jGAvg3FLbqqYFw;
    
    /// 邮箱地址
    var Email : String?
    
    /// 头像 
    var HeadImg : String?
    
    /// IsFriend- 是否是好友
    var IsFriend : NSNumber?
    
    /// 真名
    var TrueName : String?
    
    /// VerifiStatus认证状态
    var VerifiStatus : NSNumber?
    
    /// WBCAdress 钱包地址
    var WBCAdress : String?

    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
