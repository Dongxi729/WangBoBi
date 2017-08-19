//
//  NewFriendVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/24.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  新的朋友

import UIKit

class NewFriendVC: BaseViewController,UITableViewDelegate,UITableViewDataSource,NewFriendCellDelegate {
    
    /// 朋友接口列表
    var topModel = [FriendMainListModel]()
    
    fileprivate lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: .grouped)
        d.delegate = self
        d.dataSource = self
        d.register(NewFriendCell.self, forCellReuseIdentifier: "NewFriendCell")
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
        
        AccountModel.newFriend { (result, model) in
            if result {
                self.topModel = model
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewFriendCell") as! NewFriendCell
        let cell_model = self.topModel[indexPath.row]
        cell.new_model = cell_model
        cell.delegate = self
        cell.new_indexPath = indexPath as NSIndexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "新的朋友"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2 * COMMON_MARGIN
    }
    
    
    var userID : String?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userID = self.topModel[indexPath.row].AlyUserId?.stringValue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.topModel.count
    }
    
    //搜索过滤后的结果集
    fileprivate var searchArray:[String] = [String](){
        didSet  {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - NewFriendCellDelegate
    
    func acceptSEL(xxx: NSIndexPath) {
       
        AccountModel.addFriendRequest("acpt", "",(self.topModel[xxx.row].AlyUserId?.stringValue)! , "", "", "") { (result, model) in

        }
    }
//    func acceptSEL() {
//        AccountModel.addFriendRequest(4, "",userID! , "", "") { (result, model) in
//            
//        }
//    }
    
    
}

