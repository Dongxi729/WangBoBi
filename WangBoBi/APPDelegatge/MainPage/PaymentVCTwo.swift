//
//  PaymentVCTwo.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/28.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  收付款

import UIKit

class PaymentVCTwo: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "收付款"
        
        view.addSubview(bgImg)
        view.backgroundColor = COMMON_BGCOLOR
        view.addSubview(scanBtn)
        view.addSubview(getMoneyBtn)
        
        
        /// 机型适配
        let deveiceTp = UIDevice.current.deviceType
        
        if deveiceTp == .iPhone4S {
            scanBtn.frame = CGRect(x: COMMON_MARGIN, y: SCREEN_HEIGHT * 0.580208 , width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 50 * SCREEN_SCALE)
            getMoneyBtn.frame = CGRect.init(x: COMMON_MARGIN, y: SCREEN_HEIGHT * 0.745833, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: self.scanBtn.Height)
        }
    }
    
    
    /// 收款
    fileprivate lazy var getMoneyBtn: UIButton = {
        let l : UIButton = UIButton.init(frame: CGRect.init(x: COMMON_MARGIN, y: SCREEN_HEIGHT * 0.610507239466128, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 50))
        l.backgroundColor = UIColor.randomColor()
        l.addTarget(self, action: #selector(getMoneySEL), for: .touchUpInside)
        l.layer.borderWidth = 1
        return l
    }()
    
    /// 支付
    lazy var scanBtn: UIButton = {
        let l : UIButton = UIButton.init(frame: CGRect(x: COMMON_MARGIN, y: SCREEN_HEIGHT * 0.452898543813954 , width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 50 * SCREEN_SCALE))
        l.backgroundColor = UIColor.randomColor()
        l.addTarget(self, action: #selector(paySEL), for: .touchUpInside)
        l.layer.borderWidth = 1
        return l
    }()
    
    /// 背景
    fileprivate lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: 64, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: (SCREEN_WIDTH - 2 * COMMON_MARGIN) * (670 / 600)))
        d.image = #imageLiteral(resourceName: "receive2")
        return d
    }()
    
    @objc fileprivate func paySEL() {
        CCog(message: "")
        self.navigationController?.pushViewController(PaymentThreeVC(), animated: true)
    }
    
    /// 收款页面跳转
    @objc fileprivate func getMoneySEL() {
        self.navigationController?.pushViewController(GetMoneyScanVC(), animated: true)
    }
}
