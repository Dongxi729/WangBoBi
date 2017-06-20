//
//  TestViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/18.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    lazy var poassV: XLPasswordInputView = {
        
        let d : XLPasswordInputView = XLPasswordInputView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        XLPasswordInputView.init(passwordLength: 5)
        
        
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        view.addSubview(poassV)
        //
        //        poassV.passwordBlock = {(params) -> Void in
        //            CCog(message: params!)
        //        }
        
        view.backgroundColor = UIColor.randomColor()
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
