//
//  TestModelData.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/8/7.
//  Copyright © 2017年 郑东喜. All rights reserved.
//
import UIKit

class TestModelData : NSObject {
    class func TextMethod(finished:@escaping (_ model : [ZDxListRootClass])->()) {
        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                         "token" : (AccountModel.shared()?.Token)!,
                                         "limit" : "1",
                                         "offset" : "10"]
        
        NetWorkTool.shared.postWithPath(path: FRIEND_LIST, paras: param, success: { (result) in
            guard let resultData = result as? NSDictionary else {
                return
            }
            var ddd = [ZDxListRootClass]()
            ddd = [ZDxListRootClass.init(fromDictionary: resultData as! [String : Any])]
            finished(ddd)
            
        }) { (eoor) in
            CCog(message: eoor.localizedDescription)
        }
    }
}
