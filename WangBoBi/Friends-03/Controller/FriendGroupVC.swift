//
//  FriendGroupVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/24.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  好友列表(我的朋友)

import UIKit

class FriendGroupVC: BaseViewController, UITableViewDelegate, UITableViewDataSource,FriendHeaderDelegate,UISearchResultsUpdating {
    
    //    var tableView:UITableView?
    var cityGroups = [String: [String]]()
    var cityGroups2 = [String: [String]]()

    var groupTitles = [String]()
    var groupTitles2 = [String]()
    var wbcTitles = [String]()
    
    /// 搜索源
    var citys : [FriendListModel] = []
    
    var num_citys : [FriendListModel] = []
    
    /// 右边按钮
    var rightBtn : UIButton = UIButton()
    
    
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
                        
                    } else {
                        self.citys.append(dddd)
                    }
                    
                    /// 若非真实名和真实名的数组和加起来未模型的总和
                    if testUserArray.count + self.citys.count == model.count {
                        
                        CCog(message: self.citys)
                        
                        self.makeCityToGroup({ (result) in
                            if result {
                                
                                self.makeCityToGroup2({ (result2) in
                                    if result2 {
                                        
                                        self.num_citys = testUserArray
                                        self.view.addSubview(self.tableView)
                                        self.tableView.reloadData()
                                        /// 添加搜索栏
                                        /// 添加搜索栏
                                        let dddd : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 112))
                                        dddd.backgroundColor = COMMON_TBBGCOLOR
                                        dddd.addSubview(self.countrySearchController.searchBar)
                                        
                                        /// 添加搜索栏
                                        self.tableView.tableHeaderView = dddd
                                        
                                        /// 添加新的好友制定
                                        let foV = FriendHeader.init(frame: CGRect.init(x: 0, y: self.countrySearchController.searchBar.BottomY + COMMON_MARGIN * 0.5, width: SCREEN_WIDTH, height: 64))
                                        foV.delegate = self
                                        dddd.addSubview(foV)
                                    }
                                })
                            }
                        })
                    }
                }
            }
        }
    }
    
    /// 提取数据源的第一个字幕
    func makeCityToGroup(_ finished : (_ isFinished : Bool) -> ()) {
        
        // 遍历citys数组,排列非数字开头的数组
        for city in citys {
            
            if city.TrueName?.characters.count > 0 {
                // 将中文转换为拼音
                let cityMutableString = NSMutableString(string: city.TrueName!)
                CFStringTransform(cityMutableString, nil, kCFStringTransformToLatin, false)
                CFStringTransform(cityMutableString, nil, kCFStringTransformStripDiacritics, false)
                
                
                if cityMutableString.length > 0 {
                    
                    // 拿到首字母作为key
                    let firstLetter = cityMutableString.substring(to: 1).uppercased()

                    if var value = cityGroups[firstLetter] {
                        
                        value.append(city.TrueName!)
                        cityGroups[firstLetter] = value
                    } else {
                        cityGroups[firstLetter] = [city.TrueName!]
                    }
                }
            }
        }
        //拿到所有的key将它排序, 作为每个组的标题
        groupTitles = cityGroups.keys.sorted()
        finished(true)
    }
    
    /// 提取数据源的第一个字幕
    func makeCityToGroup2(_ finished : (_ isFinished : Bool) -> ()) {
        
        // 遍历citys数组,排列非数字开头的数组
        for city in num_citys {
            
            if city.UserName?.characters.count > 0 {
                // 将中文转换为拼音
                let cityMutableString = NSMutableString(string: city.UserName!)
                CFStringTransform(cityMutableString, nil, kCFStringTransformToLatin, false)
                CFStringTransform(cityMutableString, nil, kCFStringTransformStripDiacritics, false)
            
                if cityMutableString.length > 0 {
                    
                    // 拿到首字母作为key
                    var firstLetter = cityMutableString.substring(to: 1).uppercased()
                    
                    if !firstLetter.checkIsNumber() {
                        firstLetter = "#"
                    }
                    
                    if var value = cityGroups2[firstLetter] {
                        
                        value.append(city.UserName!)
                        cityGroups2[firstLetter] = value
                    } else {
                        cityGroups2[firstLetter] = [city.UserName!]
                    }
                }
            }
        }
        //拿到所有的key将它排序, 作为每个组的标题
        groupTitles2 = cityGroups2.keys.sorted()
        groupTitles2.append(contentsOf: groupTitles)
        groupTitles2 = groupTitles2.reversed()
        finished(true)
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
    
    
    // MARK: - UItableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ccc = AddFriendInfoVC()
        ccc.add_model = frienGroup_model[indexPath.section]
        self.navigationController?.pushViewController(ccc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.countrySearchController.isActive {
            return 1
        } else {
            /// 暂时返回两组数组(数字开头和非数字开头的)
            return groupTitles2.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if countrySearchController.isActive {
            return searchArray.count
        } else {
            
            ///
            if section >= citys.count {
                CCog(message: num_citys.count)
                return num_citys.count
            } else {
                CCog(message: citys.count)
                return citys.count
            }
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        if countrySearchController.isActive {
            return [""]
        } else {
            return groupTitles2
        }
    }
    
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的头部
    func tableView(_ tableView:UITableView, titleForHeaderInSection
        section:Int)->String? {
        
        if countrySearchController.isActive {
            return ""
        } else {

            return groupTitles2[section]
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
            ///
            if indexPath.section >= citys.count {
                CCog(message: num_citys.count)
                cell.ne_imgVi.setImage(urlString: num_citys[indexPath.row].HeadImg, placeholderImage: #imageLiteral(resourceName: "logo"))
                cell.ne_bottomLabel.text = num_citys[indexPath.row].WBCAdress
                cell.new_descLabel.text = num_citys[indexPath.row].UserName
            } else {
                
                CCog(message: citys.count)
                cell.ne_imgVi.setImage(urlString: citys[indexPath.row].HeadImg, placeholderImage: #imageLiteral(resourceName: "logo"))
                cell.ne_bottomLabel.text = citys[indexPath.row].WBCAdress
                cell.new_descLabel.text = citys[indexPath.row].TrueName
            }
        }
        
        return cell
    }
    
    // MARK: - 透视图交互事件
    func jumpToNewFriendVC() {
        self.navigationController?.pushViewController(NewFriendVC(), animated: true)
    }
    
    // MARK: - 实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        
        self.searchArray = []
        
//        self.searchArray = self.citys.filter { (school) -> Bool in
//            
//            return school.contains(searchController.searchBar.text!)
//        }
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
