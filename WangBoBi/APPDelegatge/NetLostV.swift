//
//  NetLostV.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/2.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  网络丢失视图

import UIKit

protocol NetLostVDelegate {
    func TapToloadSEL()
}

class NetLostV: UIView {
    
    var delegate : NetLostVDelegate?
    
    fileprivate lazy var imgView: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: self.bounds)
//        CGRect.init(x: 0, y: 0, width: width, height: width * (116 / 123))
        d.image = #imageLiteral(resourceName: "reloadBtn")
        d.isUserInteractionEnabled = true
        /// 添加手势事件
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(imgTapToReload))
        return d
    }()
    
    @objc fileprivate func imgTapToReload() {
        self.delegate?.TapToloadSEL()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
