//
//  ReceiveMonVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  收款

import UIKit

class ReceiveMonVC: UIViewController {
    
    //搜索控制器
    var countrySearchController = UISearchController()
    
    //原始数据集
    let schoolArray = ["清华大学","北京大学","中国人民大学","北京交通大学","北京工业大学",
                       "北京航空航天大学","北京理工大学","北京科技大学","中国政法大学",
                       "中央财经大学","华北电力大学","北京体育大学","上海外国语大学","复旦大学",
                       "华东师范大学","上海大学","河北工业大学"]
    
    //搜索过滤后的结果集
    var searchArray:[String] = [String](){
        didSet  {
            self.tableView.reloadData()
            self.view.endEditing(true)
        }
    }
    
    
    // MARK: - 数据源
    var dataSource : [String] = ["转给朋友","转到其他网博币钱包","转到交易平台","转到会员平台"]
    
    // MARK: - 最近转的
    var recentDeals : [String] = ["sads"]
    
    lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self
        d.dataSource = self
        //创建一个重用的单元格
        d.register(ReceiveCell.self,
                   forCellReuseIdentifier: "MyCell")
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        
        DispatchQueue.main.async {
            //配置搜索控制器
            self.countrySearchController = ({
                let controller = UISearchController(searchResultsController: nil)
                controller.searchResultsUpdater = self   //两个样例使用不同的代理
                controller.hidesNavigationBarDuringPresentation = false
                controller.dimsBackgroundDuringPresentation = false
                //            controller.searchBar.searchBarStyle = .minimal
                controller.searchBar.placeholder = "搜索"
                controller.searchBar.sizeToFit()
                self.tableView.tableHeaderView = controller.searchBar
                
                return controller
            })()
            
            
        }
        
        if #available(iOS 9.0, *) {
            self.countrySearchController.loadViewIfNeeded()
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
        
    }
}


extension ReceiveMonVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "MyCell"
            //同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCell(withIdentifier: identify,
                                                     for: indexPath) as! ReceiveCell
            
            if self.countrySearchController.isActive {
                cell.descLabel.text = self.searchArray[indexPath.row]
                return cell
            } else {
                switch indexPath.section {
                case 0:
                    cell.descLabel.text = dataSource[indexPath.row]
                case 1:
                    cell.descLabel.text = recentDeals[indexPath.row]
                    break
                default:
                    break
                }
                
                return cell
            }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if recentDeals.count > 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.countrySearchController.isActive {
            return self.searchArray.count
        } else {
            switch section {
            case 0:
                return dataSource.count
                
            case 1:
                return recentDeals.count
            default:
                break
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.0000001
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "最近"
            
        default:
            break
        }
        return ""
    }
}

extension ReceiveMonVC: UISearchResultsUpdating
{
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        self.searchArray = self.schoolArray.filter { (school) -> Bool in
            return school.contains(searchController.searchBar.text!)
        }
    }
}
