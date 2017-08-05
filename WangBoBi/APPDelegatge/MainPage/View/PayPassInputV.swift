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
    
    /// 输出密码
    func passStrOutput(str :String) -> Void
}

// MARK: - 手机验证视图
class PayPassInputV : CommonV {
    
    var delegate : PayPassInputVDelagete?
    
    /// 取消
    lazy var cancelBtn: UIButton = {
        let d: UIButton = UIButton.init(frame: CGRect.init(x: self.Width * 0.0770646247310915, y: self.Height * 0.766692546583851, width: self.Width * 0.4, height: self.Height * 0.2))
        d.addTarget(self, action: #selector(cancelSEL), for: .touchUpInside)
        return d
    }()
    
    
    /// 确定事件
    lazy var confirm: UIButton = {
        let D : UIButton = UIButton.init(frame: CGRect.init(x: self.Width * 0.593512767425811, y: self.cancelBtn.TopY, width: self.cancelBtn.Width, height: self.cancelBtn.Height))
        D.addTarget(self, action: #selector(confirmSEL), for: .touchUpInside)
        return D
    }()
    /// 背景图片
    fileprivate lazy var bgImgV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: self.bounds)
        d.image = #imageLiteral(resourceName: "payPassV")
        return d
    }()
    
    /// 输入密码视图
    fileprivate lazy var passV: XLPasswordInputView = {
        let d : XLPasswordInputView = XLPasswordInputView.init(frame: CGRect(x: COMMON_MARGIN, y: self.center.y + COMMON_MARGIN * SCREEN_SCALE, width: self.Width - 2 * COMMON_MARGIN , height: 30 * SCREEN_SCALE))
        d.layer.borderColor = UIColor.gray.cgColor
        return d
    }()
    
    /// 网博币
    lazy var wbcLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.Height * 0.35, width: self.Width - 2 * COMMON_MARGIN, height: 20 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 20 * SCREEN_SCALE)
        d.textAlignment = .center
        return d
    }()
    
    /// 可用网博币
    lazy var avaluableLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.Height * 0.35 + 20 * SCREEN_SCALE, width: self.Width - 2 * COMMON_MARGIN, height: 10 * SCREEN_SCALE))
        
        /// 可用余额显示
        if AccountModel.shared()?.WBC != nil {
            d.text = "可用WBC" + (AccountModel.shared()?.WBC)!
        } else {
            d.text = "可用WBC"
        }
        
        
        d.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        d.textAlignment = .center
        d.textColor = UIColor.colorWithHexString("E5711F")
        return d
    }()
    
    /// 密码字符串
    var passStr : String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImgV)
        addSubview(cancelBtn)
        addSubview(confirm)
        addSubview(passV)
        
        addSubview(wbcLabel)
        addSubview(avaluableLabel)
        
//        wbcLabel.text = "WBC100"
        passV.passwordBlock = {(params) -> Void in
            
            self.passStr = params
            
            self.delegate?.passStrOutput(str: self.passStr!)
            print(params!)
        }
    }
    
    /// 取消事件
    @objc fileprivate func cancelSEL() {
        self.removeFromSuperview()
        
  
        
        self.delegate?.canceelSEL()
    }
    
    /// 确定事件
    @objc fileprivate func confirmSEL() {
        
        CCog(message: "////")
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
