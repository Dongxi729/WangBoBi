//
//  ReceiveCell.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class ReceiveCell : UITableViewCell {
    
    
    /// 前置图标
    lazy var imgVi: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN * 1.2, y: self.Height * 0.2, width: self.Height * 0.8, height: self.Height * 0.9))
        d.contentMode = UIViewContentMode.scaleAspectFit
        return d
    }()
    
    /// 描述文本
    lazy var descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.imgVi.RightX + COMMON_MARGIN, y: COMMON_MARGIN, width: self.Width - self.imgVi.Width + COMMON_MARGIN * 1.2 * 2 , height: 60 - 2 * COMMON_MARGIN))
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imgVi)
        contentView.addSubview(descLabel)
        
        /// 取消选中
        self.selectionStyle = .none
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 朋友
class FriendCell : UITableViewCell {
    
    var model : FriendListModel? {
        didSet {
            
            self.descLabel.text = model?.descStr
            self.bottomLabel.text = model?.moneyCount
        }
    }
    
    
    // MARK: - 小红点
    lazy var redBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: self.imgVi.Width - 7.5, y: -7.5, width: 15 , height: 15))
        d.setTitle("1", for: .normal)
        d.backgroundColor = UIColor.red
        d.layer.cornerRadius = 7.5
        d.clipsToBounds = true
        d.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return d
    }()

    
    /// 前置图标
    lazy var imgVi: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN , y: 7.5, width: self.Height, height: self.Height))
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.image = #imageLiteral(resourceName: "friendBg")
        d.layer.borderWidth = 1
        return d
    }()
    
    /// 描述文本
    lazy var descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.imgVi.RightX + COMMON_MARGIN * 2, y: 10, width: self.Width - self.imgVi.Width + COMMON_MARGIN * 1.2 * 2 , height: 20))
        d.font = UIFont.boldSystemFont(ofSize: 14)
        return d
    }()
    
    /// 时间文本
    lazy var timeLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.imgVi.TopY, width: SCREEN_WIDTH - COMMON_MARGIN, height: 10))
        d.font = UIFont.systemFont(ofSize: 10)
        d.textAlignment = .right
        d.text = "12-22"
        d.textColor = UIColor.lightGray
        return d
    }()
    
    /// 陌生人
    lazy var stangerLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.imgVi.RightX + COMMON_MARGIN * 2, y: 10, width: SCREEN_WIDTH * 0.125, height: 20))
        d.text = "陌生人"
        d.textColor = UIColor.colorWithHexString("2693DA")
        d.layer.borderColor = UIColor.colorWithHexString("2693DA").cgColor
        d.font = UIFont.systemFont(ofSize: 10)
        d.layer.borderWidth = 1
        d.textAlignment = .center
        d.layer.cornerRadius = 5
        return d
    }()
    
    /// 底部文本
    lazy var bottomLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.imgVi.RightX + 2 * COMMON_MARGIN + SCREEN_WIDTH * 0.09, y: self.descLabel.BottomY + 5, width: self.descLabel.Width, height: 15))
        d.font = UIFont.systemFont(ofSize: 13)
        d.text = "asdsasd"
        d.textColor = UIColor.darkGray
        return d
    }()
    
    /// 收款、付款
    lazy var setGetMoneyLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.imgVi.RightX + 2 * COMMON_MARGIN, y: self.descLabel.BottomY + 5, width: SCREEN_WIDTH * 0.09, height: 15))
        d.text = "[收款]"
        d.textColor = UIColor.colorWithHexString("2693DA")
        d.layer.borderColor = UIColor.colorWithHexString("2693DA").cgColor
        d.font = UIFont.systemFont(ofSize: 12)
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imgVi)
        contentView.addSubview(descLabel)
        
        imgVi.addSubview(redBtn)
        
        contentView.addSubview(bottomLabel)
        
        contentView.addSubview(timeLabel)
        
        /// 陌生人文本
        contentView.addSubview(stangerLabel)
        
        contentView.addSubview(setGetMoneyLabel)
        
        /// 取消选中
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        /// 根据陌生人隐藏状态调整描述文本
        if !stangerLabel.isHidden {
            self.descLabel.frame = CGRect.init(x: self.stangerLabel.RightX, y: 10, width: self.Width - self.imgVi.Width + COMMON_MARGIN * 1.2 * 2 , height: 20)
        } else {
            self.descLabel.frame = CGRect.init(x: self.imgVi.RightX + COMMON_MARGIN * 2, y: 10, width: self.Width - self.imgVi.Width + COMMON_MARGIN * 1.2 * 2 , height: 20)
        }
        
        ///// ......根据返回模型取值
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



