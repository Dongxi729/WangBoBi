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
    
    var adHeaders:[String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var dataSource : [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z","Z"]
    
    
    var cityGroups = [String: [String]]()
    var groupTitles = [String]()
    
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
    
    lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        d.delegate = self
        d.dataSource = self
        d.register(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")
        d.register(TabViewCell.self, forCellReuseIdentifier: "PushMoneyDetailVCCell")
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的朋友"
        
        self.view.addSubview(self.tableView)
        
        /// 头视图
        let headerView = FriendHeader.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        
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
        
        makeCityToGroup()
        
    }
    
    var citys = ["北京市", "上海市", "天津市", "重庆市","铜陵市", "明光市", "天长市", "宁国市","宁国市","宁国市","宁国市","宁国市","宁国市","宁国市","宁国市","宁国市","宁国市","宁国市","宁国市","宁国市","宁国市","宁国市","宁国市","宁国市","宁国市","宁国市", "界首市", "桐城市", "广州市", "韶关市", "深圳市", "珠海市", "汕头市", "佛山市", "江门市", "湛江市", "茂名市", "肇庆市", "惠州市", "梅州市", "汕尾市", "河源市", "阳江市", "清远市", "东莞市", "中山市", "潮州市", "揭阳市", "云浮市", "昆明市", "曲靖市", "玉溪市", "保山市", "昭通市", "丽江市", "思茅市", "临沧市", "楚雄彝族自治州", "红河哈尼族彝族自治州", "文山壮族苗族自治州", "西双版纳傣族自治州", "大理白族自治州", "德宏傣族景颇族自治州", "怒江傈僳族自治州", "迪庆藏族自治州"]
    
    func makeCityToGroup() {
        
        // 遍历citys数组中的所有城市
        for city in citys {
            
            // 将中文转换为拼音
            let cityMutableString = NSMutableString(string: city)
            CFStringTransform(cityMutableString, nil, kCFStringTransformToLatin, false)
            CFStringTransform(cityMutableString, nil, kCFStringTransformStripDiacritics, false)
            
            // 拿到首字母作为key
            let firstLetter = cityMutableString.substring(to: 1).uppercased()
            
            // 检查是否有firstLetter对应的分组存在, 有的话直接把city添加到对应的分组中
            // 没有的话, 新建一个以firstLetter为key的分组
            if var value = cityGroups[firstLetter] {
                value.append(city)
                cityGroups[firstLetter] = value
            }
            else {
                cityGroups[firstLetter] = [city]
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
    @objc fileprivate func jumpToFriend(){
        self.navigationController?.pushViewController(AddFrienVC(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
            as UITableViewCell
        
        let firstLetter = groupTitles[indexPath.section]
        let citysInAGroup = cityGroups[firstLetter]!
        
        if countrySearchController.isActive {
            
            cell.textLabel?.text = searchArray[indexPath.row]
            self.countrySearchController.searchBar.resignFirstResponder()
            
        } else {
            cell.textLabel?.text = citysInAGroup[indexPath.row]
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
        
        //        CCog(message: self.citys.filter({ (sc) -> Bool in
        //            return sc.contains(searchController.searchBar.text!)
        //        }))
    
    }
    
    //搜索过滤后的结果集
    fileprivate var searchArray:[String] = [String](){
        didSet  {
            self.tableView.reloadData()
        }
    }
}

protocol FriendHeaderDelegate {
    func jumpToNewFriendVC()
}

/// 我的朋友表格头视图
class FriendHeader: UIView {
    
    
    var delegate : FriendHeaderDelegate?
    
    lazy var headIcon: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN * 0.5, width: self.Height - COMMON_MARGIN, height: self.Height - COMMON_MARGIN))
        d.image = #imageLiteral(resourceName: "addFriIcon")
        return d
    }()
    
    lazy var descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.headIcon.RightX + COMMON_MARGIN, y: self.headIcon.TopY, width: SCREEN_WIDTH - 2 * COMMON_MARGIN - self.headIcon.Width, height: self.headIcon.Height))
        d.text = "新的朋友"
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headIcon)
        addSubview(descLabel)
        self.backgroundColor = UIColor.white
        
        self.isUserInteractionEnabled = true
        
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(tapSEL))
        self.addGestureRecognizer(tapGes)
    }
    
    // MARK: - 交互事件
    @objc fileprivate func tapSEL() {
        self.delegate?.jumpToNewFriendVC()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
