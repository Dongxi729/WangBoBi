//
//  MyViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  我的

import UIKit

class MyViewController: UIViewController {
    
    var cellDataSource : [String : [String]] = ["sectionOne" : [],
                                                "sectionTwo" : ["账户与安全"],
                                                "sectionThree" : ["我的银行卡","绑定手机","我的申述","我的消息"]]
    
    /// 表格
    lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self
        d.dataSource = self
        d.register(UITableViewCell.self, forCellReuseIdentifier: "cel")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cel")
        
        switch indexPath.section {
        case 0:
            
            break
        case 1:
            cell?.textLabel?.text = cellDataSource["sectionTwo"]?.first!
            break
        case 2:
            cell?.textLabel?.text = cellDataSource["sectionThree"]?[indexPath.row]
            break
        default:
            break
        }
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return (cellDataSource["sectionTwo"]?.count)!
            
        case 2:
            return (cellDataSource["sectionThree"]?.count)!
        default:
            return 0
        }
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
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(TestViewController(), animated: true)
            }
            break
        default:
            break
        }
    }
    
}
