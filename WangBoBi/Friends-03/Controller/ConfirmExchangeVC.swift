//
//  ConfirmExchangeVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/8/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  确认转账

import UIKit

class ConfirmExchangeVC: BaseViewController,BindPhoneFooterVDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            
            UIApplication.shared.statusBarStyle = .default
            
            let navBar = self.navigationController?.navigationBar
            
            navBar?.barTintColor = UIColor.white
            self.navigationController?.navigationBar.isTranslucent = false
            
            /// 修改导航栏文字样式（富文本）
            navBar?.titleTextAttributes = [
                
                NSForegroundColorAttributeName : UIColor.black,
                NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
            ]
            
            /// 设置
            navBar?.tintColor = UIColor.white
        }
    }
    
    private lazy var footerV: BindPhoneFooterV = {
        let d: BindPhoneFooterV = BindPhoneFooterV.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - 64, width: SCREEN_WIDTH, height: 64))
        d.delegate = self
        d.setFooterTitle(str: "确认转账")
        return d
    }()
    
    private lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: (SCREEN_WIDTH - 2 * COMMON_MARGIN) * (554 / 602) - COMMON_MARGIN))
        d.image = #imageLiteral(resourceName: "exchangeBg")
        return d
    }()
    
    private lazy var headerImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: self.bgImg.bounds.midX - 15 * SCREEN_SCALE, y: self.bgImg.Height * 0.18, width: 30 * SCREEN_SCALE, height: SCREEN_SCALE * 30))
        d.layer.cornerRadius = 15 * SCREEN_SCALE
        d.image = #imageLiteral(resourceName: "bgV")
        d.clipsToBounds = true
        return d
    }()
    
    private lazy var confirm_nameLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.headerImg.BottomY, width: self.bgImg.Width, height: 20 * SCREEN_SCALE))
        d.text = "zdx"
        d.font = UIFont.systemFont(ofSize: 15 * SCREEN_SCALE)
        d.textColor = UIColor.lightGray
        d.textAlignment = .center
        return d
    }()
    
    /// 网博币地址
    private lazy var wbcLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.confirm_nameLabel.BottomY + 5 * SCREEN_SCALE, width: self.bgImg.Width, height: 30 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 18 * SCREEN_SCALE)
        d.text = "DSDS8OO80o08"
        d.textAlignment = .center
        return d
    }()
    
    private lazy var refundMoneyNum: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.bgImg.Height * 0.6, width: self.bgImg.Width, height: 20 * SCREEN_SCALE))
        d.textColor = UIColor.lightGray
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        d.textAlignment = .right
        d.text = "WBC" + "        " + "JPY" + "30000"
        return d
    }()
    
    private lazy var extraMoneyLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.refundMoneyNum.BottomY + 3 * SCREEN_SCALE, width: self.bgImg.Width, height: 20 * SCREEN_SCALE))
        d.textColor = UIColor.lightGray
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        d.textAlignment = .right
        d.text = "WBC" + "        " + "JPY" + "30000"
        return d
    }()
    
    lazy var extraPay: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: self.bgImg.Width * 0.7, y: self.extraMoneyLabel.BottomY + COMMON_MARGIN * 0.6 * SCREEN_SCALE, width: self.totalCountUp.Width, height: 15 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        d.addTarget(self, action: #selector(extraPaySEL), for: .touchUpInside)
        return d
    }()
    
    private lazy var totalCountUp: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.bgImg.Height * 0.88, width: self.bgImg.Width, height: 20 * SCREEN_SCALE))
        d.textColor = UIColor.lightGray
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        d.textAlignment = .right
        d.text = "WBC" + "        " + "JPY" + "30000"
        return d
    }()
    
    private lazy var totalCountDown: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.totalCountUp.BottomY + 3 * SCREEN_SCALE, width: self.bgImg.Width, height: 20 * SCREEN_SCALE))
        d.textColor = UIColor.lightGray
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        d.textAlignment = .right
        d.text = "WBC" + "        " + "JPY" + "30000"
        return d
    }()
    
    /// 背景视图
    private lazy var maskV: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: (SCREEN_WIDTH - 2 * COMMON_MARGIN) * (554 / 602) + COMMON_MARGIN))
        d.backgroundColor = UIColor.white
        return d
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "确认转账"
        view.addSubview(maskV)
        view.backgroundColor = UIColor.white
        
        maskV.addSubview(bgImg)
        view.addSubview(footerV)
        view.backgroundColor = COMMON_TBBGCOLOR
        
        bgImg.addSubview(confirm_nameLabel)
        bgImg.addSubview(headerImg)
        bgImg.addSubview(refundMoneyNum)
        bgImg.addSubview(extraMoneyLabel)
        bgImg.addSubview(totalCountUp)
        bgImg.addSubview(totalCountDown)
        bgImg.addSubview(wbcLabel)
        bgImg.addSubview(extraPay)
    }
    
    // MARK: - BindPhoneFooterVDelegate
    func bindPhonSELDelegate() {
        CCog(message: "确认转账")
    }

    @objc private func extraPaySEL() {
        CCog(message: "手续费事件")
    }
}
