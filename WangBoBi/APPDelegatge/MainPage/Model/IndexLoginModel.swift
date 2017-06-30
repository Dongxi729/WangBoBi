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

struct xxx {
    /// 头像
    var HeadImg : String?
    
    /// 链接
    var Href : String?
    
    /// 评论
    var Num : Int?
    
    /// 标题
    var Title : String?
}


struct cxx2 {
    /// 公司
    var Company : String?
    
    /// logo
    var LogoImg : String?
    
    var Num : String?
}

import UIKit

class IndexCommentTopModel: NSObject {
    /// 头像
    var HeadImg : String?
    
    /// 链接
    var Href : String?
    
    /// 评论
    var Num : NSNumber?
    
    /// 标题
    var Title : String?
    
    init(HeadImg : String,Href : String,Num : NSNumber?,Title : String) {
        super.init()
        self.Num = Num
        self.Title = Title
        self.HeadImg = HeadImg
        self.Href = Href
    }
}


class IndexMertopModel : NSObject {
    /// 公司
    var Company : String?
    
    /// logo
    var LogoImg : String?
    
    var Num : String?
    
    
    init(Company : String,LogoImg : String,Num : String) {
        super.init()
        self.Company = Company
        self.LogoImg = LogoImg
        self.Num = Num
    }
}
