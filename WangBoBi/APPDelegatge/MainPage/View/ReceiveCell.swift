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
