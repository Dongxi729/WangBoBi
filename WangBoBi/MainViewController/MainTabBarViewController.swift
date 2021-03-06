//
//  MainTabBarViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  总控制器

import UIKit

class MainTabBarViewController: BaseTabbarVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setUpSubViews()
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,selector:#selector(dddddd) , name: Notification.Name.UIApplicationWillChangeStatusBarFrame, object: nil)
        
        NotificationCenter.default.addObserver(self,selector:#selector(DDDDDD) , name: Notification.Name.UIApplicationDidChangeStatusBarFrame, object: nil)
    }
    
    func dddddd() -> Void {
        CCog(message: "UIApplicationWillChangeStatusBarFrame")
    }
    
    
    func DDDDDD() -> Void {
        CCog(message: "UIApplicationWillChangeStatusBarFrame")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let rect = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 20)

        if UIApplication.shared.statusBarFrame != rect {
            self.view.frame.origin.y = 20

            self.view.frame.size.height = SCREEN_HEIGHT - 20
        } else {
            self.view.frame.origin.y = 0
            self.view.frame.size.height = SCREEN_HEIGHT
        }
    }

    fileprivate func setUpSubViews() -> Void {
        
        //首页
        let mainPageVC = JFNavigationController.init(rootViewController: MainPageViewController())
        
        let view = UIViewController()
        view.view.backgroundColor = UIColor.white
        //商户
        let shopVc = JFNavigationController.init(rootViewController: ShopWebV())
        
        //朋友
        let friendVc = JFNavigationController.init(rootViewController: FriendMainVC())
        
        //我的模块
        let meVC = JFNavigationController.init(rootViewController: MyViewController())
        
        
        self.setupChildVC(mainPageVC, title: "钱包", imageName: "icon1", selectImageName: "icon1_on")
        
        self.setupChildVC(shopVc, title: "商户", imageName: "icon2", selectImageName: "icon2_on")
        
        self.setupChildVC(friendVc, title: "朋友", imageName: "icon3", selectImageName: "icon3_on")
        
        self.setupChildVC(meVC, title: "我的", imageName: "icon4", selectImageName: "icon4_on")
        
        ///设置tabbar选择的图片
        let img = UIImage.init()
        self.tabBar.selectionIndicatorImage = img.scaleToSize(img: #imageLiteral(resourceName: "tabbarSelected"), size: CGSize.init(width: SCREEN_WIDTH / 4, height: 44))
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
