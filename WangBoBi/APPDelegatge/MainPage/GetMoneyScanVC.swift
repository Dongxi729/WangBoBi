//
//  GetMoneyScanVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/28.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  收付款

import UIKit

class GetMoneyScanVC: BaseViewController {

    lazy var scanBtn: UIButton = {
        let l : UIButton = UIButton.init(frame: CGRect.init(x: COMMON_MARGIN, y: SCREEN_HEIGHT * 0.610507239466128, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 50))
        l.backgroundColor = UIColor.randomColor()
        l.addTarget(self, action: #selector(scanPayCode), for: .touchUpInside)
        l.layer.borderWidth = 1
        return l
    }()
    
    /// 背景
    fileprivate lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: 64, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: (SCREEN_WIDTH - 2 * COMMON_MARGIN) * (670 / 600)))
        d.image = #imageLiteral(resourceName: "getMoney")
        return d
    }()
    
    /// 扫描商二维码付款
    @objc fileprivate func scanPayCode() {
        
        CCog(message: "")
        self.navigationController?.pushViewController(PaymoneyVC(), animated: true)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "收付款"
        
        view.addSubview(bgImg)
        view.addSubview(scanBtn)
        view.backgroundColor = UIColor.colorWithHexString("093758")
        
        
        /// 机型适配
        let deveiceTp = UIDevice.current.deviceType
        
        if deveiceTp == .iPhone4S {
            
            scanBtn.frame = CGRect.init(x: COMMON_MARGIN, y: SCREEN_HEIGHT * 0.745833, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: self.scanBtn.Height)
        }
    }
}
