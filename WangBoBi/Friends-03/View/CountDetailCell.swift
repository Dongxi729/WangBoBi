//
//  CountDetailCell.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/27.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  账单详情cell

import UIKit

class CountDetailCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(countcell_left)
        contentView.addSubview(count_right)
        
        self.selectionStyle = .none
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var countcell_left: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: 0, width: SCREEN_WIDTH, height: self.Height))
        d.font = UIFont.systemFont(ofSize: 12)
        d.text = "dd"
        return d
    }()
    
    lazy var count_right: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH - COMMON_MARGIN, height: self.Height))
        d.font = UIFont.systemFont(ofSize: 12)
        d.text = "dd"
        d.textAlignment = .right
        return d
    }()
}
