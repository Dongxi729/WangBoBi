//
//  RigisterWithDetailVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  填写注册密码协议

import UIKit

class RigisterWithDetailVC: UIViewController {
    
    fileprivate lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: self.view.bounds)
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.image = #imageLiteral(resourceName: "RigisterSetPass")
        return d
    }()
    
    
    // MARK: - 登录
    lazy var loginBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.545088542256378, y: SCREEN_HEIGHT * 0.916213761205259, width: 50 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(jumpTologin), for: .touchUpInside)
        return d
    }()
    
    // MARK: - 邀请码
    lazy var yaoqingBtn: UIButton = {
        let d: UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.18438001992046, y: SCREEN_HEIGHT * 0.407608695652174, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        return d
    }()
    
    // MARK: - 登录密码
    lazy var loginPass: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.18438001992046, y: SCREEN_HEIGHT * 0.504076086956522, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        return d
    }()
    
    // MARK: - 登录密码
    lazy var repeatPass: UIButton = {
        let d :UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.18438001992046, y: SCREEN_HEIGHT * 0.60054347826087, width: SCREEN_WIDTH * 0.88 - SCREEN_WIDTH * 0.213, height: 30 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        return d
    }()
    
    
    // MARK: - 用户协议
    lazy var userAgree: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.355877604461523, y: SCREEN_HEIGHT * 0.665307957193126, width: 100 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        return d
    }()
    
    // MARK: - 协议图标
    lazy var agreeeBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0.0901771213697351 * SCREEN_WIDTH, y: SCREEN_HEIGHT * 0.667119565217391, width: 12 * SCREEN_SCALE, height: 12 * SCREEN_SCALE))
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.addTarget(self, action: #selector(agreeSEL(sender:)), for: .touchUpInside)
        return d
    }()
    
    lazy var agreeeImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0.0901771213697351 * SCREEN_WIDTH, y: SCREEN_HEIGHT * 0.667119565217391, width: 12 * SCREEN_SCALE, height: 12 * SCREEN_SCALE))
        
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.image = #imageLiteral(resourceName: "select")
        return d
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "注册"
        view.addSubview(bgImg)
        view.addSubview(loginBtn)
        view.addSubview(yaoqingBtn)
        view.addSubview(loginPass)
        view.addSubview(repeatPass)
        view.addSubview(userAgree)
        view.addSubview(agreeeBtn)
        view.addSubview(agreeeImg)
    }

    //// 协议事件
    @objc fileprivate func agreeSEL(sender :UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            agreeeImg.image = #imageLiteral(resourceName: "selected")
        } else {
            agreeeImg.image = #imageLiteral(resourceName: "select")
        }
    }
    
    /// 跳到首页
    @objc fileprivate func jumpTologin() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        let touch: UITouch? = touches.first
    //        let touchPoint: CGPoint? = touch?.location(in: self.view)
    //        print("\((touchPoint?.x)! / SCREEN_WIDTH)==\((touchPoint?.y)! / SCREEN_HEIGHT)")
    //        let stringFloat = Int((touchPoint?.x)!)
    //        let stringFloat1 = Int((touchPoint?.y)!)
    //        print("\(stringFloat)\(stringFloat1)")
    //    }
}
