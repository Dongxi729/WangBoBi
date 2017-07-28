//
//  CountDetailVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/27.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  账单详情

import UIKit

class CountDetailVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate var cellDataSource : [String] = ["付款方式","转账说明","转账地址","创建时间","订单号"]
    
    fileprivate lazy var headV: CountDetaiHeadV = {
        let d : CountDetaiHeadV = CountDetaiHeadV.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 130))
        return d
    }()
    
    lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: .grouped)
        d.delegate = self
        d.dataSource = self
        d.register(CountDetailCell.self, forCellReuseIdentifier: "CountDetailCell")
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "账单详情"
        
        view.addSubview(tableView)
        
        tableView.tableHeaderView = headV
        
        view.backgroundColor = UIColor.white
    }
    
    // MARK: - UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountDetailCell") as! CountDetailCell
        
//        cell.preservesSuperviewLayoutMargins = false
//        cell.separatorInset = UIEdgeInsets.zero
//        cell.layoutMargins = .zero
        
        
        cell.count_right.text = cellDataSource[indexPath.row]
        cell.countcell_left.text = cellDataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataSource.count
    }
}

// MARK: - 头部视图
class CountDetaiHeadV: UIView {
    
    /// 头像
    lazy var contDetail_headImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: CGRect.init(x: self.center.x - SCREEN_WIDTH * 0.05, y: COMMON_MARGIN, width: SCREEN_WIDTH * 0.1, height: SCREEN_WIDTH * 0.1))
        d.image = #imageLiteral(resourceName: "addFriIcon")
        return d
    }()
    
    /// 名字
    lazy var countD_nameLbel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.contDetail_headImg.BottomY + COMMON_MARGIN * 0.5, width: SCREEN_WIDTH, height: 20))
        d.font = UIFont.systemFont(ofSize: 12)
        d.textColor = UIColor.darkGray
        d.text = "十三水"
        d.textAlignment = .center
        return d
    }()
    
    /// 金额
    lazy var count_moneyLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.countD_nameLbel.BottomY, width: SCREEN_WIDTH, height: 30))
        d.font = UIFont.systemFont(ofSize: 20)
        d.text = "-12.0"
        d.textAlignment = .center
        return d
    }()
    
    /// 交易结果
    lazy var count_SealResultLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.count_moneyLabel.BottomY, width: SCREEN_WIDTH, height: 20))
        d.textAlignment = .center
        d.text = "交易结果"
        d.textColor = UIColor.darkGray
        d.font = UIFont.systemFont(ofSize: 12)
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contDetail_headImg)
        addSubview(countD_nameLbel)
        addSubview(count_moneyLabel)
        addSubview(count_SealResultLabel)
        
        self.backgroundColor = UIColor.white
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
