//
//  ShouMoneyVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/17.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  收付款控制器

import UIKit

class ShouMoneyVC: UIViewController,MoneyBagVDelegate {
    
    // MARK: - 扫描首付款试图
    lazy var mainV: MoneyBagV = {
        let d : MoneyBagV = MoneyBagV.init(frame: CGRect.init(x: COMMON_MARGIN * 2, y: COMMON_MARGIN * 2, width: SCREEN_WIDTH - SCREEN_SCALE - COMMON_MARGIN * 2 , height: SCREEN_WIDTH))
        d.delegate = self
        return d
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(mainV)
        
    }
    
    
    /// 设置金额跳转
    func setMoneyPage() {
    
        navigationController?.pushViewController(SetMoneyViewController(), animated: true)
    }
}
