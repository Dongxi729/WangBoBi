//
//  MyViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  我的视图

import UIKit

class MyViewController: UIViewController {
    
    var cellDataSource : [String : [String]] = ["sectionOne" : ["","我的二维码"],
                                                "sectionThree" : ["账户与安全","绑定手机","我的申述","我的消息"],
                                                "sectionImg" : ["Mine_Three","Mine_Four","Mine_Five","Mine_Six"],
                                                "sectionFour" : ["地址管理"],
                                                "secFourIMg" : ["Mine_add"]]
    
    /// 表格
    lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: -1, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .grouped)
        d.delegate = self
        d.dataSource = self
        d.register(TabViewCell.self, forCellReuseIdentifier: "cel")
        d.register(MyVCCell.self, forCellReuseIdentifier: "MyVCCell")

        return d
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        self.navigationController?.navigationBar.barTintColor = UIColor.colorWithHexString("2796DD")
        
        let navBar = self.navigationController?.navigationBar
        navBar?.isTranslucent = false
        navBar?.barStyle = UIBarStyle.black
        navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar?.shadowImage = UIImage()
        navBar?.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white,
            
            NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
        ]
        
        
        /// 设置
        navBar?.tintColor = UIColor.white

    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        let navBar = self.navigationController?.navigationBar
        navBar?.isTranslucent = false
        navBar?.shadowImage = UIImage()
        navBar?.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.black,
            
            NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
        ]
        
        
        /// 设置
        navBar?.tintColor = UIColor.white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的"
        
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
    }
}


// MARK: - 表格方法
extension MyViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cel") as! TabViewCell

        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyVCCell") as! MyVCCell
                
//                cell.preservesSuperviewLayoutMargins = false
//                cell.separatorInset = UIEdgeInsets.zero
//                cell.layoutMargins = UIEdgeInsets.zero
                
                cell.backgroundColor = UIColor.colorWithHexString("2796DD")

                return cell
            case 1:
                
                cell.descLabel.text = cellDataSource["sectionOne"]?[indexPath.row]
      
            default:
                break
            }
            
        case 1:
            cell.descLabel.text = cellDataSource["sectionThree"]?[indexPath.row]
            cell.frontIconim.image = UIImage.init(named: (cellDataSource["sectionImg"]?[indexPath.row])!)
            break
        case 2:
            
            
            cell.descLabel.text = cellDataSource["sectionFour"]?[indexPath.row]
//            secFourIMg
            cell.frontIconim.image = UIImage.init(named: (cellDataSource["secFourIMg"]?[indexPath.row])!)
            break

        default:
            break
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellDataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return (cellDataSource["sectionThree"]?.count)!
        case 2:
            return (cellDataSource["sectionFour"]?.count)!
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        let deviceType = UIDevice.current.deviceType
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
//                if deviceType == .iPhone4S {
//                    return 80
//                } else {
                    return 80 * SCREEN_SCALE
//                }
                
            default:
                return 45
            }
            
        default:
            break
        }
        
        return 45
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
        switch indexPath.section {
        case 0:
            
            /// 我的信息
            if indexPath.row == 0 {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(MyInfoVC(), animated: true)
                }
            }
            
            if indexPath.row == 1 {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(CodeProductor(), animated: true)
                }
            }
            
            break
            
        case 1 :
            /// 账户和安全
            if indexPath.row == 0 {
                
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(AccountAndSaveVC(), animated: true)
                }
            }
            
            /// 绑定手机
            if indexPath.row == 1 {
                
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(BindPhoneVC(), animated: true)
                }
            }
            
            
            break

        default:
            break
        }
    
    }
    
}
