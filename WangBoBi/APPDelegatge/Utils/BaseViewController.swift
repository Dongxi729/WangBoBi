//
//  BaseViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/20.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,UIGestureRecognizerDelegate,UINavigationBarDelegate {
    
    var leftBarItem : UIButton = UIButton()
    
    /// 分割线
    lazy var separatorLine: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 1))
        d.backgroundColor = UIColor.gray
        return d
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //设置导航栏背景颜色透明
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        let btnn = CommonBtn()
        btnn.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT * 0.01, width: SCREEN_WIDTH * 0.15, height: 20 * SCREEN_SCALE)
        
        btnn.addTarget(self, action:#selector(back), for: .touchUpInside)
        
        btnn.setBackgroundImage(UIImage.init(named: "rean"), for: .normal)
        
        let rightFooBarButtonItem : UIBarButtonItem = UIBarButtonItem.init(customView: btnn)
        
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationItem.setLeftBarButton(rightFooBarButtonItem, animated: true)
        }
        
        
        
        if NSStringFromClass(self.classForCoder).contains("AgreeMentVC") {

            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default

            
            btnn.setBackgroundImage(UIImage.init(named: "back"), for: .normal)
            
            let navBar = navigationController?.navigationBar
            navBar?.barTintColor = UIColor.clear
            navBar?.isTranslucent = true

            view.addSubview(separatorLine)
            
            navBar?.titleTextAttributes = [
                NSForegroundColorAttributeName : UIColor.black,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            navBar?.tintColor = UIColor.white
            
        } else {
            
            let navBar = navigationController?.navigationBar
            navBar?.barTintColor = UIColor.white
            navBar?.isTranslucent = true
            
            
            navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navBar?.shadowImage = UIImage()
            
            navBar?.titleTextAttributes = [
                NSForegroundColorAttributeName : UIColor.white,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //启用滑动返回（swipe back）
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.frame = (UIApplication.shared.keyWindow?.rootViewController?.view.bounds)!
        }
    }
    
    @objc fileprivate func back() {

        self.navigationController?.popViewController(animated: true)
    }
    
    //修复返回失效
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return (self.navigationController?.viewControllers.count)! > 1
        }
        return true
    }
}
