//
//  PushingMoneyVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/29.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  充值

import UIKit

class PushingMoneyVC: BaseViewController,UITextFieldDelegate,BindPhoneFooterVDelegate {

    /// 背景图片
    fileprivate lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (749 / 640)))
        d.image = #imageLiteral(resourceName: "PushmoneyBg")
        d.isUserInteractionEnabled = true
        return d
    }()
    
    lazy var scrollView: UIScrollView = {
        let d : UIScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: self.bgImg.Height))
        d.contentSize = CGSize.init(width: SCREEN_WIDTH, height: self.bgImg.Height + 20)
        return d
    }()
    
    /// 尾部视图
    fileprivate lazy var footerView: BindPhoneFooterV = {
        let d : BindPhoneFooterV = BindPhoneFooterV.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - 60, width: SCREEN_WIDTH, height: 60))
        d.setFooterTitle(str: "充值")
        d.delegate = self
        return d
    }()
    
    /// 充值卡账号
    lazy var cardNumLabel: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.bgImg.Height * 0.66, width: SCREEN_WIDTH * 0.82, height: 30 * SCREEN_SCALE))
        
        d.delegate = self
        d.tag = 1111
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    /// 充值卡验证码
    lazy var cardPass: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.bgImg.Height * 0.816, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 30 * SCREEN_SCALE))
        d.delegate = self
        d.tag = 1112
        return d
    }()
    
    /// 照相机📷
    fileprivate lazy var cameraBn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: self.cardNumLabel.RightX, y: self.cardNumLabel.TopY, width: 50 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.addTarget(self, action: #selector(scanCodeSEL), for: .touchUpInside)
        return d
    }()

    /// 分割线
    lazy var line: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: 0.5))
        d.backgroundColor = UIColor.colorWithHexString("C8C7CB")
        return d
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let navBar = navigationController?.navigationBar

        navBar?.barTintColor = UIColor.white

        /// 修改导航栏文字样式（富文本）
        navBar?.titleTextAttributes = [
            
            NSForegroundColorAttributeName : UIColor.black,
            NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
        ]
        
        /// 设置
        navBar?.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "充值卡充值"
        
        view.addSubview(scrollView)
        view.addSubview(line)
        
        scrollView.addSubview(bgImg)
        view.addSubview(footerView)
        
        view.backgroundColor = COMMON_TBBGCOLOR
        
        bgImg.addSubview(cardNumLabel)
        bgImg.addSubview(cardPass)
        bgImg.addSubview(cameraBn)
        
        /// 接收通知
        NotificationCenter.default.addObserver(self, selector: #selector(changeCodeSEL), name: NSNotification.Name(rawValue: "changeScanCode"), object: nil)
    }
    
    /// 更新充值卡账号信息
    @objc fileprivate func changeCodeSEL() {

        if ScanModel.shared.codeStr?.characters.count != 0 {
        
            self.cardNumLabel.text = ScanModel.shared.codeStr
            
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "changeScanCode"), object: nil)
        }
        
    }
    
    
    /// 充值卡卡号
    fileprivate var cardNumStr : String?
    
    /// 充值卡验证码
    fileprivate var cardYZMStr : String?
    
    // MARK: - actionSEL methods
    @objc fileprivate func scanCodeSEL() {
        self.navigationController?.pushViewController(ScanCodeController(), animated: true)
    }


    // MARK: - bindPhonSELDelegate
    func bindPhonSELDelegate() {

        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }
        
        /// 模拟跳完成功界面
        self.navigationController?.pushViewController(PushMoneySuccessVC(), animated: true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.frame = CGRect.init(x: 0, y: -300 * SCREEN_SCALE, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }
        
        return true
    }
}
