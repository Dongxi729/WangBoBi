//
//  PayPassInputV.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  支付密码视图

import UIKit


// MARK: - 付款说明
protocol PayPassInputVDelagete {
    
    func confirmSEL(str : String) -> Void
    func restoreBgColor() -> Void
    func canceelSEL()
}

// MARK: - 手机验证视图
class PayPassInputV : CommonV {
    
    var delegate : PayPassInputVDelagete?
    
    /// 取消
    lazy var cancelBtn: UIButton = {
        let d: UIButton = UIButton.init(frame: CGRect.init(x: self.Width * 0.0770646247310915, y: self.Height * 0.766692546583851, width: self.Width * 0.4, height: self.Height * 0.2))
        d.layer.borderWidth = 1
        d.addTarget(self, action: #selector(cancelSEL), for: .touchUpInside)
        return d
    }()
    
    
    /// 确定事件
    lazy var confirm: UIButton = {
        let D : UIButton = UIButton.init(frame: CGRect.init(x: self.Width * 0.593512767425811, y: self.cancelBtn.TopY, width: self.cancelBtn.Width, height: self.cancelBtn.Height))
        D.layer.borderWidth = 1
        D.addTarget(self, action: #selector(confirmSEL), for: .touchUpInside)
        return D
    }()
    /// 背景图片
    fileprivate lazy var bgImgV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: self.bounds)
        d.image = #imageLiteral(resourceName: "payPassV")
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImgV)
        addSubview(cancelBtn)
        addSubview(confirm)
    }
    
    @objc fileprivate func sendAuthSEL(sender : CountDownBtn) {
        sender.initwith(color: UIColor.colorWithHexString("E6E6E6"), title: "点击获取验证码", superView: self)
    }
    
    /// 取消事件
    @objc fileprivate func cancelSEL() {
        self.removeFromSuperview()
        
        /// 视图正常
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.frame = (UIApplication.shared.keyWindow?.rootViewController?.view.bounds)!
        }
        
        self.delegate?.canceelSEL()
    }
    
    /// 确定事件
    @objc fileprivate func confirmSEL() {
        self.removeFromSuperview()
        
        self.delegate?.restoreBgColor()
        
        /// 视图正常
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.frame = (UIApplication.shared.keyWindow?.rootViewController?.view.bounds)!
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
