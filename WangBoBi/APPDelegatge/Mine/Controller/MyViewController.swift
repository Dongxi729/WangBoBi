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
                                                "sectionFour" : ["地址管理"]]
    
    /// 表格
    lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: .grouped)
        d.delegate = self
        d.dataSource = self
        d.register(TabViewCell.self, forCellReuseIdentifier: "cel")
        d.register(MyVCCell.self, forCellReuseIdentifier: "MyVCCell")
        
        d.separatorStyle = UITableViewCellSeparatorStyle.none
        
        return d
    }()
    
    
    
    
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
                return cell
            case 1:
                cell.descLabel.text = cellDataSource["sectionOne"]?[indexPath.row]
                
            default:
                break
            }
            
        case 1:
            cell.descLabel.text = cellDataSource["sectionThree"]?[indexPath.row]
            break
        case 2:
            
            cell.descLabel.text = cellDataSource["sectionFour"]?[indexPath.row]
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
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 80 * SCREEN_SCALE
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
            if indexPath.row == 0 {
                
            }
            
            break
            
        case 1 :
            if indexPath.row == 0 {
                
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(AccountAndSaveVC(), animated: true)
                }
            }
            break
        case 2:

            switch indexPath.row {
                /// 我的银行卡
            case 0:
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(MyBandCardVC(), animated: true)
                }
                break
                /// 绑定手机
            case 1:
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(BindPhoneVC(), animated: true)
                }
                break
                ///  我的申述
            case 2:
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(MyRequestVC(), animated: true)
                }
                break
                ///  我的消息
            case 3:
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(MyMsgVC(), animated: true)
                }
                break
            default:
                break
            }
            
            
            break
        default:
            break
        }
    
    }
    
}
