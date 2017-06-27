//
//  AuthFailedVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/27.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  认证失败页面

import UIKit

class AuthFailedVC: UIViewController {
    
    fileprivate lazy var bachV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: (SCREEN_WIDTH - 2 * COMMON_MARGIN) * (605 / 640)))
        d.image = #imageLiteral(resourceName: "AuthFailed")
        return d
    }()
    
    
    lazy var reCertityBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: self.bachV.Height * 0.7, width: self.bachV.Width, height: self.bachV.Height * 0.2))
        d.layer.borderWidth = 1
        d.addTarget(self, action: #selector(jumpToReCertify), for: .touchUpInside)
        return d
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "实名认证"
        
        view.addSubview(bachV)
        
        view.addSubview(reCertityBtn)
        view.backgroundColor = UIColor.white
    }
    
    @objc fileprivate func jumpToReCertify() {
        self.navigationController?.pushViewController(TrueNameCertifiedVC(), animated: true)
    }
}
