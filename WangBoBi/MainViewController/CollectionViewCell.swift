//
//  CollectionViewCell.swift
//  NN
//
//  Created by 郑东喜 on 2017/4/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    
    /// 背景图片
    lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: self.Height))
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.layer.borderWidth = 1
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareUI() -> Void {
        addSubview(bgImg)
    }
}
