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

    var dataSource : IndexCommentTopModel? {
        didSet {

            self.descLabl.text = dataSource?.Title
            self.commentLabel.text = dataSource?.Num?.stringValue
            self.imgView.setImage(urlString: dataSource?.HeadImg, placeholderImage: #imageLiteral(resourceName: "logo"))
        }
    }
    
    var dataSource2 : IndexMertopModel? {
        didSet {

        }
    }
    
    
    /// 描述文本
    lazy var descLabl: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.Height * 0.75, width: self.Width, height: 20 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        d.text = "ssss"
        return d
    }()
    
    /// 评论图片
    fileprivate lazy var commentImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: self.descLabl.BottomY, width: 15 * SCREEN_SCALE, height: 15 * SCREEN_SCALE))
        d.image = #imageLiteral(resourceName: "like")
        return d
    }()
    
    /// 评论
    lazy var commentLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.descLabl.BottomY, y: self.descLabl.LeftX, width: self.Width, height: 15 * SCREEN_SCALE))
        
        return d
    }()
    
    
    /// 图片
    lazy var imgView: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.Height * 0.75, height: self.Height * 0.75))
        d.image = #imageLiteral(resourceName: "failBg")
        d.backgroundColor = UIColor.randomColor()
        d.contentMode = UIViewContentMode.scaleAspectFit
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(imgView)
        
        self.contentView.addSubview(descLabl)
        self.contentView.addSubview(self.commentImg)
        
        self.contentView.addSubview(commentLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
