//
//  ForgetPassVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  忘记密码

import UIKit

class ForgetPassVC: BaseViewController,UITextFieldDelegate {
    
    // MARK: - 背景图片
    private lazy var bgImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: self.view.bounds)
        d.image = #imageLiteral(resourceName: "forgetPass")
        d.contentMode = .scaleAspectFill
        return d
    }()
    
    // MARK: - 邮箱
    private lazy var AddLabel: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.18438001992046, y: SCREEN_HEIGHT * 0.385, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30 * SCREEN_SCALE))
        d.plStrSize(str: "", holderColor: UIColor.white)
        d.delegate = self
        d.font = UIFont.init(name: "SimHei", size: 12 * SCREEN_SCALE)
        return d
    }()
    

    // MARK: - 确定按钮
    private lazy var confirmBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0.1256038647343 * SCREEN_WIDTH, y: SCREEN_HEIGHT * 0.53804347826087, width: SCREEN_WIDTH * 0.75, height: 30 * SCREEN_SCALE))
        
        d.addTarget(self, action: #selector(jumpToNext), for: .touchUpInside)
        return d
    }()

    // MARK: - 登录
    private lazy var loginBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.545088542256378, y: SCREEN_HEIGHT * 0.916213761205259, width: 50 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
        
        return d
    }()

    /// 底部图标
    private lazy var bottomImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: self.loginBtn.TopY, width: SCREEN_WIDTH, height: self.loginBtn.Height))
        d.image = #imageLiteral(resourceName: "bottom01")
        d.contentMode = UIViewContentMode.scaleAspectFit
        return d
    }()

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let rect = UIApplication.shared.statusBarFrame
        
        if UIApplication.shared.statusBarFrame != rect {
            self.view.frame.origin.y = 20
            CCog(message: "ddd")
            
        } else {
            if statusframe_changed {
                
                self.view.frame.size.height = SCREEN_HEIGHT - 20
                self.AddLabel.frame = CGRect.init(x: SCREEN_WIDTH * 0.18438001992046, y: SCREEN_HEIGHT * 0.385 - 10 * SCREEN_SCALE, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30 * SCREEN_SCALE)
                
                self.confirmBtn.frame = CGRect.init(x: 0.1256038647343 * SCREEN_WIDTH, y: SCREEN_HEIGHT * 0.53804347826087 - 10 * SCREEN_SCALE, width: SCREEN_WIDTH * 0.75, height: 30 * SCREEN_SCALE)
                
                self.loginBtn.frame = CGRect.init(x: SCREEN_WIDTH * 0.545088542256378, y: SCREEN_HEIGHT * 0.916213761205259 - 10 * SCREEN_SCALE, width: 50 * SCREEN_SCALE, height: 30 * SCREEN_SCALE)
                CCog(message: "xxxx")
                
                
                let deviceType = UIDevice.current.deviceType
                if deviceType == .iPhone4S {
                    AddLabel.frame = CGRect.init(x: SCREEN_WIDTH * 0.18438001992046, y: SCREEN_HEIGHT * 0.37 - 10 * SCREEN_SCALE, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30 * SCREEN_SCALE)

                }
                self.view.frame.origin.y = 0
                self.view.frame.size.height = SCREEN_HEIGHT
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "忘记密码"
        view.addSubview(bgImg)
        
        view.addSubview(AddLabel)
        
        view.addSubview(confirmBtn)

        
        let deviceType = UIDevice.current.deviceType
        if deviceType == .iPhone4S {
            CCog(message: "====")
            AddLabel.frame = CGRect.init(x: SCREEN_WIDTH * 0.18438001992046, y: SCREEN_HEIGHT * 0.37, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30 * SCREEN_SCALE)
            view.addSubview(bottomImg)
        }
       
        view.addSubview(loginBtn)
        
    }
    
    /// 发送验证码
    @objc fileprivate func jumpToNext() {
        
        /// 判断是否为空
        if !(self.AddLabel.text?.isEmpty)! {
            
            
            if (self.AddLabel.text?.validateEmail())! {
                tfemail = AddLabel.text!
                
                AccountModel.sendEmailAutoCode(str: AddLabel.text!, finished: { (sendResult) in
                    CCog(message: sendResult)
                    
                    if sendResult {
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                            self.navigationController?.pushViewController(ForgetPassVCTwo(), animated: true)
                        })
                        
                    }
                })
            } else {
                toast(toast: "邮件格式不正确")
            }
        } else {
            FTIndicator.showToastMessage("邮箱地址不为空")
        }
        
        
    }
    
    /// 返回首页
    @objc fileprivate func backToMain() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    // MARK: - UitextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.frame = CGRect.init(x: 0, y: -100 * SCREEN_SCALE, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }
        
        return true
    }

}
