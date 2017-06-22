//
//  ShowFailV.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/20.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  显示失败视图

import UIKit

protocol ShowFailVDelegte {
    func failExtra() -> Void
}

class ShowFailV: UIView {
    
    var delegate : ShowFailVDelegte?
    
    /// 显示图片
    fileprivate lazy var showInfoBgV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: self.bounds)
        d.image = #imageLiteral(resourceName: "failBg")
        d.contentMode = UIViewContentMode.scaleAspectFit
        return d
    }()

    
    // MARK: - dismissBtn
    fileprivate lazy var dismissBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.447665044075049, y: SCREEN_HEIGHT * 0.655344195987867, width: 50 * SCREEN_SCALE, height: 50 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(dismissSELF), for: .touchUpInside)
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(showInfoBgV)
        
        addSubview(dismissBtn)
        
        self.backgroundColor = UIColor.colorWithHexString("7F7F7F", alpha: 0.8)
    }
    
    @objc fileprivate func dismissSELF() {
        self.delegate?.failExtra()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


