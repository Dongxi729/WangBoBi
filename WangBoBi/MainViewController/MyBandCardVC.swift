//
//  TestViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/17.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  http://blog.csdn.net/json_6/article/details/51890313
//  我的银行卡

import UIKit

class MyBandCardVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var d : [String] = ["招商银行","农业银行"]
    
    
    fileprivate lazy var monY: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: .grouped)
        d.delegate = self;
        d.dataSource = self;
        d.register(BandCardCell.self, forCellReuseIdentifier: "cellID")
        d.register(AddCardCell.self, forCellReuseIdentifier: "cardCell")
        
        /// 尾部视图
        d.tableFooterView = self.footerView
        return d
    }()
    
    // MARK: - 尾部视图
    lazy var footerView: FooterView = {
        let d : FooterView = FooterView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 80))
        return d
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(monY)
        title = "银行卡"
    }
    
    
    // MARK: - TableView DataSource And Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return d.count
        default:
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 120
        default:
            return 45
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! BandCardCell
        
        switch indexPath.section {
        case 0:
            
            cell.cardsName.text = d[indexPath.row]
            
            cell.frame = CGRect.init(x: 0, y: Int(cell.Height * CGFloat(indexPath.row)), width: Int(SCREEN_WIDTH), height: 100 * indexPath.row)
            
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as! AddCardCell
            return cell

        default:
            break
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.00001
        default:
            return COMMON_MARGIN
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            navigationController?.pushViewController(AddBankCardVC(), animated: true)
            break
        default:
            break
        }
    }
}








// MARK: - 第二组视图
class FooterView : UIView {
    
    fileprivate lazy var quesLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: self.Height))
        d.text = "常见问题"
        d.font = UIFont.init(name: "SimHei", size: 10 * SCREEN_SCALE)
        d.textAlignment = .center
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(quesLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
