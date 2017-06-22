//
//  MoneyBagV.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/17.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  钱包试图

import UIKit

protocol MoneyBagVDelegate {
    
    /// 设置金额跳转
    func setMoneyPage() -> Void
}

class MoneyBagV: UIView {
    
    var delegate : MoneyBagVDelegate?

    // MARK: - 我要收款
    lazy var receiveImgIcon: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN * SCREEN_SCALE, y: SCREEN_SCALE * COMMON_MARGIN, width: 30 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.backgroundColor = UIColor.randomColor()
//        d.image = #imageLiteral(resourceName: "home")
        return d
    }()
    
    // MARK: - 我要收款文本
    lazy var wantLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.receiveImgIcon.RightX + COMMON_MARGIN, y: self.receiveImgIcon.Height * 0.5, width: self.Width * 0.5, height: 20 * SCREEN_SCALE))
        d.text = "我要收款"
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()

    
    /// 描述文本
    fileprivate lazy var descLabel: UILabel = {
        let f : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.receiveImgIcon.BottomY + COMMON_MARGIN * 2 * SCREEN_SCALE, width: self.Width, height: 20 * SCREEN_SCALE))
        f.text = "无需加好友，扫二维码向我付钱"
        f.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        f.textAlignment = .center
        return f
    }()
    
    // MARK: - codeImg
    lazy var codeView: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: self.Width * 0.25, y: self.descLabel.BottomY + COMMON_MARGIN, width: self.Width / 2, height: self.Width / 2))
//        d.image = #imageLiteral(resourceName: "home")
        d.backgroundColor = UIColor.randomColor()
        return d
    }()
    
    // MARK: - 设置金额
    lazy var setMoneyBtn: MoneyBtn = {
        let d : MoneyBtn = MoneyBtn.init(frame: CGRect.init(x: self.Width * 0.25, y: self.codeView.BottomY + COMMON_MARGIN * SCREEN_SCALE, width: self.Width * 0.25, height: 30 * SCREEN_SCALE))
        d.setTitle("设置金额", for: .normal)
        d.setTitleColor(UIColor.black, for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        d.titleLabel?.textAlignment = .left
        d.addTarget(self, action: #selector(setMoneySEL), for: .touchUpInside)
        d.layer.borderWidth = 1
        return d
    }()

    // MARK: - 保存图片
    lazy var saveImg: MoneyBtn = {
        let d : MoneyBtn = MoneyBtn.init(frame: CGRect.init(x: self.Width * 0.5, y: self.codeView.BottomY + COMMON_MARGIN * SCREEN_SCALE, width: self.Width * 0.25, height: 30 * SCREEN_SCALE))
        d.setTitle("保存图片", for: .normal)
        d.setTitleColor(UIColor.black, for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        d.titleLabel?.textAlignment = .right
        d.addTarget(self, action: #selector(saveImgSEL), for: .touchUpInside)
        d.layer.borderWidth = 1
        return d
    }()
    
    // MARK: - 钱包地址
    lazy var moneyAddress: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x:0 , y: self.setMoneyBtn.BottomY + COMMON_MARGIN * SCREEN_SCALE, width: self.Width, height: 20 * SCREEN_SCALE))
        d.text = "钱包地址：LR4S9LbwMk8SWYpzUerybNngEpyDWQjPJH"
        d.textAlignment = .center
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    // MARK: - 复制地址
    lazy var copyAddBtn: MoneyBtn = {
        let d : MoneyBtn = MoneyBtn.init(frame: CGRect.init(x: 0, y: self.moneyAddress.BottomY + COMMON_MARGIN * SCREEN_SCALE, width: self.Width, height: 20 * SCREEN_SCALE))
        d.setTitle("复制地址", for: .normal)
        d.titleLabel?.textAlignment = .center
        d.setTitleColor(UIColor.red, for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        d.addTarget(self, action: #selector(copyMoneyInfo), for: .touchUpInside)
        return d
    }()

    /// 复制地址
    @objc private func copyMoneyInfo() {
        CCog(message: "复制地址")
        UIPasteboard.general.string = "把卡"
        FTIndicator.showToastMessage("已拷贝文本，可复制使用")
    }
    
    /// 设置金额
    @objc private func setMoneySEL() {
        self.delegate?.setMoneyPage()
    }
    
    /// 保存图片
    @objc private func saveImgSEL() {
        CCog(message: "保存图片")
        
        
        let image = codeView.image
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(wantLabel)
        
        addSubview(receiveImgIcon)
        
        addSubview(descLabel)
        
        addSubview(codeView)
        addSubview(setMoneyBtn)
        
        addSubview(saveImg)
        addSubview(moneyAddress)
        addSubview(copyAddBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MoneyBtn : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
