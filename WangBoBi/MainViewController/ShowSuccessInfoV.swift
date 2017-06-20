//
//  ShowSuccessInfoV.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/20.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  显示成功视图

import UIKit

class ShowSuccessInfoV: UIView {
    
    /// 显示图片
    fileprivate lazy var showInfoBgV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: self.bounds)
        d.image = #imageLiteral(resourceName: "tc")
        d.contentMode = UIViewContentMode.scaleAspectFit
        return d
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        let touchPoint: CGPoint? = touch?.location(in: self)
        print("\((touchPoint?.x)! / self.Width)==\((touchPoint?.y)! / self.Height)")
        let stringFloat = Int((touchPoint?.x)!)
        let stringFloat1 = Int((touchPoint?.y)!)
        print("\(stringFloat)\(stringFloat1)")
    }
    
    // MARK: - dismissBtn
    fileprivate lazy var dismissBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.447665044075049, y: SCREEN_HEIGHT * 0.655344195987867, width: 50 * SCREEN_SCALE, height: 50 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(dismissSELF), for: .touchUpInside)
        d.layer.borderWidth = 1
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(showInfoBgV)
        
        addSubview(dismissBtn)
  
    }
    
    @objc fileprivate func dismissSELF() {
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


