//
//  RigisterVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  注册界面

import UIKit

class RigisterVC: BaseViewController,UITextFieldDelegate {

    fileprivate lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: self.view.bounds)
        d.image = #imageLiteral(resourceName: "RigisterBgV")
        d.contentMode = UIViewContentMode.scaleAspectFill
        return d
    }()
    
    
    // MARK: - 邮箱
    fileprivate lazy var AddLabel: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.18438001992046, y: SCREEN_HEIGHT * 0.39, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30 * SCREEN_SCALE))
        d.plStrSize(str: "", holderColor: UIColor.white)
        d.layer.borderColor = UIColor.red.cgColor
        d.layer.borderWidth = 1
        d.delegate = self

        return d
    }()
    
    // MARK: - 确定按钮
    fileprivate lazy var confirmBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0.1256038647343 * SCREEN_WIDTH, y: SCREEN_HEIGHT * 0.53804347826087, width: SCREEN_WIDTH * 0.75, height: 30 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(jumpToRigisterDetailV), for: .touchUpInside)
        d.layer.borderColor = UIColor.red.cgColor
        d.layer.borderWidth = 1
        return d
    }()

    // MARK: - 登录
    fileprivate lazy var loginBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.545088542256378, y: SCREEN_HEIGHT * 0.916213761205259, width: 50 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(jumpTologin), for: .touchUpInside)
        return d
    }()
    
    /// 底部图标
    lazy var bottomImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: self.loginBtn.TopY, width: SCREEN_WIDTH, height: self.loginBtn.Height))
        d.image = #imageLiteral(resourceName: "bottom01")
        d.contentMode = UIViewContentMode.scaleAspectFit
        return d
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "注册"
        
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

    /// 发生验证码
    @objc fileprivate func jumpToRigisterDetailV() {
        
        if !(AddLabel.text?.isEmpty)! {
            if (AddLabel.text?.validateEmail())! {
                AccountModel.shared()?.email = AddLabel.text!
                self.navigationController?.pushViewController(RigisterWithDetailVC(), animated: true)
            } else {
                toast(toast: "邮件格式不正确")
            }
        
            
        } else {
            toast(toast: "邮箱不能为空")
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    /// 跳到首页
    @objc fileprivate func jumpTologin() {
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
