//
//  LoginVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  登录

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //设置导航栏背景颜色透明
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    
    
    lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: self.view.bounds)
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.image = #imageLiteral(resourceName: "LoginBgV")
        return d
    }()
    
    lazy var accountLabel: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.213, y: 0.5 * SCREEN_HEIGHT, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30))
        d.plStrSize(str: "邮箱地址", holderColor: UIColor.white, textFontSize: 12 * SCREEN_SCALE)
        d.textColor = UIColor.white
        d.delegate = self
        return d
    }()
    
    lazy var passTf: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.213, y: 0.59 * SCREEN_HEIGHT, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30))
        d.plStrSize(str: "登录密码", holderColor: UIColor.white, textFontSize: 12 * SCREEN_SCALE)
        d.textColor = UIColor.white
        d.delegate = self
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(bgImg)
        view.addSubview(accountLabel)
        view.addSubview(passTf)
        
        
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

