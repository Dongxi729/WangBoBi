//
//  ChangeLoginPassVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/16.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  修改登录密码

import UIKit

class ChangeLoginPassVC: UIViewController,BindPhoneCellDelegate,BindPhoneFooterVDelegate,UITableViewDelegate,UITableViewDataSource {
    
    lazy var tableView: UITableView = {
        let d: UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self;
        d.dataSource = self;
        d.register(BindPhoneCell.self, forCellReuseIdentifier: "cellID")
        d.separatorStyle = .none
        return d
    }()
    
    /// 尾部视图
    lazy var footerView: BindPhoneFooterV = {
        let d : BindPhoneFooterV = BindPhoneFooterV.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - 64 - 64, width: SCREEN_WIDTH, height: 64))
        d.delegate = self
        return d
    }()
    
    var dataSource : [String:[String]] = ["title" : ["登录密码","新密码","重复输入"],
                                          "content" : ["请输入旧登录密码","请输入新密码","请重复输入新密码"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "修改登录密码"
        
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
        
        /// 隐藏发生验证码按钮
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
        
        if indexPath.row != 0 {
            cell.inputTF.keyboardType = .numberPad
            
        }
        
        return cell
    }
    
    /// 登录密码
    var loginPass : String?
    
    /// 新密码
    var newLoginPass : String?
    
    /// 重复输入
    var repeatNewPass : String?
    
    // MARK: - cell代理方法
    func text(indexPath: NSIndexPath, text: String) {

        switch indexPath.row {
        case 0:
            self.loginPass = text
            break
        case 1:
            self.newLoginPass = text
            break
        case 2:
            self.repeatNewPass = text
            break
        default:
            break
        }
    }
    
    // MARK: - 尾部代理方法
    func bindPhonSELDelegate() {

        /// 确定字段不为空
        if self.loginPass != nil {
            if self.newLoginPass != nil {
     
                if self.repeatNewPass != nil {
                    
                    if self.newLoginPass == self.repeatNewPass {
                        AccountModel.changeLoginPass(oldStr: self.loginPass!, newPass: newLoginPass!, finished: { (result) in
                            if result {
                                self.navigationController?.popViewController(animated: true)
                            }
                        })
                        
                    } else {
                        toast(toast: "两次密码输入不一致")
                    }
                } else {
                    toast(toast: "确认密码不为空")
                }
            } else {
                toast(toast: "新登录密码不为空")
            }
        } else {
            toast(toast: "登录密码不为空")
        }
    }
}
