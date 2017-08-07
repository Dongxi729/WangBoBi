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
    
    /// 朋友ID
    var Id : NSNumber?
    
    /// WBCAdress 钱包地址
    var WBCAdress : String?

    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

// MARK: - 朋友界面的模型
class NewFriendListModel : NSObject {
    
//    HeadImg = "http://192.168.1.10:8010/UploadFile/image/20170718092329.png";
//    Id = 16;
//    Msg = "转账0.00001网博币";
//    NoticeNum = 1;
//    SubmitTime = "2017-07-28T18:23:59.31";
//    UserName = "18259129536@163.com";
    
    /// 头像地址
    var HeadImg : String?
    
    /// 用户名
    var UserName : String?
    
    /// 通知角标
    var NoticeNum : NSNumber?
    
    /// 提交时间
    var SubmitTime : NSString?
    
    /// 信息描述
    var Msg : String?
    
    /// 是否是朋友
    var IsFriend : NSNumber?
    
    /// 朋友ID
    var Id : NSNumber?
    
    /// 真实姓名
    var TrueName : String?
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}



// MARK: - 新的朋友模型消息模型
class FriendMainListModel : NSObject {

//    HeadImg = "http://192.168.1.10:8010/UploadFile/image/20170727062932.png";
//    Remark = JSP;
//    Status = 0;
//    SubmitTime = "2017-07-28T10:39:51.003";
//    UserId = 6;
//    UserName = "896944961@qq.com";
    /// 头像
    var HeadImg : String?
    
    /// 备注
    var Remark : String?
    
    /// 状态
    var Status : NSNumber?
    
    /// 申请加好友时间
    var SubmitTime : String?
    
    /// 用户ID
    var UserId : NSNumber?
    
    /// 用户名
    var UserName : String?
    
    /// 好友ID
    var AlyUserId : NSNumber?
    
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}

//Id = 7;
//OrderNo = 0728182712077429964;
//SubmitTime = "2017-07-28T18:27:12.157";
//ToUserId = 13;
//UserId = 6;
//WBCBalance = "0.0001";/
class TranpayorderModel : NSObject {
    /// 汇款方id
    var Id : NSNumber?
    
    /// 交易单号
    var OrderNo : String?
    
    /// 是转给谁
    var ToUserId : NSNumber?
    
    ///WBCBalance
    var WBCBalance : String?
    
    /// 转账人
    var UserId : NSNumber?

    /// 交易时间
    var SubmitTime : NSString?
    
    /// 好友网博币钱包地址
    var WBCAdress : String?
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}


// MARK: - 充值卡接口
class ChardCardModel : NSObject {   init(dict: [String : Any]) {
    super.init()
    setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}    
}
