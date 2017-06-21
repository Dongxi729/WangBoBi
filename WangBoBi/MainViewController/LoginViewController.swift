//
//  LoginViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(bgImg)
        view.addSubview(accountLabel)
        view.addSubview(passTf)
        view.addSubview(loginBtn)
        view.addSubview(forgetPass)
        view.addSubview(createNewAccount)
        
        
        //判断机型
        let deviceType = UIDevice.current.deviceType
        
        if deviceType == .iPhone4S {

            bgImg.image = #imageLiteral(resourceName: "4s-LoginBG")
        } else {
            bgImg.image = #imageLiteral(resourceName: "LoginBgV")
        }
    }
    
    // MARK: - 背景
    fileprivate lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: self.view.bounds)
        d.contentMode = UIViewContentMode.scaleAspectFit
        
        return d
    }()
    
    // MARK: - 账号
    fileprivate lazy var accountLabel: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.213, y: 0.493 * SCREEN_HEIGHT, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30 * SCREEN_SCALE))
        d.plStrSize(str: "邮箱地址", holderColor: UIColor.white)
        d.textColor = UIColor.white
        d.font = UIFont.init(name: "SimHei", size: 12 * SCREEN_SCALE)
        d.delegate = self
        
        return d
    }()
    
    // MARK: - 密码
    fileprivate lazy var passTf: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.213, y: 0.583 * SCREEN_HEIGHT, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30 * SCREEN_SCALE))
        d.plStrSize(str: "登录密码", holderColor: UIColor.white)
        d.textColor = UIColor.white
        d.font = UIFont.init(name: "SimHei", size: 12 * SCREEN_SCALE)
        d.delegate = self
        
        return d
    }()
    
    // MARK: - 登录按钮
    fileprivate lazy var loginBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.132045063995509, y: SCREEN_HEIGHT * 0.735960131106169, width: SCREEN_WIDTH * 0.7, height: SCREEN_HEIGHT * 0.794384044149648 - SCREEN_HEIGHT * 0.735960131106169 ))
        
        d.addTarget(self, action: #selector(loginSEL), for: .touchUpInside)
        return d
    }()
    
    
    // MARK: - 忘记密码
    fileprivate lazy var forgetPass: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0.32206117934075 * SCREEN_WIDTH, y: 0.807518109031346 * SCREEN_HEIGHT, width: SCREEN_WIDTH * 0.16, height: 20 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(forgetPassSEl), for: .touchUpInside)
        
        return d
    }()
    
    // MARK: - 创建新账号
    fileprivate lazy var createNewAccount: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: self.forgetPass.RightX, y: 0.807518109031346 * SCREEN_HEIGHT, width: SCREEN_WIDTH * 0.16, height: 20 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(createAccountSEL), for: .touchUpInside)
        
        return d
    }()
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.navigationController?.navigationBar.isHidden = true
//    }
    
    
    // MARK: - UitextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.frame = CGRect.init(x: 0, y: -200 * SCREEN_SCALE, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }
        
        return true
    }
    
    // MARK: - 登录事件
    @objc fileprivate func loginSEL() {
        
        /// 判断输入的邮箱、密码长度是否大于0
        if !(accountLabel.text?.isEmpty)! && !(passTf.text?.isEmpty)! {
            /// 从模型取结果
            if LoginModel.shared.loginSuccess() {
                ////  逻辑 : 判断邮箱地址、登录密码是否一致。
                UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
            } else {
                /// 提示出错信息
                FTIndicator.showToastMessage("登录信息有误")
            }
        } else {
            FTIndicator.showToastMessage("邮箱或密码为空")
        }
    }
    
    // MARK: - 忘记密码
    @objc fileprivate func forgetPassSEl() {
        let vc = ForgetPassVC()
        vc.view.backgroundColor = UIColor.white
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    // MARK: - 创建新账号
    @objc fileprivate func createAccountSEL() {
        let vc = RigisterVC()
        vc.view.backgroundColor = UIColor.white
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
