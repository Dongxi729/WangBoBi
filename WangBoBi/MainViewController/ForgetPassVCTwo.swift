//
//  ForgetPassVCTwo.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/20.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  忘记密码第二个界面

import UIKit

class ForgetPassVCTwo: UIViewController {

    // MARK: - 背景图片
    lazy var bgImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: self.view.bounds)
        d.image = #imageLiteral(resourceName: "forgetPass2")
        return d
    }()
    
    // MARK: - 邮箱
    fileprivate lazy var AddLabel: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.18438001992046, y: SCREEN_HEIGHT * 0.385, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30 * SCREEN_SCALE))
        d.plStrSize(str: "", holderColor: UIColor.white)
        d.layer.borderColor = UIColor.black.cgColor
        
        d.font = UIFont.init(name: "SimHei", size: 12 * SCREEN_SCALE)
        return d
    }()
    
    
    // MARK: - 确定按钮
    fileprivate lazy var confirmBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0.1256038647343 * SCREEN_WIDTH, y: SCREEN_HEIGHT * 0.53804347826087, width: SCREEN_WIDTH * 0.75, height: 30 * SCREEN_SCALE))
        
        d.addTarget(self, action: #selector(nextSEL), for: .touchUpInside)
        return d
    }()
    
    // MARK: - 登录
    fileprivate lazy var loginBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.545088542256378, y: SCREEN_HEIGHT * 0.916213761205259, width: 50 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(loginSEL), for: .touchUpInside)
        return d
    }()
    
    // MARK: - 保存
    

    
    @objc fileprivate func nextSEL() {
        self.navigationController?.pushViewController(ForgetPassVCThree(), animated: true)
    }
    
    /// 发生验证码
    @objc fileprivate func loginSEL() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "忘记密码"
        view.addSubview(bgImg)
        
        view.addSubview(AddLabel)
        
        view.addSubview(confirmBtn)
        
        view.addSubview(loginBtn)
    }
}
