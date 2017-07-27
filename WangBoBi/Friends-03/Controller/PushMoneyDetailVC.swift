//
//  PushMoneyDetailVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/24.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  转账信息

import UIKit

class PushMoneyDetailVC: BaseViewController,UITableViewDataSource,UITableViewDelegate,headerViewelegate {

    fileprivate lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: .plain)
        d.delegate = self
        d.dataSource = self
        d.separatorStyle = .none
        d.register(PushMoneyDetailVCCell.self, forCellReuseIdentifier: "PushMoneyDetailVCCell")
        
        return d
    }()
    
    lazy var activity: UIRefreshControl = {
        let d : UIRefreshControl = UIRefreshControl.init(frame: self.view.bounds)
        d.addTarget(self, action: #selector(refreshSEL(sender:)), for: .valueChanged)
        return d
    }()
    
    func refreshSEL(sender : UIRefreshControl) -> Void {
        CCog(message: "")
        self.reverSeddd.insert(contentsOf: ["123","4356"], at: 0)
        
        CCog(message: self.reverSeddd)
        
        self.tableView.reloadData()
        UIView.animate(withDuration: 1.5) {
            sender.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = COMMON_TBBGCOLOR
        
        view.addSubview(tableView)
        
        self.reverSeddd = self.dd.reversed()
        
        /// 添加头部刷新视图
        self.tableView.addHeaderViewfun()
        let foot : headerView = tableView.viewWithTag(888) as! headerView
        foot.delegate = self
        
        self.tableView.scrollToBottom(animated: false)
    }
    
    
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PushMoneyDetailVCCell") as! PushMoneyDetailVCCell
        
        if indexPath.row % 2 == 1 {
            cell.imgV.isHidden = true
            cell.detailImg.isHidden = true
            cell.rightImg.isHidden = false
            cell.rightIMgV.isHidden = false
            cell.rightPushWBLabel.isHidden = false
            cell.rightPushLabel.isHidden = false
            cell.pushLabel.isHidden = true
            cell.pushMoneyLabel.isHidden = true
        } else {
            cell.imgV.isHidden = false
            cell.detailImg.isHidden = false
            cell.rightImg.isHidden = true
            cell.rightIMgV.isHidden = true
            cell.rightPushWBLabel.isHidden = true
            cell.rightPushLabel.isHidden = true
            
            cell.pushLabel.isHidden = false
            cell.pushMoneyLabel.isHidden = false
        }
        
        cell.textLabel?.text = self.reverSeddd[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reverSeddd.count
    
    }
    
    var dd = ["dd","dd","dd","dd","dd","dd","ee","dd","dd","dd","dd","ff"]
    
    var reverSeddd : [String] = []
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(CountDetailVC(), animated: true)
    }
    
    
    
    // MARK: - refreshDelegate
    func headerViewEndfun(_ _endRefresh: () -> Void) {
        
        let d : headerView = tableView.viewWithTag(888) as! headerView
        CCog(message: "")
        CCog(message: "")
        self.reverSeddd.insert(contentsOf: ["123","4356"], at: 0)
        
        CCog(message: self.reverSeddd)
        
        self.tableView.reloadData()
        UIView.animate(withDuration: 1.5) {
            d.endRefresh()
        }
    }
}


class PushMoneyDetailVCCell: UITableViewCell {
    
    lazy var detailImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: self.imgV.RightX, y: self.imgV.TopY, width: SCREEN_WIDTH * 0.6, height: SCREEN_WIDTH * 0.6 * (120 / 363)))
        d.image = #imageLiteral(resourceName: "out")
        return d
    }()
    
    lazy var rightIMgV : UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.25, y: self.imgV.TopY, width: SCREEN_WIDTH * 0.6, height: SCREEN_WIDTH * 0.6 * (120 / 363)))
        d.image = #imageLiteral(resourceName: "in")
        return d
    }()
    
    /// 图标右边
    lazy var rightImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 30 * SCREEN_SCALE - COMMON_MARGIN, y: COMMON_MARGIN, width: 30 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        d.image = #imageLiteral(resourceName: "addfriend")
        return d
    }()
    
    /// 图片左
    lazy var imgV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: 30 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        d.image = #imageLiteral(resourceName: "addfriend")
        return d
    }()
    
    lazy var pushLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.detailImg.Width * 0.3,y: self.detailImg.Height * 0.15, width: 60 * SCREEN_SCALE, height: 20))
        d.text = "转账给你"
        d.textColor = UIColor.white
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        return d
    }()
    
    lazy var pushMoneyLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.pushLabel.LeftX, y: self.pushLabel.BottomY, width: self.pushLabel.Width, height: 20))
        d.text = "100"
        d.textColor = UIColor.white
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        return d
    }()
    
    lazy var rightPushLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.rightIMgV.Width * 0.3, y: self.rightIMgV.Height * 0.15, width: 60 * SCREEN_SCALE, height: 20))
        d.text = "转账给陈丽"
        d.textColor = UIColor.white
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        return d
    }()
    
    lazy var rightPushWBLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.rightPushLabel.LeftX, y: self.rightPushLabel.BottomY, width: 60 * SCREEN_SCALE, height: 20))
        d.text = "1000网 博币"
        d.textColor = UIColor.white
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        return d
    }()
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imgV)
        contentView.addSubview(detailImg)
        contentView.addSubview(rightIMgV)
        contentView.addSubview(rightImg)
        
        detailImg.addSubview(pushLabel)
        detailImg.addSubview(pushMoneyLabel)
        
        rightIMgV.addSubview(rightPushLabel)
        rightIMgV.addSubview(rightPushWBLabel)
        
        pushLabel.sizeToFit()
        pushMoneyLabel.sizeToFit()
        rightPushLabel.sizeToFit()
        rightPushWBLabel.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 表头
protocol PushMoneyHeaderViewDelegate {
    func loadMoreSEL()
}


class PushMoneyHeaderView: UIView {
    
    var delegate : PushMoneyHeaderViewDelegate?
    
    fileprivate lazy var descLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN * 0.5, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: self.Height - COMMON_MARGIN))
        d.text = "查看更多"
        d.backgroundColor = UIColor.colorWithHexString("2796DD")
        d.textAlignment = .center
        d.layer.cornerRadius = 5
        d.clipsToBounds = true
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(descLabel)
        
        self.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(loadMore))
        self.addGestureRecognizer(tapGes)
    }
    
    /// 加载更多
    func loadMore() {
        self.delegate?.loadMoreSEL()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
