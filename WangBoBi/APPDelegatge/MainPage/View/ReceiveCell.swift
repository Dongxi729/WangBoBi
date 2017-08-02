//
//  ReceiveCell.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class ReceiveCell : CommonTableViewCell {
    
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
class FriendCell : CommonTableViewCell {
    
    var model : NewFriendListModel? {
        didSet {
            self.imgVi.setImage(urlString: model?.HeadImg, placeholderImage: #imageLiteral(resourceName: "logo"))
            self.descLabel.text = model?.TrueName
            
            self.bottomLabel.text = model?.Msg
            
            var ddd : NSString = (model?.SubmitTime!)!
            
            ddd = ddd.replacingOccurrences(of: "T", with: " ") as NSString
            print(ddd)
            
            ddd = ddd.substring(with: NSRange.init(location: 0, length: 16)) as NSString
            
            self.timeLabel.text = ddd as String
            
            /// 时间
            
            if model?.NoticeNum?.intValue > 0 {
                self.redBtn.isHidden = false
                let badge : Int = (model?.NoticeNum?.intValue)!
                self.redBtn.setTitle(String(badge), for: .normal)
            } else {
                self.redBtn.isHidden = true
            }
            
            /// 是否是朋友
            if model?.IsFriend?.intValue == 1 {
                self.stangerLabel.isHidden = true
                self.descLabel.frame = CGRect.init(x: self.imgVi.RightX + COMMON_MARGIN * 0.5, y: 10, width: SCREEN_WIDTH - self.imgVi.Width - COMMON_MARGIN * 2, height: 20)
                self.descLabel.layer.borderWidth = 1
            } else if model?.IsFriend?.intValue == 0 {
                self.stangerLabel.text = "陌生人"
            }
            
            /// 设置收到、转账的文字颜色
            if (model?.Msg?.contains("向你"))! {
                self.setGetMoneyLabel.text = "[收到]"
                self.setGetMoneyLabel.textColor = UIColor.colorWithHexString("2693DA")
                self.setGetMoneyLabel.layer.borderColor = UIColor.colorWithHexString("2693DA").cgColor
            } else {
                self.setGetMoneyLabel.text = "[转账]"
                self.setGetMoneyLabel.textColor = UIColor.red
                self.setGetMoneyLabel.layer.borderColor = UIColor.red.cgColor
            }
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
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.imgVi.RightX + COMMON_MARGIN * 0.5, y: 10, width: self.Width - self.imgVi.Width + COMMON_MARGIN * 1.2 * 2 , height: 20))
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
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.imgVi.RightX + COMMON_MARGIN * 0.5, y: 10, width: SCREEN_WIDTH * 0.125, height: 20))
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
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.imgVi.RightX + COMMON_MARGIN + SCREEN_WIDTH * 0.09, y: self.descLabel.BottomY + 5, width: self.descLabel.Width, height: 15))
        d.font = UIFont.systemFont(ofSize: 13)
        d.text = "asdsasd"
        d.textColor = UIColor.darkGray
        return d
    }()
    
    /// 收款、付款
    lazy var setGetMoneyLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.imgVi.RightX + COMMON_MARGIN * 0.5, y: self.descLabel.BottomY + 5, width: SCREEN_WIDTH * 0.09, height: 15))
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
        
        if !stangerLabel.isHidden {
            self.descLabel.frame = CGRect.init(x: self.stangerLabel.RightX, y: 10, width: self.Width - self.imgVi.Width + COMMON_MARGIN * 1.2 * 2 , height: 20)
        } else {
            self.descLabel.frame = CGRect.init(x: self.imgVi.RightX + COMMON_MARGIN * 2, y: 10, width: self.Width - self.imgVi.Width + COMMON_MARGIN * 1.2 * 2 , height: 20)
        }

        self.setGetMoneyLabel.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol NewFriendCellDelegate {
    func acceptSEL(xxx : NSIndexPath)
}

// MARK: - 新的朋友Cell
class NewFriendCell : CommonTableViewCell {
    
    var delegate : NewFriendCellDelegate?
    
    var new_indexPath : NSIndexPath?
    
