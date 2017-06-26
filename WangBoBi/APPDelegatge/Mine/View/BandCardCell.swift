//
//  BandCardCell.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  银行卡Cell

import UIKit


class BandCardCell: UITableViewCell {
    
    var model = CardType()
    
    // MARK: - 银行图标
    fileprivate lazy var bankIcon: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: 30 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.backgroundColor = UIColor.randomColor()
        return d
    }()
    
    // MARK: - 银行卡类型
    lazy var cardsName: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.bankIcon.RightX + COMMON_MARGIN / 2, y: COMMON_MARGIN, width: self.Width - self.bankIcon.Width, height: 15 * SCREEN_SCALE))
        
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        
        
        /// 其他类型判别
        
        
        return d
    }()
    
    // MARK: - 银行卡名称
    lazy var cardsType: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.cardsName.LeftX, y: self.cardsName.BottomY, width: self.cardsName.Width, height: self.cardsName.Height))
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    lazy var cardNum: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.cardsName.LeftX, y: self.cardsType.BottomY + COMMON_MARGIN, width: self.cardsName.Width, height: 15 * SCREEN_SCALE))
        d.text = "622392839202829282"
        d.font = UIFont(name: "SimHei", size: 12 * SCREEN_SCALE)
        
        return d
    }()
    
    
    
    override var frame:CGRect{
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10/2
            newFrame.size.width -= 10
            newFrame.origin.y += 10
            newFrame.size.height -= 10
            super.frame = newFrame
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        
        model = CardType.init(cardsType: "存储卡")
        cardsType.text = model.cardsType
        
        cardNum.text = cardNum.text?.replaceIndexStr(replaceStr: cardNum.text!, replaceLength: 13, replaceStr: "**** **** **** ")
        
        //去除高亮效果
        self.selectionStyle = .none
        
        contentView.addSubview(bankIcon)
        contentView.addSubview(cardsType)
        contentView.addSubview(cardsName)
        contentView.addSubview(cardNum)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }
}

/// 我的银行卡第二组视图cell
// MARK: - 银行卡第二组视图
class AddCardCell: UITableViewCell {
    
    lazy var addICon: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.bounds.midY - 10 * SCREEN_SCALE, width: 20 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.backgroundColor = UIColor.gray
        return d
    }()
    
    fileprivate lazy var btn: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.addICon.RightX + COMMON_MARGIN / 2 , y: self.bounds.midY - 7.5 * SCREEN_SCALE, width: self.Width - self.addICon.Width + COMMON_MARGIN, height: 15 * SCREEN_SCALE))
        
        d.text = "添加银行卡"
        
        return d
    }()
    
    fileprivate lazy var discolerImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 20 * SCREEN_SCALE , y:self.bounds.midY - 10 * SCREEN_SCALE , width: 20 * SCREEN_SCALE , height: 20 * SCREEN_SCALE))
//        d.image = #imageLiteral(resourceName: "home")
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.layer.borderWidth = 1
        d.contentMode = UIViewContentMode.scaleAspectFit
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(addICon)
        contentView.addSubview(btn)
        contentView.addSubview(discolerImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



class TabViewCell: UITableViewCell {
    
    lazy var SeparatorLine: UIView = {
        let d: UIView = UIView.init(frame: CGRect.init(x: 0, y: self.Height, width: SCREEN_WIDTH, height: 0.5))
        d.backgroundColor = UIColor.lightGray
        return d
    }()
    
    lazy var frontIconim: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.bounds.midY - 12.5 * SCREEN_SCALE  , width: 25 * SCREEN_SCALE, height: 25 * SCREEN_SCALE))
        d.image = #imageLiteral(resourceName: "cashBag")
        d.contentMode = UIViewContentMode.scaleAspectFit
        return d
    }()
    
    lazy var descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.frontIconim.RightX + COMMON_MARGIN, y: self.bounds.midY - 12.5 * SCREEN_SCALE, width: self.Width - self.frontIconim.Width + COMMON_MARGIN * 3, height: 25 * SCREEN_SCALE))
        d.textColor = UIColor.black
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    fileprivate lazy var JianJIao: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 15 * SCREEN_SCALE - COMMON_MARGIN, y: self.bounds.midY - 7.5 * SCREEN_SCALE, width: 15 * SCREEN_SCALE, height: 15 * SCREEN_SCALE))
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.image = #imageLiteral(resourceName: "closuerimg")
        return d
    }()
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(frontIconim)
        contentView.addSubview(descLabel)
        contentView.addSubview(JianJIao)
        contentView.addSubview(SeparatorLine)
        
        // 取出点击效果
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 我的信息第一行Cell
class MyVCCell : UITableViewCell {
    
    lazy var AvatarHeadImg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: 60 * SCREEN_SCALE, height: 60 * SCREEN_SCALE))
        d.image = #imageLiteral(resourceName: "cashBag")
        d.contentMode = UIViewContentMode.scaleAspectFit
        return d
    }()
    
    fileprivate lazy var JianJIao: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 15 * SCREEN_SCALE - COMMON_MARGIN, y: self.bounds.midY + 15 * SCREEN_SCALE, width: 15 * SCREEN_SCALE, height: 15 * SCREEN_SCALE))
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.image = #imageLiteral(resourceName: "closuerimg")
        return d
    }()
    
    lazy var nameLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: self.AvatarHeadImg.RightX + COMMON_MARGIN, y: self.AvatarHeadImg.TopY + COMMON_MARGIN / 2, width: self.Width - self.AvatarHeadImg.Width - COMMON_MARGIN * 3, height: 20 * SCREEN_SCALE))
        d.text = "哈哈就看见好看"
        AccountModel.shared()?.nickName = d.text!
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        d.textColor = UIColor.white
        return d
    }()
    
    lazy var emailAddress: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.AvatarHeadImg.RightX + COMMON_MARGIN, y: self.nameLabel.BottomY + COMMON_MARGIN / 2, width: self.Width - self.AvatarHeadImg.Width - COMMON_MARGIN * 3, height: 20 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        d.text = "189879873@qq.com"
        AccountModel.shared()?.Email = d.text!
        d.textColor = UIColor.white
        return d
    }()
    
    lazy var SeparatorLine: UIView = {
        let d: UIView = UIView.init(frame: CGRect.init(x: 0, y: 80 * SCREEN_SCALE, width: SCREEN_WIDTH, height: 0.5))
        d.backgroundColor = UIColor.lightGray
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(AvatarHeadImg)
        contentView.addSubview(JianJIao)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailAddress)
        contentView.addSubview(SeparatorLine)
        
        // 取出点击效果
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        AvatarHeadImg.setImage(urlString: AccountModel.shared()?.HeadImg, placeholderImage: #imageLiteral(resourceName: "logo"))
        nameLabel.text = AccountModel.shared()?.TrueName
        emailAddress.text = AccountModel.shared()?.UserName
        
        CCog(message: AccountModel.shared()?.Token)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}











































