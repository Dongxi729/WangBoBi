//
//  FriendHeader.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/8/4.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

protocol FriendHeaderDelegate {
    func jumpToNewFriendVC()
}

/// 我的朋友表格头视图
class FriendHeader: UIView {
    
    
    var delegate : FriendHeaderDelegate?
    
    lazy var headIcon: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN * 0.5, width: self.Height - COMMON_MARGIN, height: self.Height - COMMON_MARGIN))
        d.image = #imageLiteral(resourceName: "addFriIcon")
        return d
    }()
    
    lazy var descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.headIcon.RightX + COMMON_MARGIN, y: self.headIcon.TopY, width: SCREEN_WIDTH - 2 * COMMON_MARGIN - self.headIcon.Width, height: self.headIcon.Height))
        d.text = "新的朋友"
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headIcon)
        addSubview(descLabel)
        self.backgroundColor = UIColor.white
        
        self.isUserInteractionEnabled = true
        
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(tapSEL))
        self.addGestureRecognizer(tapGes)
    }
    
    // MARK: - 交互事件
    @objc fileprivate func tapSEL() {
        self.delegate?.jumpToNewFriendVC()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
