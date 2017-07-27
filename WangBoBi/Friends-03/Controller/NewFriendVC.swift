//
//  NewFriendVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/24.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  新的朋友

import UIKit

class NewFriendVC: BaseViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating {
    
    

    fileprivate lazy var tableView: UITableView = {
//        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: .grouped)
        d.delegate = self
        d.dataSource = self
        d.register(NewFriendCell.self, forCellReuseIdentifier: "NewFriendCell")
        return d
    }()
    
    /// 搜索控制器
    fileprivate lazy var countrySearchController: UISearchController = {
        let d : UISearchController = UISearchController.init(searchResultsController: nil)
        d.searchResultsUpdater = self   //两个样例使用不同的代理
        d.hidesNavigationBarDuringPresentation = false
        d.dimsBackgroundDuringPresentation = false
        d.searchBar.subviews.first?.subviews.first?.removeFromSuperview()
        d.searchBar.placeholder = "搜索"
        d.searchBar.sizeToFit()
        return d
    }()
    
    //原始数据集
    fileprivate let schoolArray = ["清华大学","北京大学","中国人民大学","北京交通大学","北京工业大学",
                                   "北京航空航天大学","北京理工大学","北京科技大学","中国政法大学",
                                   "中央财经大学","华北电力大学","北京体育大学","上海外国语大学","复旦大学",
                                   "华东师范大学","上海大学","河北工业大学"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "新的朋友"
        
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        
        tableView.tableHeaderView = countrySearchController.searchBar
        
        if #available(iOS 9.0, *) {
            self.countrySearchController.loadViewIfNeeded()
        } else {
            // Fallback on earlier versions
        }
    }
    
    // MARK: - UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewFriendCell") as! NewFriendCell
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = .zero
        
        
        if self.countrySearchController.isActive {
            cell.new_descLabel.text = self.searchArray[indexPath.row]
            
            self.countrySearchController.searchBar.resignFirstResponder()
            return cell
            
        } else {
            cell.new_descLabel.text = self.schoolArray[indexPath.row]
            
            return cell
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "新的朋友"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2 * COMMON_MARGIN
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.countrySearchController.isActive {
            return self.searchArray.count
        } else {
            return schoolArray.count
        }
    }
    
    //搜索过滤后的结果集
    fileprivate var searchArray:[String] = [String](){
        didSet  {
            self.tableView.reloadData()
        }
    }

    
    // MARK: - searchDelegate
    // MARK: - 实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        
        self.searchArray = []
        
        self.searchArray = self.schoolArray.filter { (school) -> Bool in
            
            return school.contains(searchController.searchBar.text!)
        }
    }

}

