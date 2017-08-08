//
//  FriendGroupVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/24.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  好友列表(我的朋友)

import UIKit

class FriendGroupVC: BaseViewController, UITableViewDelegate, UITableViewDataSource,FriendHeaderDelegate,UISearchResultsUpdating {
    
    
    //    var tableView:UITableView
    var indexArray = [String]()
    var letterResultArr : NSMutableArray = []
    
    /// 显示数据源(非实名)
    var citys : [FriendListModel] = []
    
    /// 显示数据源(实名)
    var num_citys : [FriendListModel] = []
    
    /// 搜索数据源
    var searchTotalArray : [String] = []
    
    /// 右边按钮
    var rightBtn : UIButton = UIButton()
    
    var model_array : NSMutableArray = []
    
    
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
    
    @objc fileprivate func doneBtnSEL() {
        CCog(message: type(of: self))
    }
    
    lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        d.delegate = self
        d.dataSource = self
        d.register(NewFriend_Cell.self, forCellReuseIdentifier: "SwiftCell")
        d.register(TabViewCell.self, forCellReuseIdentifier: "PushMoneyDetailVCCell")
        return d
    }()
    
    /// 模型
    fileprivate var frienGroup_model = [FriendListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的朋友"
        
        
        view.backgroundColor = UIColor.white
        
        /// 右边按钮添加好友
        rightBtn = BigBtn.init(frame: CGRect.init(x: SCREEN_WIDTH - 20 - COMMON_MARGIN, y: 34, width: 20, height: 20))
        
        rightBtn.setImage(#imageLiteral(resourceName: "addfriend"), for: .normal)
        rightBtn.addTarget(self, action: #selector(jumpToFriend), for: .touchUpInside)
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(rightBtn)
        
        AccountModel.friend_list { (result, model) in
            if result {
                self.frienGroup_model = model
                
                var testUserArray : [FriendListModel] = []
                
                for dddd in self.frienGroup_model {
                    
                    /// 本地真实名字是否为空，若为空，则取邮箱作为名字显示
                    /// trueName不为空说明。里面的元素不是数字开头,userName开头，元素为数字开头
                    if (dddd.TrueName?.isEmpty)! {
                        self.num_citys.append(dddd)
                        testUserArray.append(dddd)
                        
                        self.searchTotalArray.append(dddd.UserName!)
                        self.citys.append(dddd)
                    } else {
                        self.searchTotalArray.append(dddd.TrueName!)
                        self.citys.append(dddd)
                    }
                    
                    
                    
                    /// 若非真实名和真实名的数组和加起来未模型的总和
                    if self.searchTotalArray.count == model.count {

                        self.indexArray = BMChineseSort.indexArray(self.searchTotalArray) as! [String]
                        CCog(message: BMChineseSort.letterSortArray(self.searchTotalArray))
                        
                        self.letterResultArr = BMChineseSort.letterSortArray(self.searchTotalArray)!
                        
                        self.model_array = BMChineseSort.sortObjectArray(self.citys, key: "TrueName")

                        var bhArray = [FriendListModel]()
                        
                        var index = 0
                        for model in self.frienGroup_model {
                            
                            for _model in self.letterResultArr {
                                
                                let array = _model as! NSArray
                                for arrayValue in array {
                                    
                                    index += 1
                                    CCog(message: arrayValue)
                                    
                                    if index == self.citys.count {
                                        return
                                    }
                                    if (dddd.UserName?.contains(arrayValue as! String))! || (dddd.TrueName?.contains(arrayValue as! String))! {
                                        bhArray.append(model)
                                        
                                        if bhArray.count == self.frienGroup_model.count {
                                        }
                                    }
                                }
                            }
                        }

                        
                        
                        
                        
                        self.view.addSubview(self.tableView)
                        self.tableView.reloadData()

                    }
                }
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rightBtn.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.rightBtn.isHidden = true
        
        countrySearchController.isActive = false
    }
    
    // MARK: - 右边按钮交互事件
    @objc fileprivate func jumpToFriend() {
        self.navigationController?.pushViewController(AddFrienVC(), animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return indexArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if countrySearchController.isActive {
            return searchArray.count
        } else {
            return (letterResultArr[section] as AnyObject).count
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        if countrySearchController.isActive {
            return [""]
        } else {
            return indexArray
        }
    }
    
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的头部
    func tableView(_ tableView:UITableView, titleForHeaderInSection
        section:Int)->String? {
        
        if countrySearchController.isActive {
            return ""
        } else {
            
            return indexArray[section]
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //设置分组尾部高度（不需要尾部，设0.0好像无效）
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        //为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "SwiftCell"
        //同一形式的单元格重复使用，在声明时已注册
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)
            as! NewFriend_Cell
        
        if countrySearchController.isActive {
            
            cell.new_descLabel.text = searchArray[indexPath.row]
            
        } else {
            let nameArray : [String] = letterResultArr[indexPath.section] as! [String]

            cell.new_descLabel.text = nameArray[indexPath.row]
            let ddd = ((self.model_array[0]) as? NSArray)?[indexPath.row] as? FriendListModel
            
            
//            var ddddddd = [FriendListModel]()
//            for _model in self.frienGroup_model {
//                CCog(message: _model.UserName)
//                CCog(message: _model.TrueName)
//                
//                
//            }
            

        }
        
        return cell
    }
    
    // MARK: - UItableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ccc = AddFriendInfoVC()
        
        //        if indexPath.section >= citys.count {
        //            ccc.add_model = num_citys[indexPath.row]
        //        } else {
        //            ccc.add_model = citys[indexPath.row]
        //        }
        self.navigationController?.pushViewController(ccc, animated: true)
    }
    
    // MARK: - 透视图交互事件
    func jumpToNewFriendVC() {
        self.navigationController?.pushViewController(NewFriendVC(), animated: true)
    }
    
    // MARK: - 实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        
        self.searchArray = []
        
        self.searchArray = self.searchTotalArray.filter { (school) -> Bool in
            
            return school.contains(searchController.searchBar.text!)
            
        }
    }
    
    //搜索过滤后的结果集
    fileprivate var searchArray:[String] = [String]() {
        didSet  {
            self.tableView.reloadData()
        }
    }
}



class BigBtn : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
