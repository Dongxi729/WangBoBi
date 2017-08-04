//
//  PushMoneyDetailVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/24.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  转账信息

import UIKit

class PushMoneyDetailVC: BaseViewController,UITableViewDataSource,UITableViewDelegate,headerViewelegate {
    
    /// 转账订单模型
    var pushMoney_model : [TranpayorderModel]?
    
    /// 好友头像
    var frienHead_Str : String? {
        didSet{
            
        }
    }
    
    /// 好友名字
    var frienName_Str :String? {
        didSet {
            self.title = frienName_Str
        }
    }
    
    
    
    var Fri_frid : String? {
        didSet {
            self.load_data()
        }
        
    }
    
    /// 是否下拉
    private var isRefresh = false
    
    /// 加载数据
    @objc fileprivate func load_data() {
        AccountModel.tranPayOrderRequest(self.Fri_frid!) { (result, model) in
            if result {
                
                self.pushMoney_model = [TranpayorderModel]()
                for _model in model {
                    self.pushMoney_model?.append(_model)
                    
                    if self.pushMoney_model?.count == model.count {
                        self.view.addSubview(self.tableView)
                        /// 添加头部刷新视图
                        self.tableView.addHeaderViewfun()
                        let foot : headerView = self.tableView.viewWithTag(888) as! headerView
                        foot.delegate = self
                        
                        if !self.isRefresh {
                            self.tableView.scrollToBottom(animated: false)
                        }
                    }
                }
            }
        }
    }

    fileprivate lazy var tableView: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: .plain)
        d.delegate = self
        d.dataSource = self
        d.separatorStyle = .none
        d.register(PushMoneyDetailVCCell.self, forCellReuseIdentifier: "PushMoneyDetailVCCell")
        
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = COMMON_TBBGCOLOR
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PushMoneyDetailVCCell") as! PushMoneyDetailVCCell
        
        /// 如果模型中的好友ID和当前和用户ID相同则，排列在左边，反之
        if self.pushMoney_model?[indexPath.row].ToUserId?.intValue == AccountModel.shared()?.Id.intValue {
            
            cell.rightImg.frame = CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: 30 * SCREEN_SCALE, height: 30 * SCREEN_SCALE)
            cell.rightIMgV.frame = CGRect.init(x: cell.rightImg.RightX, y: cell.rightImg.TopY, width: SCREEN_WIDTH * 0.6, height: SCREEN_WIDTH * 0.6 * (120 / 363))
            cell.rightIMgV.image = #imageLiteral(resourceName: "out")
            cell.rightPushLabel.text = "转账给你"
            cell.rightImg.setImage(urlString: AccountModel.shared()?.HeadImg, placeholderImage: #imageLiteral(resourceName: "logo"))
            cell.rightPushWBLabel.frame = CGRect.init(x: cell.rightPushLabel.LeftX, y: cell.rightPushLabel.BottomY, width: SCREEN_WIDTH * 0.5, height: cell.rightPushLabel.Height)
        } else {
            
            cell.rightImg.frame = CGRect.init(x: SCREEN_WIDTH - COMMON_MARGIN - 30 * SCREEN_SCALE, y: cell.rightImg.TopY, width: 30 * SCREEN_SCALE, height: 30 * SCREEN_SCALE)
            cell.rightIMgV.frame = CGRect.init(x: SCREEN_WIDTH * 0.25, y: cell.rightImg.TopY, width: SCREEN_WIDTH * 0.6, height: SCREEN_WIDTH * 0.6 * (120 / 363))
            cell.rightIMgV.image = #imageLiteral(resourceName: "in")
            cell.rightPushLabel.text = "转账给" + self.frienName_Str!
            cell.rightPushWBLabel.frame = CGRect.init(x: cell.rightPushLabel.LeftX, y: cell.rightPushLabel.BottomY, width: SCREEN_WIDTH * 0.5, height: cell.rightPushLabel.Height)
            cell.rightImg.setImage(urlString: self.frienHead_Str, placeholderImage: #imageLiteral(resourceName: "logo"))
        }
        
        cell.rightPushWBLabel.text = (self.pushMoney_model?[indexPath.row].WBCBalance)! + "网博币"
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.pushMoney_model?.count)!
    }
    
    var dd = ["dd","dd","dd","dd","dd","dd","ee","dd","dd","dd","dd","ff"]
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ccc = CountDetailVC()
        
        if self.pushMoney_model?[indexPath.row].ToUserId?.intValue == AccountModel.shared()?.Id.intValue {
            ccc.count_money = "+" + (self.pushMoney_model?[indexPath.row].WBCBalance)!
            ccc.count_headImgStr = AccountModel.shared()?.HeadImg
        } else {
            ccc.count_money = "-" + (self.pushMoney_model?[indexPath.row].WBCBalance)!
            ccc.count_headImgStr = self.frienHead_Str
        }
        
        ccc.count_nameStr = self.frienName_Str
        ccc.countDetail_model = self.pushMoney_model?[indexPath.row]
        self.navigationController?.pushViewController(ccc, animated: true)
    }
    
    // MARK: - refreshDelegate
    func headerViewEndfun(_ _endRefresh: () -> Void) {
        
        let d : headerView = tableView.viewWithTag(888) as! headerView
        
        isRefresh = true
        
        self.load_data()
        
        UIView.animate(withDuration: 1.5) {
            d.endRefresh()
        }
    }
}

/// 转账订单详情cell
class PushMoneyDetailVCCell: CommonTableViewCell {
    
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
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.pushLabel.LeftX, y: self.pushLabel.BottomY, width: self.Width * 0.5, height: 20))
        d.textColor = UIColor.white
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        return d
    }()
    
    
    lazy var rightPushLabel: UILabel =
        {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.rightIMgV.Width * 0.3, y: self.rightIMgV.Height * 0.15, width: SCREEN_WIDTH * 0.8, height: 20))
        d.text = "转账给"
        d.textColor = UIColor.white
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        return d
    }()
    
    lazy var rightPushWBLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.rightPushLabel.LeftX, y: self.rightPushLabel.BottomY, width: self.Width * 0.8, height: 20))
        d.text = "1000网 博币"
        d.textColor = UIColor.white
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(rightIMgV)
        contentView.addSubview(rightImg)
        rightIMgV.addSubview(rightPushLabel)
        rightIMgV.addSubview(rightPushWBLabel)
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
    
    fileprivate lazy var descLabel: BtnWithRightImg = {
        let d: BtnWithRightImg = BtnWithRightImg.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN * 0.5, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: self.Height - COMMON_MARGIN))
        d.setTitle("查看更多", for: .normal)
        d.backgroundColor = UIColor.colorWithHexString("2796DD")
        d.setImage(#imageLiteral(resourceName: "arrow_down"), for: .normal)
        d.addTarget(self, action: #selector(loadMore), for: .touchUpInside)
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(descLabel)
    }
    
    /// 加载更多
    func loadMore() {
        self.delegate?.loadMoreSEL()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 图片靠右按钮
class BtnWithRightImg: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView?.contentMode = .scaleAspectFit
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.textColor = UIColor.black
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: 0, y: 0, width: self.Width * 0.7, height: self.Height)
    }
    
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: self.Width * 0.7, y: 0, width: self.Width * 0.3, height: self.Height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
