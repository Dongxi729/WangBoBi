//
//  AccountAndSaveVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/16.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  账号与安全

import UIKit



class AccountAndSaveVC: UIViewController {
    
    
    var sectionTitle : [[String]] = [["实名认证","设置双重认证","修改登录密码","修改支付密码","设置支付密码"],["退出登录"]]
    
    fileprivate lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self
        d.dataSource = self
        d.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        return d
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "账号与安全"

        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
    }
}

extension AccountAndSaveVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        return d
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 100

        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        
        cell?.textLabel?.text = sectionTitle[indexPath.section][indexPath.row]
        
        
        switch indexPath.section {
        case 1:
            cell?.textLabel?.textAlignment = .center
            break
        default:
            break
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 60
        } else {return 45}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                /// 实名认证
                self.navigationController?.pushViewController(TrueNameCertifiedVC(), animated: true)
                break
            case 1:
                /// 设置双重认证
                self.navigationController?.pushViewController(SetDoubelCertifiVC(), animated: true)
                break
            case 2:
                /// 修改登录密码
                self.navigationController?.pushViewController(ChangeLoginPassVC(), animated: true)
                break
            case 3:
                /// 修改支付密码
                self.navigationController?.pushViewController(ChangePaypassVC(), animated: true)
                break
            case 4:
                /// 设置支付密码
                self.navigationController?.pushViewController(SetPaymentPassVC(), animated: true)
                break
            default:
                break
            }
        case 1:
            /// 退出事件
            self.logoutSEL()
            
            break
        default:
            break
        }
    }
    
    /// 退出事件
    private func logoutSEL() -> Void {
        CCog(message: "退出事件")
        UIApplication.shared.keyWindow?.rootViewController = LoginViewController()
    }
}
