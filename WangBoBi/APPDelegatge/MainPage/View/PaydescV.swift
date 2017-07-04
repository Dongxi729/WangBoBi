//
//  PaydescV.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/28.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  说明视图

import UIKit

// MARK: - 付款说明
protocol PaydescVDelagete {
    
    func confirmSEL(str : String) -> Void
    func restoreBgColor() -> Void
    func canceelSEL()
}

// MARK: - 手机验证视图
class PaydescV : CommonV,UITextViewDelegate {
    
    var delegate : PaydescVDelagete?
    
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
    
    /// 显示标题文本
    fileprivate lazy var titleDescLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: COMMON_MARGIN / 2 * SCREEN_SCALE, width: self.Width, height: 30 * SCREEN_SCALE))
        d.text = "少时诵诗书所"
        d.textAlignment = .center
        d.font = UIFont.systemFont(ofSize: 15 * SCREEN_SCALE)
        return d
    }()
    
    
    /// 输入的内容描述文本
    fileprivate lazy var txtView: UITextView = {
        let d : UITextView = UITextView.init(frame: CGRect.init(x: COMMON_MARGIN * 1.49 * SCREEN_SCALE, y: self.Height * 0.28, width: self.Width * 0.83, height: 50 * SCREEN_SCALE))
        d.delegate = self        ///添加工具栏
//        d.layer.borderWidth = 1
//        d.layer.borderColor = UIColor.red.cgColor
        let toolBar = ToolBar()
        
        toolBar.seToolBarWithOne(confirmTitle: "完成", comfirmSEL: #selector(cancelBtnSEL), target: self)
        d.inputAccessoryView = toolBar
        
        return d
    }()
    
    /// 显示标题
    ///
    /// - Parameter ster: 标题内容
    func showTitle(ster : String) -> Void {
        addSubview(titleDescLabel)
        titleDescLabel.text = ster
    }
    
    @objc fileprivate func cancelBtnSEL() {
        self.txtView.endEditing(true)
        
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.frame = (UIApplication.shared.keyWindow?.rootViewController?.view.bounds)!
        }
    }
    
    
    /// 背景图片
    fileprivate lazy var bgImgV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: self.bounds)
        d.image = #imageLiteral(resourceName: "payDesc")
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(bgImgV)
        addSubview(txtView)
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
    
    // MARK: - UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.frame = CGRect.init(x: 0, y: -150 * SCREEN_SCALE, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        self.delegate?.confirmSEL(str: textView.text)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
