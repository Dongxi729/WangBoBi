//
//  ChangePaypassVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/16.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  修改支付密码

import UIKit

class ChangePaypassVC: UIViewController,BindPhoneCellDelegate,BindPhoneFooterVDelegate,UITableViewDelegate,UITableViewDataSource {
    
    lazy var tableView: UITableView = {
        let d: UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self;
        d.dataSource = self;
        d.register(BindPhoneCell.self, forCellReuseIdentifier: "cellID")
        
        return d
    }()
    
    /// 尾部视图
    lazy var footerView: BindPhoneFooterV = {
        let d : BindPhoneFooterV = BindPhoneFooterV.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - 64 - 64, width: SCREEN_WIDTH, height: 64))
        d.delegate = self
        return d
    }()
    
    var dataSource : [String:[String]] = ["title" : ["支付密码","重复输入"],
                                          "content" : ["请输入支付密码","请重复输入支付密码"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "修改支付密码"
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(tableView)
        
        view.addSubview(footerView)
        
        footerView.setFooterTitle(str: "保存密码")
    }
    
    // MARK: - 表格数据源、代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataSource["title"]?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! BindPhoneCell
        
        
        cell.titLabel.text = dataSource["title"]?[indexPath.row]
        cell.titLabel.sizeToFit()
        cell.inputTF.placeholder = dataSource["content"]?[indexPath.row]
        cell.indexPath = indexPath as NSIndexPath
        cell.delegate = self
        
        switch indexPath.row {
        case 0:
            cell.sendSMS.isHidden = true
            break
        case 1:
            cell.sendSMS.isHidden = true
            break
        default:
            break
        }
        
        return cell
    }
    
    /// 支付密码
    var payPass : String?
    
    /// 确认密码
    var repeatPayPass : String?

    
    // MARK: - cell代理方法
    func text(indexPath: NSIndexPath, text: String) {
        CCog(message: indexPath)
        CCog(message: text)
        
        switch indexPath.row {
        case 0:
            self.payPass = text
            break
        case 1:
            self.repeatPayPass = text
            break
        
        default:
            break
        }
    }
    
    // MARK: - 尾部代理方法
    func bindPhonSELDelegate() {
        CCog(message: self.payPass)
        CCog(message: self.repeatPayPass)
    }
}
