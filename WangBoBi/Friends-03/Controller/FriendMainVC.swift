//
//  FriendMainVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/24.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  朋友

import UIKit

class FriendMainVC: BaseViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,FriendMainVHeaVDelegate,headerViewelegate {
    
    lazy var groudFriend: UIBarButtonItem = {
        let d : UIBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "groupFir"), style: .plain, target: self, action: #selector(jumpToFriendContactVC))
        return d
    }()
    
    /// 朋友按钮右一
    lazy var firend: UIBarButtonItem = {
        let d : UIBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "friend"), style: .plain, target: self, action: #selector(jumpToFriend))
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
    
    /// 朋友列表
    var mertopModel = [FriendMainListModel]()
    
    /// 显示页数
    fileprivate var limitCount : Int = 0
    
    /// 显示更多
    fileprivate lazy var headV: FriendMainVHeaV = {
        let d : FriendMainVHeaV = FriendMainVHeaV.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 30))
        d.delegate = self
        return d
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "朋友"
        
        self.navigationItem.rightBarButtonItems = [firend,groudFriend]
        
        self.tableView.tableHeaderView = countrySearchController.searchBar
        
        if #available(iOS 9.0, *) {
            self.countrySearchController.loadViewIfNeeded()
        } else {
            // Fallback on earlier versions
        }
        
        /// 添加表格
        view.addSubview(tableView)
        
//        AccountModel.GetFriendList(String(limitCount), "10") { (result, model) in
//            self.mertopModel = model
//        }
        tableView.tableFooterView = headV
        
        view.backgroundColor = UIColor.white
        
    }
    
    // MARK: - 按钮事件
    @objc fileprivate func jumpToFriend() {
        self.navigationController?.pushViewController(AddFrienVC(), animated: true)
    }
    
    @objc fileprivate func jumpToFriendContactVC() {
        self.navigationController?.pushViewController(FriendGroupVC(), animated: true)
    }
    
    //原始数据集
    private var frien_datasource = ["清华大学","北京大学","中国人民大学","北京交通大学","北京工业大学",
                                   "北京航空航天大学","北京理工大学","北京科技大学","中国政法大学",
                                   "中央财经大学","华北电力大学","北京体育大学","上海外国语大学","复旦大学",
                                   "华东师范大学","上海大学","河北工业大学"]
    
    /// 模型
    var modelData = [FriendListModel]()
    
    /// 模拟数据
    fileprivate let analogueData : [String : Any] = ["moneyCount" : "-90","dateTime" : "12-30","descStr" : "链接杀戮空间","isSend" : "true","friendName" : "john"]
    //
    //搜索过滤后的结果集
    fileprivate var searchArray:[String] = [String](){
        didSet  {
            self.tableView.reloadData()
        }
    }
    
    /// 最近转的
    var recentDeals : [String] = ["sads"]
    
    lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 50 - 64), style: .grouped)
        d.delegate = self
        d.dataSource = self
        //创建一个重用的单元格
        d.register(FriendCell.self,
                   forCellReuseIdentifier: "MyCell")
        
        
        
        return d
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// 模拟数据
        self.modelData = [FriendListModel.init(dict: analogueData)]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
        
        tableView.addHeaderViewfun()
        let foot : headerView = tableView.viewWithTag(888) as! headerView
        foot.delegate = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "MyCell"
            //同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCell(withIdentifier: identify,
                                                     for: indexPath) as! FriendCell
            
            /// 延长分割线
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = .zero
            
            cell.stangerLabel.isHidden = false
            
            cell.model = FriendListModel.init(dict: analogueData)
            
            if self.countrySearchController.isActive {
                cell.descLabel.text = self.searchArray[indexPath.row]
                
                self.countrySearchController.searchBar.resignFirstResponder()
                return cell
                
            } else {
                cell.descLabel.text = self.frien_datasource[indexPath.row]
                
                return cell
            }
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.pushViewController(PushMoneyDetailVC(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.countrySearchController.isActive {
            return self.searchArray.count
        } else {
            CCog(message: frien_datasource.count)
            return frien_datasource.count
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    // MARK: - 实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        self.searchArray = self.frien_datasource.filter { (school) -> Bool in
            return school.contains(searchController.searchBar.text!)
        }
    }
    
    // MARK: - FriendMainVHeaVDelegate
    func main_load() {
        limitCount += 1
        AccountModel.GetFriendList(String(limitCount), "10") { (result, model) in
            if result {
                self.tableView.reloadData()
            }
        }
        
//        let dformatter = DateFormatter()
//        dformatter.dateFormat = "HH:mm:ss"
//        
//        //        frien_datasource.append(contentsOf: ["dssaada","dsdasdsada","asdsd"])
//        frien_datasource.insert(dformatter.string(from: Date()), at: frien_datasource.count)
//        self.tableView.reloadData()
    }
    
    func headerViewEndfun(_ _endRefresh: () -> Void) {
        let dd : headerView = self.tableView.viewWithTag(888) as! headerView
        dd.endRefresh()
        CCog(message: "")
        
//        let dformatter = DateFormatter()
//        dformatter.dateFormat = "HH:mm:ss"
//
//        frien_datasource.insert(dformatter.string(from: Date()), at: 0)
//        self.tableView.reloadData()
        
        AccountModel.GetFriendList("1", "10") { (result, model) in
            if result {
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - 头视图
protocol FriendMainVHeaVDelegate {
    func main_load()
}

class FriendMainVHeaV: UIView {
    
    var delegate : FriendMainVHeaVDelegate?
    
    lazy var reloadBtn: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.3, y: 0, width: SCREEN_WIDTH - SCREEN_WIDTH * 0.6, height: self.Height))
        d.text = "加载更多"
        d.font = UIFont.systemFont(ofSize: 12)
        d.textAlignment = .center
        
        d.layer.cornerRadius = 5
        return d
    }()
    
    
    @objc fileprivate func load_more() {
        self.delegate?.main_load()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(reloadBtn)
        
        self.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(load_more))
        
        self.addGestureRecognizer(tapGes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
