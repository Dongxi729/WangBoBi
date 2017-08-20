//
//  NewFriendVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/24.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  新的朋友

import UIKit

class NewFriendVC: BaseViewController {
    
//    lazy var tbV: NewFriendV = {
//        let d : NewFriendV = NewFriendV.init(friendFrame: self.view.bounds)
//        return d
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "新的朋友"
        
        view.backgroundColor = UIColor.white
        
        CCog(message: WBCRateModel.CNYRate)
        
        AccountModel.newFriend { (result, model) in
            if result {

                CCog(message: model.count)
                
                let d = NewFriendV.init(friendFrame: CGRect.init(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: 60 * model.count))
                d.friendListModel = model
                d.backgroundColor = UIColor.red
                self.view.addSubview(d)
                
                let footer = UIView.init(frame: CGRect.init(x: 0, y: d.BottomY, width: SCREEN_WIDTH, height: 300))
                footer.backgroundColor = UIColor.red
                self.view.addSubview(footer)
            }
        }
    }
}

class NewFriendV: UIView,UITableViewDelegate,UITableViewDataSource,NewFriendCellDelegate {
    fileprivate lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init()
        d.delegate = self
        d.dataSource = self
        d.register(NewFriendCell.self, forCellReuseIdentifier: "NewFriendCell")
        return d
    }()
    
    /// 朋友接口列表
    var friendListModel = [FriendMainListModel]()
    
    init(friendFrame rect : CGRect) {
        super.init(frame: rect)
        self.tableView.frame = rect
//        self.friendListModel = data
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewFriendCell") as! NewFriendCell
        let cell_model = self.friendListModel[indexPath.row]
        cell.new_model = cell_model
        cell.delegate = self
        cell.new_indexPath = indexPath as NSIndexPath
        
        return cell
    }

    var userID : String?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userID = self.friendListModel[indexPath.row].AlyUserId?.stringValue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.friendListModel.count
    }
    
    //搜索过滤后的结果集
    fileprivate var searchArray:[String] = [String](){
        didSet  {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - NewFriendCellDelegate
    func acceptSEL(xxx: NSIndexPath) {
        
        AccountModel.addFriendRequest("acpt", "","" ,(self.friendListModel[xxx.row].AlyUserId?.stringValue)! , "", "") { (result, model) in
            if result {
                /// 添加好友成功
                UIApplication.shared.keyWindow?.rootViewController?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}


