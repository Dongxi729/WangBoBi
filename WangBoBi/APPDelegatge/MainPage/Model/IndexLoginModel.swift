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
