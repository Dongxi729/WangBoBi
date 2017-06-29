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
    
//    lazy var sectionImg: UIImageView = {
//        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>))
//        return <#value#>
//    }()
    
    lazy var titleLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: 44))
        d.text = "说的"
        d.textAlignment = .center
        return d
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
