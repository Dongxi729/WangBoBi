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
    fileprivate var mertopModel = [NewFriendListModel]()
    
    /// 显示页数
    fileprivate var limitCount : Int = 0
    
    /// 显示更多
    fileprivate lazy var footer_V: FriendMainVHeaV = {
        let d : FriendMainVHeaV = FriendMainVHeaV.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 50))
        d.backgroundColor = UIColor.white
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
        
        AccountModel.GetFriendList(String(limitCount), "10") { (result, model) in
            self.mertopModel = model
            CCog(message: self.mertopModel.count)
            self.tableView.reloadData()
            
            for value in model {
                if !(value.TrueName?.isEmpty)! {
                    self.sercchArray.append(value.TrueName!)
                } else {
                    self.sercchArray.append(value.UserName!)
                }
            }
        }
        
        tableView.tableFooterView = footer_V
        
        view.backgroundColor = UIColor.white
    }
    
    // MARK: - 按钮事件
    @objc fileprivate func jumpToFriend() {
        self.navigationController?.pushViewController(AddFrienVC(), animated: true)
    }
    
    @objc fileprivate func jumpToFriendContactVC() {
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(FriendGroupVC(), animated: true)
        }
    }

    /// 模型
    var modelData = [FriendListModel]()
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.countrySearchController.resignFirstResponder()
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
            
            cell.stangerLabel.isHidden = false
            
            cell.model = self.mertopModel[indexPath.row]
            
            if self.countrySearchController.isActive {
                cell.descLabel.text = self.searchArray[indexPath.row]

                return cell
            }
            
            return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let ccc = PushMoneyDetailVC()
        let frid_ID : Int = (self.mertopModel[indexPath.row].Id?.intValue)!
        ccc.Fri_frid = String(frid_ID)
        ccc.frienName_Str = self.mertopModel[indexPath.row].TrueName
        ccc.frienHead_Str = self.mertopModel[indexPath.row].HeadImg
        
        
        self.navigationController?.pushViewController(ccc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if self.countrySearchController.isActive {
            return self.searchArray.count
        } else {
            return self.mertopModel.count
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
        CCog(message: self.sercchArray)
        self.searchArray = []

        self.searchArray = self.sercchArray.filter { (school) -> Bool in

            return school.contains(searchController.searchBar.text!)
        }
        
        CCog(message: searchArray)
    }
    
    // MARK: - FriendMainVHeaVDelegate
    
    /// 搜索的数据源
    var sercchArray : [String] = []
    
    func main_load() {
        
        CCog(message: "")
        
        limitCount += 1
        AccountModel.GetFriendList(String(limitCount), "10") { (result, model) in
            if result {
                self.mertopModel = model
                self.tableView.reloadData()
                
                self.sercchArray = []
                
                for value in model {
                    if !(value.TrueName?.isEmpty)! {
                        self.sercchArray.append(value.TrueName!)
                    } else {
                        self.sercchArray.append(value.UserName!)
                    }
                }
            }
        }
    }
    
    func headerViewEndfun(_ _endRefresh: () -> Void) {
        let dd : headerView = self.tableView.viewWithTag(888) as! headerView
        dd.endRefresh()
        
        AccountModel.GetFriendList("1", "10") { (result, model) in
            if result {
                self.mertopModel = model
                
                self.tableView.reloadData()
                
                self.sercchArray = []
                
                for value in model {
                    if !(value.TrueName?.isEmpty)! {
                        self.sercchArray.append(value.TrueName!)
                    } else {
                        self.sercchArray.append(value.UserName!)
                    }
                }
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
    
    lazy var reloadBtn: BtnWithRightImg = {
        let d : BtnWithRightImg = BtnWithRightImg.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.35, y: 0, width: SCREEN_WIDTH - SCREEN_WIDTH * 0.7, height: self.Height))
        d.setTitle("加载更多", for: .normal)
        d.setTitleColor(UIColor.black, for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        d.setImage(#imageLiteral(resourceName: "arrow_down"), for: .normal)
        d.titleLabel?.sizeToFit()
        d.isEnabled = false
        return d
    }()
    
    @objc fileprivate func load_more() {
        self.delegate?.main_load()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(reloadBtn)
        //        addSubview(arrow_img)
        
        self.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(load_more))
        
        self.addGestureRecognizer(tapGes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
