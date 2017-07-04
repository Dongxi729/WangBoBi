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
        
        l.addTarget(self, action: #selector(scanPayCode), for: .touchUpInside)
        
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
    
   fileprivate lazy var descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0.225637181409295 * SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 20 * SCREEN_SCALE))
        d.textAlignment = .center
        d.text = "无需添加好友，扫二维码向我付钱"
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    /// 付款二维码
    lazy var payImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH / 2 - SCREEN_WIDTH / 5, y: self.descLabel.BottomY, width: SCREEN_WIDTH / 2.5 , height: SCREEN_WIDTH / 2.5))
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "收付款"
        
        view.addSubview(bgImg)
        view.addSubview(scanBtn)
        view.backgroundColor = UIColor.colorWithHexString("093758")
        view.addSubview(descLabel)
        view.addSubview(payImg)

        
        DispatchQueue.global().async {
            
            let context = AccountModel.shared()?.PayQCode
            
            let image = context?.generateQRCode()
            
            DispatchQueue.main.async {
                self.payImg.image = image
            }
        }
        
        /// 机型适配
        let deveiceTp = UIDevice.current.deviceType
        
        if deveiceTp == .iPhone4S {
            
            scanBtn.frame = CGRect.init(x: COMMON_MARGIN, y: SCREEN_HEIGHT * 0.745833, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: self.scanBtn.Height)
            descLabel.frame = CGRect.init(x: 0, y: 0.302083 * SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 20 * SCREEN_SCALE)
            payImg.frame = CGRect.init(x: SCREEN_WIDTH / 2 - SCREEN_WIDTH / 5, y: self.descLabel.BottomY, width: SCREEN_WIDTH / 2.5 , height: SCREEN_WIDTH / 2.5)
        }
    }
}
