
//
//  HeadReuse.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

/// 第一行头部视图
protocol HeadReuseDelegate {
    func chooseIndex(index : Int) -> Void
}

class HeadReuse : UICollectionReusableView {
    
    // MARK: - 广告视图
    lazy var bannerImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: self.headBgImg.BottomY, width: SCREEN_WIDTH, height: SCREEN_WIDTH *  (309 / 640)))
        d.image = #imageLiteral(resourceName: "banner")
        
        return d
    }()

    
    /// 补充的头部文字
    lazy var sectionImg: BtnWithImage = {
        let d : BtnWithImage = BtnWithImage.init(frame: CGRect.init(x: SCREEN_WIDTH / 2 - 40 * SCREEN_SCALE, y: self.bannerImg.BottomY, width: 80 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        d.setTitle("猜你喜欢顶顶顶顶xxxxxxxxxxxx", for: .normal)
        return d
    }()
    
    /// 网博币余额
    lazy var WBCLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.headBgImg.Height * 0.28, width: self.Width, height: 30 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 25 * SCREEN_SCALE)
        d.text = AccountModel.shared()?.WBC
        d.textAlignment = .center
        return d
    }()
    
    /// 网博币/人民币
    lazy var wbBToJp: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: self.Width * 0.173913043478261, y: self.headBgImg.Height * 0.415, width: 90 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    /// 网博币/日币
    lazy var wbBToRp: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: self.Width * 0.173913043478261, y: self.headBgImg.Height * 0.48, width: 75 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    /// 网博币/人民币转换后的
    lazy var convertWBCToR: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.42, y: self.headBgImg.Height * 0.413, width: self.Width * 0.4, height: self.wbBToJp.Height))
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        d.text = "2000.0000"
        return d
    }()
    
    lazy var convertWBCToJ: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.39 , y: self.headBgImg.Height * 0.475, width: self.Width * 0.4, height: self.wbBToRp.Height))
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        
        d.text = "2000.0000"
        return d
    }()
    
    /// 头部背景图片
    fileprivate lazy var headBgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (749 / 640)))
        d.image = #imageLiteral(resourceName: "main_Bar")
        return d
    }()
    
    
    // MARK: - 积分
    lazy var jifenLabel: UILabel = {
        let d:UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN * 1.5, y: self.headBgImg.Height * 0.670093651942526, width: (SCREEN_WIDTH / 2 - 2 * COMMON_MARGIN), height: 20 * SCREEN_SCALE))
        d.text = AccountModel.shared()?.Integral.stringValue
        d.textColor = COMMON_BGCOLOR
        d.textAlignment = .center
        d.font = UIFont.systemFont(ofSize: 14 * SCREEN_SCALE)
        return d
    }()
    
    // MARK: - 交易量
    lazy var WBCSubmitCounts: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.jifenLabel.RightX + COMMON_MARGIN * 0.9, y: self.jifenLabel.TopY, width: self.jifenLabel.Width, height: self.jifenLabel.Height))
        d.textColor = COMMON_BGCOLOR
        d.font = UIFont.systemFont(ofSize: 14 * SCREEN_SCALE)
        d.textAlignment = .center
        d.text = "6789876"
        return d
    }()
    
    var buttons : UIButton!
    
    var delegate : HeadReuseDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headBgImg)
        
        let tag = 600
        for index in 0..<4 {
            self.buttons = UIButton.init(frame: CGRect.init(x: CGFloat(index) * self.Width / 4, y: self.headBgImg.Height * 0.8, width: self.Width / 4 , height: self.Height * 0.2))
            //            self.buttons.backgroundColor = UIColor.randomColor()
            self.buttons.tag = tag + index
            self.buttons.addTarget(self, action: #selector(buttonSEL(sender:)), for: .touchUpInside)
            addSubview(buttons)
        }
        
        headBgImg.addSubview(WBCLabel)
        headBgImg.addSubview(wbBToJp)
        headBgImg.addSubview(wbBToRp)
        headBgImg.addSubview(convertWBCToR)
        headBgImg.addSubview(convertWBCToJ)
        
        headBgImg.addSubview(jifenLabel)
        headBgImg.addSubview(WBCSubmitCounts)
        
        addSubview(bannerImg)
        addSubview(sectionImg)
        
 
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSEL), name: NSNotification.Name(rawValue: "reloadInfo"), object: nil)
    }
    
    @objc fileprivate func reloadSEL() {
        /// 余额
        self.WBCLabel.text = AccountModel.shared()?.WBC
        
        /// 积分
        self.jifenLabel.text = AccountModel.shared()?.Integral.stringValue
        
        /// 交易量
        
        /// 网博/人民币兑换
        
        /// 网博/日币兑换
        
        /// banner图片链接地址
    }
    
    @objc fileprivate func buttonSEL(sender : UIButton) {
        self.delegate?.chooseIndex(index: sender.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
