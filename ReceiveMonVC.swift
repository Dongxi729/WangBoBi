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
    fileprivate let schoolArray = ["清华大学","北京大学","中国人民大学","北京交通大学","北京工业大学",
                                   "北京航空航天大学","北京理工大学","北京科技大学","中国政法大学",
                                   "中央财经大学","华北电力大学","北京体育大学","上海外国语大学","复旦大学",
                                   "华东师范大学","上海大学","河北工业大学"]
    
    //搜索过滤后的结果集
    fileprivate var searchArray:[String] = [String](){
        didSet  {
            self.tableView.reloadData()
            //            self.view.endEditing(true)
        }
    }
    
    /// 朋友列表
    fileprivate var mertopModel = [NewFriendListModel]()
    
    
    /// 搜索的数据源
    var sercchArray : [String] = []
    
    /// 显示页数
    fileprivate var limitCount : Int = 0
    
    // MARK: - 数据源
    fileprivate var dataSource : [String] = ["转给朋友","转到其他网博币钱包"]
    
    // MARK: - 前置图标
    fileprivate var frontIconImg : [UIImage] = [#imageLiteral(resourceName: "ofri"),#imageLiteral(resourceName: "owbag")]
    
    
    // MARK: - 最近转的
    var recentDeals : [String] = ["sads"]
    
    lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self
        d.dataSource = self
        //创建一个重用的单元格
        d.register(ReceiveCell.self,
                   forCellReuseIdentifier: "MyCell")
        d.register(FriendCell.self, forCellReuseIdentifier: "CCCC")
        return d
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            
            UIApplication.shared.statusBarStyle = .default
            
            let navBar = self.navigationController?.navigationBar
            
            navBar?.barTintColor = UIColor.white
            self.navigationController?.navigationBar.isTranslucent = false
            
            /// 修改导航栏文字样式（富文本）
            navBar?.titleTextAttributes = [
                
                NSForegroundColorAttributeName : UIColor.black,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            /// 设置
            navBar?.tintColor = UIColor.white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "转账"
        
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
        
        
        AccountModel.GetFriendList(String(limitCount), "10") { (result, model) in
            self.mertopModel = model
            CCog(message: self.mertopModel.count)
            self.tableView.reloadData()
            
            for value in model {
                self.sercchArray.append(value.UserName!)
            }
        }
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
            switch indexPath.section {
            case 0:
                cell.descLabel.text = dataSource[indexPath.row]
                cell.imgVi.image = frontIconImg[indexPath.row]
            case 1:
                
                //同一形式的单元格重复使用，在声明时已注册
                let cell = tableView.dequeueReusableCell(withIdentifier: "CCCC",
                                                         for: indexPath) as! FriendCell
                
                cell.stangerLabel.isHidden = false
                
                cell.model = self.mertopModel[indexPath.row]
                
                CCog(message: "===")
                
                break
            default:
                break
            }
            
            return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.countrySearchController.isActive {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case indexPath.section:
            switch indexPath.row {
                /// 朋友
            case 0:
                self.navigationController?.pushViewController(FriendGroupVC(), animated: true)
                
                ///网博币钱包--- 缺少页面
//            case 1:
//                self.navigationController?.pushViewController(UIViewController(), animated: true)
            default:
                break
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return dataSource.count
        } else {
            
            if self.countrySearchController.isActive {
                return self.searchArray.count
            } else {
                return self.mertopModel.count
            }
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
            return "最近交易"
            
        default:
            break
        }
        return ""
    }
}

// MARK: - 搜索代理方法
extension ReceiveMonVC: UISearchResultsUpdating {
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        self.searchArray = self.schoolArray.filter { (school) -> Bool in
            return school.contains(searchController.searchBar.text!)
        }
    }
}
