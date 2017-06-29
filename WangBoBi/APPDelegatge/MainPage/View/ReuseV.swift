//
//  ReuseV.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

/// 头部复用视图
class ReuseV : UICollectionReusableView {
    
    lazy var sectionImg: BtnWithImage = {
        let d : BtnWithImage = BtnWithImage.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 20 * SCREEN_SCALE))
        d.setImage(#imageLiteral(resourceName: "suggest"), for: .normal)
        d.setTitle("猜你喜欢顶顶顶顶xxxxxxxxxxxx", for: .normal)
        return d
    }()
    
    lazy var titleLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: 44))
        d.text = "说的"
        d.textAlignment = .center
        return d
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sectionImg.center.x = self.center.x
        addSubview(titleLabel)
        addSubview(sectionImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
