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

    /// 头条推荐
    var dataSource : IndexCommentTopModel? {
        didSet {

            self.descLabl.text = dataSource?.Title
            self.commentLabel.text = (dataSource?.Num)! + " 好评"
            self.imgView.setImage(urlString: dataSource?.HeadImg, placeholderImage: #imageLiteral(resourceName: "logo"))
        }
    }
    
    /// 热评商户
    var dataSource2 : IndexMertopModel? {
        didSet {
            self.descLabl.text = dataSource2?.Company
            self.commentImg.image = #imageLiteral(resourceName: "saw")
            self.commentLabel.text = (dataSource2?.Num)!
            self.commentLabel.textColor = UIColor.gray
            self.imgView.setImage(urlString: dataSource2?.LogoImg, placeholderImage: #imageLiteral(resourceName: "logo"))
        }
    }
    
    
    /// 描述文本
    lazy var descLabl: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.imgView.BottomY + 5 * SCREEN_SCALE, width: self.Width, height: 13 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    /// 评论图片
    fileprivate lazy var commentImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: self.descLabl.BottomY + COMMON_MARGIN / 2, width: 13 * SCREEN_SCALE, height: 13 * SCREEN_SCALE))
        d.image = #imageLiteral(resourceName: "like")
        d.contentMode = UIViewContentMode.scaleAspectFit
        return d
    }()
    
    /// 评论
    lazy var commentLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.commentImg.RightX + COMMON_MARGIN / 2, y:self.commentImg.TopY , width: self.Width, height: 15 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        d.textColor = UIColor.red
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
    
    /// 顶部视图
    lazy var topView: TopV = {
        let d : TopV = TopV.init(frame: CGRect.init(x: COMMON_MARGIN, y: 0, width: self.Width * 0.4, height: (30 / 74) * self.Width * 0.4))
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.addSubview(imgView)
        
        self.contentView.addSubview(descLabl)
        self.contentView.addSubview(self.commentImg)
        
        self.contentView.addSubview(commentLabel)
        self.contentView.addSubview(topView)
        topView.setLabelNo(str: "TopDDD")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class TopV: UIView {
    lazy var topBgV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: self.Height))
        d.image = #imageLiteral(resourceName: "top")
        return d
    }()
    
    lazy var commentLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: self.bounds)
        d.textAlignment = .center
        d.textColor = UIColor.white
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    func setLabelNo(str : String) -> Void {
        addSubview(commentLabel)
        commentLabel.text = str
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topBgV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
