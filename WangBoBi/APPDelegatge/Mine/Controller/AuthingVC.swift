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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "实名认证"
        
        view.addSubview(bachV)
    }

}
