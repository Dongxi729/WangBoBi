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
        d.image = #imageLiteral(resourceName: "home")
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
