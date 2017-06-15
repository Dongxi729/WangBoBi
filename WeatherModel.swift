//
//  WeatherModel.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  nil
//16:49:13 Optional({
//"tmp" : "36",
//"pcpn" : "0",
//"pres" : "1008",
//"vis" : "8",
//"hum" : "18",
//"fl" : "36",
//"wind" : {
//"dir" : "西风",
//"deg" : "230",
//"sc" : "3-4",
//"spd" : "12"
//},
//"cond" : {
//"txt" : "晴",
//"code" : "100"
//}
//})

import UIKit

class WeatherModel: NSObject {
    
    var dir : String?
    var deg : String?
    var sc : String?
    var spd : String?
    
//    init(dict : [String : Any]) {
//        super.init()
//        setValuesForKeys(dict)
//    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
