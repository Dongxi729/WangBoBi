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
        let d : BtnWithImage = BtnWithImage.init(frame: CGRect.init(x: SCREEN_WIDTH / 2 - 40 * SCREEN_SCALE, y: 0, width: 80 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        d.setTitle("猜你喜欢顶顶顶顶xxxxxxxxxxxx", for: .normal)
        return d
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(sectionImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
