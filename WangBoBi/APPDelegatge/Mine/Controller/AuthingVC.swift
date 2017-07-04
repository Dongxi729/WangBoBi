//
//  AuthingVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/27.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  正在认证中

import UIKit

class AuthingVC: UIViewController {

    /// 背景图片
    fileprivate lazy var bachV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: (SCREEN_WIDTH - 2 * COMMON_MARGIN) * (605 / 640)))
        d.image = #imageLiteral(resourceName: "Authing")
        return d
    }()
    
    /// 分割线
    lazy var line: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: 0.5))
        d.backgroundColor = UIColor.colorWithHexString("C8C7CB")
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "实名认证"
        
        view.addSubview(bachV)
        view.addSubview(line)
    }

}
