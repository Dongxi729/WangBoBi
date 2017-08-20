//
//  FriendGroupVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/24.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  好友列表(我的朋友)

import UIKit

class FriendGroupVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    /// 显示数据源(非实名)
    var citys : [FriendListModel] = []
    
    /// 显示数据源(实名)
    var num_citys : [FriendListModel] = []
    
    
    
    /// 搜索数据源
    var searchTotalArray : [String] = []
    
    /// 右边按钮
    var rightBtn : UIButton = UIButton()
    
    
    /// 搜索控制器
//    fileprivate lazy var countrySearchController: UISearchController = {
//        let d : UISearchController = UISearchController.init(searchResultsController: nil)
//        d.searchResultsUpdater = self   //两个样例使用不同的代理
//        d.hidesNavigationBarDuringPresentation = false
//        d.dimsBackgroundDuringPresentation = false
//        d.searchBar.subviews.first?.subviews.first?.removeFromSuperview()
//        d.searchBar.placeholder = "搜索"
//        d.searchBar.sizeToFit()
//        
//        return d
//    }()
    
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
        
        self.view.addSubview(self.tableView)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rightBtn.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.rightBtn.isHidden = true
        
//        countrySearchController.isActive = false
    }
    
    // MARK: - 右边按钮交互事件
    @objc fileprivate func jumpToFriend() {
        self.navigationController?.pushViewController(AddFrienVC(), animated: true)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
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
        
        return cell
    }
    
    // MARK: - UItableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    // MARK: - 透视图交互事件
    func jumpToNewFriendVC() {
        self.navigationController?.pushViewController(NewFriendVC(), animated: true)
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
