//
//  AccountAndSaveVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/16.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  账号与安全

import UIKit



class AccountAndSaveVC: UIViewController {
    
    
    var sectionTitle : [[String]] = [["实名认证","设置双重认证","修改登录密码","修改支付密码"]]
    
    /// 表格
    fileprivate lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self
        d.dataSource = self
        d.register(TabViewCell.self, forCellReuseIdentifier: "cellId")
        d.tableFooterView = self.footerV
        return d
    }()
    
    /// 尾部视图
    fileprivate lazy var footerV: AccountAndSaveFooterV = {
        let d : AccountAndSaveFooterV = AccountAndSaveFooterV.init(frame: CGRect.init(x: COMMON_MARGIN, y: 0, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 45))
        d.delegate = self
        return d
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "账号与安全"

        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
    }
}

extension AccountAndSaveVC : UITableViewDelegate,UITableViewDataSource,AccountAndSaveFooterVDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        return d
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        
        return 0.000001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! TabViewCell
        
        cell.descLabel.text = sectionTitle[indexPath.section][indexPath.row]
        
        
        switch indexPath.section {
        case 1:
            cell.textLabel?.textAlignment = .center
            break
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 60
        } else {return 45}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sectionTitle[0].count

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
            default:
                break
            }
        default:
            break
        }
    }
    
    func footerSEL() {
        CCog(message: "提出事件")
        
        var nav = LoginNav()
        nav = LoginNav.init(rootViewController: LoginViewController())
        
        UIApplication.shared.keyWindow?.rootViewController = nav
    }

}


// MARK: - 尾部视图
protocol AccountAndSaveFooterVDelegate {
    func footerSEL() -> Void
}

class AccountAndSaveFooterV : UIView {
    
    var delegate : AccountAndSaveFooterVDelegate?
    
    lazy var exitBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: self.bounds)
        d.backgroundColor = UIColor.blue
        d.setTitle("退出", for: .normal)
        d.backgroundColor = UIColor.colorWithHexString("2796DD")
        d.titleLabel?.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        d.addTarget(self, action: #selector(exitSE(sender:)), for: .touchUpInside)
        return d
    }()
    
    func exitSE(sender : UIButton) -> Void {
        self.delegate?.footerSEL()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(exitBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
