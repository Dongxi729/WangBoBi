//
//  AleradyCertify.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/26.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  已经实名认证

import UIKit

class AleradyCertify: UIViewController {

    fileprivate lazy var bachV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: (SCREEN_WIDTH - 2 * COMMON_MARGIN) * (605 / 640)))
        d.image = #imageLiteral(resourceName: "aleadyCertify")
        return d
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(bachV)
        
        view.backgroundColor = UIColor.white
        
        title = "设置双重认证"
    }
}
