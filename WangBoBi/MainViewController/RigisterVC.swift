//
//  RigisterVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  注册界面

import UIKit

class RigisterVC: UIViewController {

    fileprivate lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: self.view.bounds)
        d.image = #imageLiteral(resourceName: "RigisterBgV")
        d.contentMode = UIViewContentMode.scaleAspectFit
        return d
    }()
    
    
    // MARK: - 邮箱
    fileprivate lazy var AddLabel: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.18438001992046, y: SCREEN_HEIGHT * 0.39, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30 * SCREEN_SCALE))
        d.plStrSize(str: "", holderColor: UIColor.white)
        d.layer.borderColor = UIColor.black.cgColor
        
        d.font = UIFont.init(name: "SimHei", size: 12 * SCREEN_SCALE)
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(bgImg)
        
        view.addSubview(AddLabel)
        
        title = "注册"
    }

    
}
