//
//  PushMoneySuccessVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  充值成功

import UIKit

class PushMoneySuccessVC: UIViewController {

    fileprivate lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (749 / 640)))
        d.image = #imageLiteral(resourceName: "moneySuccessBgV")
        d.isUserInteractionEnabled = true
        return d
    }()
    
    /// 分割线
    fileprivate lazy var line: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: 0.5))
        d.backgroundColor = UIColor.colorWithHexString("C8C7CB")
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(bgImg)
        title = "充值成功"
        view.addSubview(line)
        view.backgroundColor = COMMON_TBBGCOLOR

        bgImg.addSubview(checkMoneyLeftBtn)
        bgImg.addSubview(keepPushMoney)
    }
    
    /// 继续充值
    lazy var keepPushMoney: UIButton = {
        let d: UIButton = UIButton.init(frame: CGRect.init(x: 0, y: self.bgImg.Height * 0.75, width: self.bgImg.Width, height: 50 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(keepPushMoneySEL), for: .touchUpInside)
        return d
    }()
    
    /// 查看钱包余额
    fileprivate lazy var checkMoneyLeftBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: self.bgImg.Height * 0.6, width: self.bgImg.Width, height: 50 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(checkMoneyLeftSEL), for: .touchUpInside)
        return d
    }()
    
    lazy var iii: UIView = {
        let d : UIView = UIView.init(frame: self.bgImg.bounds)
        return d
    }()
    
    // MARK: - methods
    
    /// 查看钱包余额（返回首页）
    @objc fileprivate func checkMoneyLeftSEL() {
        
        if let _ = AccountModel.shared()?.Id.stringValue {
            if let _ = AccountModel.shared()?.Token {
                AccountModel.reloadSEL()
            }
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /// 继续充值
    @objc fileprivate func keepPushMoneySEL() {
        self.navigationController?.popViewController(animated: true)
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        let touchPoint: CGPoint? = touch?.location(in: self.view)
        print("\((touchPoint?.x)! / SCREEN_WIDTH)==\((touchPoint?.y)! / SCREEN_HEIGHT)")
        let stringFloat = Int((touchPoint?.x)!)
        let stringFloat1 = Int((touchPoint?.y)!)
        print("\(stringFloat)\(stringFloat1)")
    }

}
