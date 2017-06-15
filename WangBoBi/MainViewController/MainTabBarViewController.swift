//
//  MainTabBarViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class MainTabBarViewController: BaseTabbarVC {
    
    var myWindow: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        ///禁用tabbar的透明效果
        self.tabBar.isTranslucent = false
        
        self.setUpSubViews()
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
}


// MARK:- 设置子界面
extension MainTabBarViewController {
    fileprivate func setUpSubViews() -> Void {
        
        //首页
        let mainPageVC = JFNavigationController.init(rootViewController: UIViewController())
        
        //订单
        let shopVc = JFNavigationController.init(rootViewController: UIViewController())
        
        //我的模块
        let meVC = JFNavigationController.init(rootViewController: UIViewController())
        
        
        self.setupChildVC(mainPageVC, title: "首页", imageName: "home_on", selectImageName: "home")
        
        self.setupChildVC(shopVc, title: "订单", imageName: "detail", selectImageName: "detail_on")
        
        self.setupChildVC(meVC, title: "我的", imageName: "mine_on", selectImageName: "mine")
        
        ///设置tabbar选择的图片
        let img = UIImage.init()
        self.tabBar.selectionIndicatorImage = img.scaleToSize(img: #imageLiteral(resourceName: "selected"), size: CGSize.init(width: SCREEN_WIDTH / 3, height: 44))
    }
    
    
    //添加子页面
    func setupChildVC(_ childVC: UIViewController,title: String,imageName: String,selectImageName: String) {
        
        childVC.title = title
        childVC.tabBarItem.image = UIImage.init(named: imageName)
        //        不在渲染图片
        childVC.tabBarItem.selectedImage = UIImage.init(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        
        self.addChildViewController(childVC)
    }
}
