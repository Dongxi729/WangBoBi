//
//  PaymoneyVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/28.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  收付款

import UIKit

class PaymoneyVC: BaseViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        let touchPoint: CGPoint? = touch?.location(in: self.view)
        print("\((touchPoint?.x)! / SCREEN_WIDTH)==\((touchPoint?.y)! / SCREEN_HEIGHT)")
        let stringFloat = Int((touchPoint?.x)!)
        let stringFloat1 = Int((touchPoint?.y)!)
        print("\(stringFloat)\(stringFloat1)")
    }
    
    
    lazy var getMoebtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: COMMON_MARGIN, y: SCREEN_HEIGHT * 0.610507239466128,   width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: self.scanBtn.Height))
        d.backgroundColor = UIColor.randomColor()
        d.addTarget(self, action: #selector(scanMoney), for: .touchUpInside)
        return d
    }()
    
//    跳转支付
    lazy var scanBtn: UIButton = {
        let l : UIButton = UIButton.init(frame: CGRect(x: COMMON_MARGIN, y: SCREEN_HEIGHT * 0.452898543813954 , width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 50 * SCREEN_SCALE))
        l.backgroundColor = UIColor.randomColor()
        l.addTarget(self, action: #selector(scanPayCode), for: .touchUpInside)
        l.layer.borderWidth = 1
        return l
    }()
    
    /// 背景
    fileprivate lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: 64, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: (SCREEN_WIDTH - 2 * COMMON_MARGIN) * (670 / 600)))
        d.image = #imageLiteral(resourceName: "receive1")
        return d
    }()
    
    /// 扫描商二维码付款
    @objc fileprivate func scanPayCode() {
        CCog(message: "")
        self.navigationController?.pushViewController(PaymentVCTwo(), animated: true)
    }
    
    /// 扫描商二维码付款
    @objc fileprivate func scanMoney() {
        CCog(message: "")
        self.navigationController?.pushViewController(GetMoneyScanVC(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "收付款"
        
        view.addSubview(bgImg)
        view.backgroundColor = COMMON_BGCOLOR
        view.addSubview(scanBtn)
        view.addSubview(getMoebtn)
        
        /// 机型适配
        let deveiceTp = UIDevice.current.deviceType
        
        if deveiceTp == .iPhone4S {
            scanBtn.frame = CGRect(x: COMMON_MARGIN, y: SCREEN_HEIGHT * 0.580208 , width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 50 * SCREEN_SCALE)
            getMoebtn.frame = CGRect.init(x: COMMON_MARGIN, y: SCREEN_HEIGHT * 0.745833, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: self.scanBtn.Height)
        }
    }
}
