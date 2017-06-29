
//
//  PushMoneyFailVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  充值失败

import UIKit

class PushMoneyFailVC: UIViewController {

    fileprivate lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (749 / 640)))
        d.image = #imageLiteral(resourceName: "PushMoneyFail")
        d.isUserInteractionEnabled = true
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(bgImg)
        title = "充值失败"
        view.backgroundColor = COMMON_TBBGCOLOR
        bgImg.addSubview(checkMoneyLeftBtn)
        bgImg.addSubview(keepPushMoney)
    }
    
    /// 继续充值
    lazy var keepPushMoney: UIButton = {
        let d: UIButton = UIButton.init(frame: CGRect.init(x: 0, y: self.bgImg.Height * 0.75, width: self.bgImg.Width, height: 50 * SCREEN_SCALE))
        d.layer.borderWidth = 2
        d.addTarget(self, action: #selector(keepPushMoneySEL), for: .touchUpInside)
        return d
    }()
    
    /// 查看钱包余额
    fileprivate lazy var checkMoneyLeftBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: self.bgImg.Height * 0.6, width: self.bgImg.Width, height: 50 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        d.addTarget(self, action: #selector(checkMoneyLeftSEL), for: .touchUpInside)
        return d
    }()

    // MARK: - methods
    /// 查看钱包余额（返回首页）
    @objc fileprivate func checkMoneyLeftSEL() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /// 继续充值
    @objc fileprivate func keepPushMoneySEL() {
        self.navigationController?.popViewController(animated: true)
    }

}
