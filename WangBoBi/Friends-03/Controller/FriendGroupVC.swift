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

    var groupTitles = [String]()
    var headImgTitles = [String]()
    var wbcTitles = [String]()
    
    /// 搜索源
    var citys : [String] = []
    var headImgs : [String] = []
    var wbcArray : [String] = []
    
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
        
        self.view.addSubview(self.tableView)
        
        view.backgroundColor = UIColor.white
        

        /// 右边按钮添加好友
        rightBtn = BigBtn.init(frame: CGRect.init(x: SCREEN_WIDTH - 20 - COMMON_MARGIN, y: 34, width: 20, height: 20))
        
        rightBtn.setImage(#imageLiteral(resourceName: "addfriend"), for: .normal)
        rightBtn.addTarget(self, action: #selector(jumpToFriend), for: .touchUpInside)
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(rightBtn)
        
        let dddd : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 112))
        dddd.backgroundColor = COMMON_TBBGCOLOR
        dddd.addSubview(countrySearchController.searchBar)
        
        let foV = FriendHeader.init(frame: CGRect.init(x: 0, y: countrySearchController.searchBar.BottomY + COMMON_MARGIN * 0.5, width: SCREEN_WIDTH, height: 64))
        foV.delegate = self
        dddd.addSubview(foV)
        
        /// 添加搜索栏
        self.tableView.tableHeaderView = dddd
        
        AccountModel.friend_list { (result, model) in
            if result {
                self.frienGroup_model = model
                
                for dddd in self.frienGroup_model {
                    
                    if dddd.TrueName?.characters.count == 0 {
                        self.citys.append(dddd.UserName!) /// headImgs
                        
                    } else {
                        self.citys.append(dddd.TrueName!)
                    }
                    
                    self.headImgs.append(dddd.HeadImg!)
                    self.wbcArray.append(dddd.WBCAdress!)
                    
                    if self.citys.count == self.frienGroup_model.count {
                        DispatchQueue.main.async {
                            
                            self.makeCityToGroup()
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    /// 提取数据源的第一个字幕
    func makeCityToGroup() {
        
        // 遍历citys数组中的所有城市
        for city in citys {
            
            if city.characters.count > 0 {
                // 将中文转换为拼音
                let cityMutableString = NSMutableString(string: city)
                CFStringTransform(cityMutableString, nil, kCFStringTransformToLatin, false)
                CFStringTransform(cityMutableString, nil, kCFStringTransformStripDiacritics, false)
                
                
                if cityMutableString.length > 0 {
                    
                    // 拿到首字母作为key
                    var firstLetter = cityMutableString.substring(to: 1).uppercased()
                    
                    if !firstLetter.checkIsNumber() {
                        firstLetter = "#"
                    }
            
                    if var value = cityGroups[firstLetter] {
                        
                        value.append(city)
                        cityGroups[firstLetter] = value
                    } else {
                        cityGroups[firstLetter] = [city]
                    }
                }
            }
        }
        //拿到所有的key将它排序, 作为每个组的标题
        groupTitles = cityGroups.keys.sorted()
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
            return cityGroups.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if countrySearchController.isActive {
            return searchArray.count
        } else {
            let firstLetter = groupTitles[section]
            
            return cityGroups[firstLetter]!.count
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        if countrySearchController.isActive {
            return [""]
        } else {
            return groupTitles
        }
    }
    
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的头部
    func tableView(_ tableView:UITableView, titleForHeaderInSection
        section:Int)->String?
    {
        
        if countrySearchController.isActive {
            return ""
        } else {
            return groupTitles[section]
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
        
        
        let firstLetter = groupTitles[indexPath.section]
        let citysInAGroup = cityGroups[firstLetter]!
        
        if countrySearchController.isActive {
            
            cell.new_descLabel.text = searchArray[indexPath.row]
            
        } else {
            
            cell.new_descLabel.text = citysInAGroup[indexPath.row]
            cell.ne_imgVi.setImage(urlString: self.frienGroup_model[indexPath.row].HeadImg, placeholderImage: #imageLiteral(resourceName: "logo"))
            cell.ne_bottomLabel.text = self.frienGroup_model[indexPath.row].WBCAdress
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
        
        self.searchArray = self.citys.filter { (school) -> Bool in
            
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
