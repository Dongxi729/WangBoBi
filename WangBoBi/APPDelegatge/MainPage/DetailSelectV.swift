//
//  DetailSelectV.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/8/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  账单选择类型视图

import UIKit

protocol DetailSelectVDelegate {
    func detailSelectSel(indexPath : IndexPath)
    func detailDelegateCancel()
    func detailDelegateConfirm()
}

class DetailSelectV: UIView,CustomCollectDelegate {
    
    var detailSelectDelegate : DetailSelectVDelegate?
    
    /// 背景图片
    private lazy var detaiLSelectBg: UIImageView = {
        let d: UIImageView = UIImageView.init(frame: self.bounds)
        d.image = UIImage.init(named: "selectDetailType")
        return d
    }()
    
    
    lazy var detailSaveBtn: UIButton = {
        let d: UIButton = UIButton.init(frame: CGRect.init(x: self.detailCancel.RightX, y: self.selctCtCollectV.BottomY, width: self.Width * 0.5, height: self.Height * 0.25))
        d.addTarget(self, action: #selector(detailSaveBtnSel), for: .touchUpInside)
        return d
    }()
    
    lazy var detailCancel: UIButton = {
        let d: UIButton = UIButton.init(frame: CGRect.init(x: 0, y: self.selctCtCollectV.BottomY, width: self.Width * 0.5, height: self.Height * 0.25))
        d.addTarget(self, action: #selector(detailCancenSel), for: .touchUpInside)
        return d
    }()
    
    @objc private func detailSaveBtnSel() {
        self.detailSelectDelegate?.detailDelegateConfirm()
    }
    
    @objc private func detailCancenSel() {
        self.detailSelectDelegate?.detailDelegateCancel()
    }
    
    lazy var selctCtCollectV: CustomCollect = {
        let d : CustomCollect = CustomCollect.init(["全部","收款","付款","充值卡"], CGRect.init(x: 5, y: self.Height * 0.25, width: self.Width - 10, height: self.Height * 0.5), CGSize.init(width: ((self.Width - COMMON_MARGIN) - 30) / 3, height: self.Height * 0.2))
        d.delegate = self
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(detaiLSelectBg)
        addSubview(selctCtCollectV)
        
        addSubview(detailSaveBtn)
        addSubview(detailCancel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectCell(_ indexPath: IndexPath) {
        self.detailSelectDelegate?.detailSelectSel(indexPath: indexPath)
    }
    
}
