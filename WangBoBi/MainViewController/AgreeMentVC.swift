//
//  AgreeMentVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/20.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  协议控制器

import UIKit

class AgreeMentVC: BaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = UIColor.white
        navBar?.isTranslucent = false
        
        
        navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar?.shadowImage = UIImage()
        
        navBar?.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.black,
            NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
        ]
    }
    
    lazy var contentView: UITextView = {
        let d : UITextView = UITextView.init(frame: self.view.bounds)
        let str = "很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少很少"

        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //将行间距设置为28
        paraph.lineSpacing = 10
        //样式属性集合
        let attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 13 * SCREEN_SCALE),
                          NSParagraphStyleAttributeName: paraph]
        d.attributedText = NSAttributedString(string: str, attributes: attributes)
        
        /// 设置不可编辑
        d.isEditable = false
        
        return d
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "用户协议"
        
        view.addSubview(contentView)
        
    }
    
   fileprivate func outNavStyle() -> Void {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = UIColor.clear
        navBar?.isTranslucent = true
    
        navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar?.shadowImage = UIImage()
        
        navBar?.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
        ]
        
        navBar?.tintColor = UIColor.white
    }
    
    fileprivate func inVNavStyle() -> Void {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = UIColor.clear
        navBar?.isTranslucent = true
        
        
        navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar?.shadowImage = UIImage()
        
        navBar?.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.black,
            NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
        ]
        
        navBar?.tintColor = UIColor.blue
    }
}
