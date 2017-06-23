//
//  TrueNameCertifiedVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/16.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  实名认证

import UIKit

class TrueNameCertifiedVC: BaseViewController {
    
    /// 背景图片
    fileprivate lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 64.5, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (749 / 640)))
        d.image = #imageLiteral(resourceName: "trueNameBgv")
        return d
    }()

    
    lazy var certiFyBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.0893719806763285, y: SCREEN_HEIGHT * 0.501811587292215, width: SCREEN_WIDTH, height: 50 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        d.addTarget(self, action: #selector(trueNameAdustSEL), for: .touchUpInside)
        return d
    }()

    @objc fileprivate func trueNameAdustSEL() -> Void {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.red
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /// 分割线
    fileprivate lazy var line: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: 0.5))
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
    }
}
