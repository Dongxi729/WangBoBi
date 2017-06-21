//
//  BaseViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/20.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var leftBarItem : UIButton = UIButton()
    
    /// 分割线
    lazy var separatorLine: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: (self.navigationController?.navigationBar.BottomY)!, width: SCREEN_WIDTH, height: 1))
        d.backgroundColor = UIColor.gray
        return d
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let btnn = CommonBtn()
        btnn.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT * 0.01, width: SCREEN_WIDTH * 0.15, height: 20 * SCREEN_SCALE)
        
        btnn.addTarget(self, action:#selector(back), for: .touchUpInside)
        
        btnn.setBackgroundImage(UIImage.init(named: "rean"), for: .normal)
        
        let rightFooBarButtonItem : UIBarButtonItem = UIBarButtonItem.init(customView: btnn)
        
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationItem.setLeftBarButton(rightFooBarButtonItem, animated: true)
        }
        
        
        if NSStringFromClass(self.classForCoder).contains("AgreeMentVC") {

            btnn.setBackgroundImage(UIImage.init(named: "back"), for: .normal)
            
            let navBar = navigationController?.navigationBar
            navBar?.barTintColor = UIColor.clear
            navBar?.isTranslucent = true

            
            CCog(message: "yes")
            view.addSubview(separatorLine)
            
        } else {
            let navBar = navigationController?.navigationBar
            navBar?.barTintColor = UIColor.clear
            navBar?.isTranslucent = true
            
            
            navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navBar?.shadowImage = UIImage()
            
            navBar?.titleTextAttributes = [
                NSForegroundColorAttributeName : UIColor.white,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            CCog(message: "no")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.frame = (UIApplication.shared.keyWindow?.rootViewController?.view.bounds)!
        }
    }
    
    @objc fileprivate func back() {
//        popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
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
