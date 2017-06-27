//
//  TrueNameCertifiedVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/16.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  实名认证

import UIKit

class TrueNameCertifiedVC: UIViewController {
    
    /// 背景图片
    fileprivate lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0.5, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (749 / 640)))
        d.image = #imageLiteral(resourceName: "trueNameBgv")
        return d
    }()

    /// 实名验证按钮
    lazy var certiFyBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.0893719806763285, y: SCREEN_HEIGHT * 0.4, width: SCREEN_WIDTH * 0.85, height: 50 * SCREEN_SCALE))
        
        d.addTarget(self, action: #selector(jumpTocertified), for: .touchUpInside)
        return d
    }()

    /// 跳往实名认证
    @objc fileprivate func jumpTocertified() -> Void {
        let vc = NameCerWithDetailVC()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /// 分割线
    fileprivate lazy var line: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5))
        d.backgroundColor = UIColor.lightGray
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "实名认证"
        
        view.addSubview(bgImg)
        view.addSubview(line)
        view.backgroundColor = UIColor.white
        
        view.addSubview(certiFyBtn)
        
        /// 机型适配
        let device = UIDevice.current.deviceType
        if device == .iPhone4S {
            self.certiFyBtn.frame = CGRect.init(x: SCREEN_WIDTH * 0.0893719806763285, y: SCREEN_HEIGHT * 0.5, width: SCREEN_WIDTH * 0.85, height: 50 * SCREEN_SCALE)
        }
        
    }
}
