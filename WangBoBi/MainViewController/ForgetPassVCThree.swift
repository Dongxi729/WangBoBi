    //
//  ForgetPassVC3.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/20.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  忘记密码3

import UIKit

class ForgetPassVCThree: BaseViewController,UITextFieldDelegate {
    
    // MARK: - 背景图片
    lazy var bgImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: self.view.bounds)
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.image = #imageLiteral(resourceName: "forgetPass3")
        return d
    }()
    
    // MARK: - 登录
    fileprivate lazy var loginBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.545088542256378, y: SCREEN_HEIGHT * 0.916213761205259, width: 50 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
        return d
    }()
    
    // MARK: - 保存
    fileprivate lazy var saveBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0.1256038647343 * SCREEN_WIDTH, y: SCREEN_HEIGHT * 0.614130434782609, width: SCREEN_WIDTH * 0.75, height: 30 * SCREEN_SCALE))

        d.addTarget(self, action: #selector(saveSEL), for: .touchUpInside)
        return d
    }()

    
    // MARK: - 新登录密码
    lazy var newLoginPass: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: 0.172302725234469 * SCREEN_WIDTH, y: SCREEN_HEIGHT * 0.389945652173913, width: SCREEN_WIDTH * 0.7, height: 30 * SCREEN_SCALE))
        d.delegate = self
        d.font = UIFont.init(name: "SimHei", size: 12 * SCREEN_SCALE)
        return d
    }()

    
    // MARK: - 重复密码
    lazy var repeatPass: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: 0.172302725234469 * SCREEN_WIDTH, y: SCREEN_HEIGHT * 0.485054347826087, width: SCREEN_WIDTH * 0.7, height: 30 * SCREEN_SCALE))
        d.delegate = self
        d.font = UIFont.init(name: "SimHei", size: 12 * SCREEN_SCALE)
        return d
    }()

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "忘记密码"
        
        view.addSubview(bgImg)
        view.addSubview(saveBtn)
        
        
        view.addSubview(newLoginPass)
        view.addSubview(repeatPass)
        
        view.addSubview(loginBtn)
    }
    
    // MARK: - 成功
    lazy var showSuccessView: ShowSuccessInfoV = {
        let d : ShowSuccessInfoV = ShowSuccessInfoV.init(frame: self.view.bounds)
        return d
    }()

    
    // MARK: - 失败
    lazy var showFailView: ShowFailV = {
        let d : ShowFailV = ShowFailV.init(frame: self.view.bounds)
        return d
    }()
    
    // MARK: - 保存
    @objc fileprivate func saveSEL() {
    
        if !(newLoginPass.text?.isEmpty)! && !(repeatPass.text?.isEmpty)! {
            if newLoginPass.text != repeatPass.text {
                toast(toast: "两次输入密码不一致")
            } else {
                AccountModel.forgetPassRequest(finished: { (result) in
                    if result == "success" {
                        /// 失败
                        view.addSubview(showSuccessView)
                        zdx_setupButtonSpringAnimation(showSuccessView)
                        
                    } else {
                        view.addSubview(showFailView)
                        zdx_setupButtonSpringAnimation(showFailView)
                    }
                })
            }
        }
        
        if (newLoginPass.text?.isEmpty)! {
            toast(toast: "密码不能为空")
        }
        
        if (repeatPass.text?.isEmpty)! {
            toast(toast: "确认密码不能为空")
        }
        
   
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)

    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        let touchPoint: CGPoint? = touch?.location(in: self.view)
        print("\((touchPoint?.x)! / SCREEN_WIDTH)==\((touchPoint?.y)! / SCREEN_HEIGHT)")
        let stringFloat = Int((touchPoint?.x)!)
        let stringFloat1 = Int((touchPoint?.y)!)
        print("\(stringFloat)\(stringFloat1)")
    }
    
    // MARK: - 返回首页
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
