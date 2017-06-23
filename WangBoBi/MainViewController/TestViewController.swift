    //
//  TestViewController.swift
//  WangBoBi
//
//      Created by 郑东喜 on 2017/6/18.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    lazy var poassV: XLPasswordInputView = {
        
        let d : XLPasswordInputView = XLPasswordInputView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        XLPasswordInputView.init(passwordLength: 5)
        
        
        return d
    }()
    
    
    lazy var img: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (713 / 640)))
        d.image = #imageLiteral(resourceName: "lazzz")
        return d
    }()
    
    lazy var countBtn: CountDownBtn = {
        let d: CountDownBtn = CountDownBtn.init(frame: CGRect.init(x: 0, y: 64, width: 100, height: 100))
        d.setTitle("三三四四", for: .normal)
        d.backgroundColor = UIColor.gray
        d.addTarget(self, action: #selector(countBenSEL(sender:)), for: .touchUpInside)
        return d
    }()
    
    func countBenSEL(sender : CountDownBtn) {
        CCog(message: sender.currentTitle as Any)
        
        sender.initwith(color: UIColor.orange, title: "kjakj", superView: self.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(countBtn)
        
        // Do any additional setup after loading the view.
        //        view.addSubview(poassV)
        //
        //        poassV.passwordBlock = {(params) -> Void in
        //            CCog(message: params!)
        //        }
        
//        view.backgroundColor = UIColor.randomColor()
        
//        view.addSubview(img)
    }
    
    lazy var showInfoVVV: ShowFailV = {
        let d : ShowFailV = ShowFailV.init(frame: self.view.bounds)
        return d
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        zdx_setupButtonSpringAnimation(showInfoVVV)
        view.addSubview(showInfoVVV)
    }
}
