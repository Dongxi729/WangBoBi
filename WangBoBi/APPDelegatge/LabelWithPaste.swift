//
//  LabelWithPaste.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/8/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  带有长按黏贴功能的label

import UIKit

class LabelWithPaste : UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        let tapGes = UILongPressGestureRecognizer.init(target: self, action: #selector(copyText))
        self.addGestureRecognizer(tapGes)
    }
    
    
    func copyText() -> Void {
        UIPasteboard.general.string = self.text
        let acvc = UIAlertController.init(title: "已选择复制内容", message: "", preferredStyle: .alert)
        let confirmBtn = UIAlertAction.init(title: "好的", style: .default, handler: nil)
        
        acvc.addAction(confirmBtn)
        UIApplication.shared.keyWindow?.rootViewController?.present(acvc, animated: true, completion: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
