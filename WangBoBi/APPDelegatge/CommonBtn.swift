//
//  CommonBtn.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/18.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  通用的按钮---文本占据全部大小

import UIKit

class CommonBtn: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