    var new_model: FriendMainListModel? {
        didSet {
            
            self.ne_imgVi.setImage(urlString: new_model?.HeadImg, placeholderImage: #imageLiteral(resourceName: "logo"))
            self.ne_bottomLabel.text = new_model?.Remark
            self.new_descLabel.text = new_model?.UserName
            
            if new_model?.Status?.intValue == 0 {
                new_aleradyLabel.isHidden = true
                new_acceptBtn.isHidden = false
            } else {
                new_aleradyLabel.isHidden = false
                new_acceptBtn.isHidden = true
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(ne_imgVi)
        contentView.addSubview(new_descLabel)
        contentView.addSubview(ne_bottomLabel)
        contentView.addSubview(new_acceptBtn)
        contentView.addSubview(new_aleradyLabel)
   }
    
    
    // MARK: - 事件
    func addcpe_SEl() -> Void {
        self.delegate?.acceptSEL(xxx: new_indexPath!)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 前置图标
    lazy var ne_imgVi: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN , y: 7.5, width: self.Height, height: self.Height))
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.image = #imageLiteral(resourceName: "friendBg")
        return d
    }()
    
    /// 描述文本
    lazy var new_descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.ne_imgVi.RightX + COMMON_MARGIN, y: 10, width: self.Width - self.ne_imgVi.Width + COMMON_MARGIN * 1.2 * 2 , height: 20))
        d.font = UIFont.boldSystemFont(ofSize: 14)
        return d
    }()
    
    /// 底部文本
    lazy var ne_bottomLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.ne_imgVi.RightX + COMMON_MARGIN, y: self.new_descLabel.BottomY + 5, width: self.new_descLabel.Width, height: 15))
        d.font = UIFont.systemFont(ofSize: 13)
        d.text = "asdsasd"
        d.textColor = UIColor.darkGray
        return d
    }()
    
    /// 接受
    lazy var new_acceptBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH - COMMON_MARGIN - SCREEN_WIDTH * 0.15, y: self.center.y - self.Height * 0.15, width: SCREEN_WIDTH * 0.15, height: self.Height * 0.6))
        d.setTitle("接受", for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        d.titleLabel?.sizeToFit()
        
        d.clipsToBounds = true
        d.layer.cornerRadius = 5
        d.backgroundColor = UIColor.colorWithHexString("2796DD")
        
        d.addTarget(self, action: #selector(addcpe_SEl), for: .touchUpInside)
        return d
    }()
    
    /// 已接收
    lazy var new_aleradyLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: SCREEN_WIDTH - COMMON_MARGIN - SCREEN_WIDTH * 0.15, y: self.center.y, width: SCREEN_WIDTH * 0.15, height: self.Height * 0.6))
        d.text = "已接受"
        d.font = UIFont.systemFont(ofSize: 12)
        d.sizeToFit()
        d.textColor = UIColor.colorWithHexString("2796DD")
        return d
    }()
}

class NewFriend_Cell : CommonTableViewCell {
    
    var delegate : NewFriendCellDelegate?

    var new_model: FriendListModel? {
        didSet {
            
            self.ne_imgVi.setImage(urlString: new_model?.HeadImg, placeholderImage: #imageLiteral(resourceName: "logo"))
            self.ne_bottomLabel.text = new_model?.WBCAdress
            self.new_descLabel.text = new_model?.UserName
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(ne_imgVi)
        contentView.addSubview(new_descLabel)
        contentView.addSubview(ne_bottomLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 前置图标
    lazy var ne_imgVi: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN , y: 7.5, width: self.Height, height: self.Height))
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.image = #imageLiteral(resourceName: "friendBg")
        return d
    }()
    
    /// 描述文本
    lazy var new_descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.ne_imgVi.RightX + COMMON_MARGIN, y: 10, width: self.Width - self.ne_imgVi.Width + COMMON_MARGIN * 1.2 * 2 , height: 20))
        d.font = UIFont.boldSystemFont(ofSize: 14)
        return d
    }()
    
    /// 底部文本
    lazy var ne_bottomLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.ne_imgVi.RightX + COMMON_MARGIN, y: self.new_descLabel.BottomY + 5, width: self.new_descLabel.Width, height: 15))
        d.font = UIFont.systemFont(ofSize: 13)
        d.text = "asdsasd"
        d.textColor = UIColor.darkGray
        return d
    }()
}
