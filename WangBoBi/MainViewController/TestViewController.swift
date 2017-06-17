//
//  TestViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/17.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    lazy var monY: MoneyBagV = {
        let d : MoneyBagV = MoneyBagV.init(frame: self.view.bounds)
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(monY)
        
        
    }
}
