//
//  CollectCell.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

/// 单个cell
class CollectCell: UICollectionViewCell {
    
    /// 描述文本
    lazy var descLabl: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.Height - 30, width: self.Width, height: self.Height * 0.3))
        d.layer.borderWidth = 1
        d.text = "ssss"
        return d
    }()
    
    /// 图片
    lazy var imgView: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: self.bounds)
        d.backgroundColor = UIColor.randomColor()
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(imgView)
        
        self.contentView.addSubview(descLabl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
