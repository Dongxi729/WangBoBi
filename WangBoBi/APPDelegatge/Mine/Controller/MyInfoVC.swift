//
//  MyInfoVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/22.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  我的信息页面

import UIKit

class MyInfoVC: BaseViewController {

    /// 背景视图
    fileprivate lazy var backGroundV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (500 / 640)))
        d.image = #imageLiteral(resourceName: "bgV")
        return d
    }()
    
    lazy var personInfoV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN * SCREEN_SCALE, y: self.backGroundV.bounds.midX / 1.05, width: SCREEN_WIDTH - 2 * COMMON_MARGIN * SCREEN_SCALE , height: (SCREEN_WIDTH - 2 * COMMON_MARGIN * SCREEN_SCALE) * (369 / 598)))
        d.image = #imageLiteral(resourceName: "infoV")
        d.contentMode = UIViewContentMode.scaleAspectFit
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "我的信息"
        
        view.addSubview(backGroundV)
        view.addSubview(personInfoV)
        
        view.backgroundColor = UIColor.white
    }
}
