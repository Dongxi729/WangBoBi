//
//  MainPageViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  首页

import UIKit

class MainPageViewController: UIViewController {

    // MARK: - 头部视图
    lazy var headV: HeadInfoView = {
        let d : HeadInfoView = HeadInfoView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.25))
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "钱包"
        UIApplication.shared.statusBarStyle = .default
        
        let rightItem = UIBarButtonItem.init(title: "说得对", style: .done, target: self, action: #selector(rightSEL(sender:)))
        rightItem.tintColor = UIColor.gray
        self.navigationItem.leftBarButtonItem = rightItem
     
        /// 头视图
        view.addSubview(headV)
    }
    
    func rightSEL(sender : UIButton) -> Void {
        CCog(message: "")
    }
    
}
