//
//  PushMoneyDetailVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/24.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  转账信息

import UIKit

class PushMoneyDetailVC: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    fileprivate lazy var tableView: UITableView = {
//        let d : UITableView = UITableView.init(frame: self.view.bounds)
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
        
        view.addSubview(tableView)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}


class PushMoneyDetailVCCell: UITableViewCell {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        let touchPoint: CGPoint? = touch?.location(in: self)
        print("\((touchPoint?.x)! / self.Width)==\((touchPoint?.y)! / self.Height)")
        let stringFloat = Int((touchPoint?.x)!)
        let stringFloat1 = Int((touchPoint?.y)!)
        print("\(stringFloat)\(stringFloat1)")
    }
    
    
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
        return d
    }()
    
    lazy var pushMoneyLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.pushLabel.LeftX, y: self.pushLabel.BottomY, width: self.pushLabel.Width, height: 20))
        d.text = "100"
        d.textColor = UIColor.white
        return d
    }()
    
    lazy var rightPushLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.rightIMgV.Width * 0.3, y: self.rightIMgV.Height * 0.15, width: 60 * SCREEN_SCALE, height: 20))
        d.text = "转账给陈丽"
        d.textColor = UIColor.white
        return d
    }()
    
    lazy var rightPushWBLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.rightPushLabel.LeftX, y: self.rightPushLabel.BottomY, width: 60 * SCREEN_SCALE, height: 20))
        d.text = "1000网 博币"
        d.textColor = UIColor.white
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
