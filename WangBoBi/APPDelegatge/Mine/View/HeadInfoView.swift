//
//  HeadInfoView.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  首页公共信息栏，置顶

import UIKit

class HeadInfoView: UIView {
    
    // MARK: - 第一行(汇率换算、交易量)
    fileprivate lazy var sectionA: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 44 * SCREEN_SCALE))
        return d
    }()
    
    // MARK: - 交易量
    lazy var jiaoyiCoun: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: self.Width / 2, y: 0, width: self.Width / 2, height: 44 * SCREEN_SCALE))
        d.text = "王波比交易量"
        return d
    }()
    
    // MARK: - 汇率换算
    fileprivate lazy var moneyConvertLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.Width / 2, height: 44 * SCREEN_SCALE))
        d.textAlignment = .center
        d.text = "WBC/JPY:"
        return d
    }()

    
    // MARK: - 第二行
    lazy var sectionTwoV: MoneyV = {
        let d : MoneyV = MoneyV.init(frame: CGRect.init(x: 0, y: 44 * SCREEN_SCALE, width: self.Width, height: 100 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        d.layer.borderColor = UIColor.red.cgColor
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionA)
        
        self.layer.borderWidth = 1
        
        sectionA.addSubview(moneyConvertLabel)
        sectionA.addSubview(jiaoyiCoun)
        
        addSubview(sectionTwoV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 第二行视图
class MoneyV: UIView {
    // MARK: - 网博金币
    lazy var wbcLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.Width / 2 , height: 20 * SCREEN_SCALE))
        d.text = "600.00"
        d.textAlignment = .center
        return d
    }()
    
    lazy var jifenLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.Width / 2, y: 0, width: self.Width / 2, height: 20 * SCREEN_SCALE))
        d.text = "1321321分"
        d.textAlignment = .center
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(wbcLabel)
        addSubview(jifenLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
