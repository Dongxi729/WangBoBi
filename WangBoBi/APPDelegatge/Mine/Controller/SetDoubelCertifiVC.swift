
//
//  SetDoubelCertifiVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/16.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  设置双重认证

import UIKit

class SetDoubelCertifiVC: UIViewController,PhoneCerViewDelegate {

    fileprivate lazy var bachV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: (SCREEN_WIDTH - 2 * COMMON_MARGIN) * (598 / 605)))
        d.image = #imageLiteral(resourceName: "passCertiBg")
        return d
    }()
    
    lazy var Bttn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: self.bachV.Height * 0.93, width: SCREEN_WIDTH, height: 40 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        d.addTarget(self, action: #selector(gotoCertiDoublePass), for: .touchUpInside)
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "设置双重认证"
        view.addSubview(bachV)
        view.addSubview(Bttn)
        
        view.backgroundColor = UIColor.white
    }
    
    lazy var alertPassView: PhoneCerView = {
    let d : PhoneCerView = PhoneCerView.init(frame: CGRect.init(x: (SCREEN_WIDTH / 2) - (SCREEN_WIDTH * 0.9) / 2 , y: SCREEN_HEIGHT / 2 - ((SCREEN_WIDTH * 0.9) * (320 / 450) / 2) - 64, width: SCREEN_WIDTH * 0.9, height: (SCREEN_WIDTH * 0.9) * (320 / 450)))
        d.delegate = self
        return d
    }()
    
    func gotoCertiDoublePass() {

        view.backgroundColor = UIColor.colorWithHexString("7F7F7F", alpha: 0.8)
        view.addSubview(alertPassView)
        zdx_setupButtonSpringAnimation(alertPassView)
    }
    
    // MARK: - PhoneCerViewDelegate
    func restoreBGColor() {
        view.backgroundColor = UIColor.white
    }

}

protocol PhoneCerViewDelegate {
    func restoreBGColor() -> Void
}

// MARK: - 手机验证视图
class PhoneCerView : UIView,UITextFieldDelegate {
    
    var delegate : PhoneCerViewDelegate?
    
    lazy var yzmLabel: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: self.phNum.LeftX, y: self.Height * 0.47, width: self.Width * 0.4, height: self.phNum.Height))
        d.placeholder = "验证码"
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        
        return d
    }()
    
    /// 手机号
    fileprivate lazy var phNum: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: self.Width * 0.177938808373591, y: self.Height * 0.255, width: self.Width * 0.7, height: 30 * SCREEN_SCALE))
        d.placeholder = "手机号码"
        d.delegate = self
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        
        return d
    }()
    
    /// 取消
    lazy var cancelBtn: UIButton = {
        let d: UIButton = UIButton.init(frame: CGRect.init(x: self.Width * 0.1, y: self.Height * 0.73525561687451, width: self.Width * 0.4, height: self.Height * 0.2))
        
        d.addTarget(self, action: #selector(dismissSELF), for: .touchUpInside)
        return d
    }()
    
    lazy var sendAuthCode: CountDownBtn = {
        let d : CountDownBtn = CountDownBtn.init(frame: CGRect.init(x: self.yzmLabel.RightX + COMMON_MARGIN / 2 * SCREEN_SCALE, y: self.yzmLabel.TopY, width: self.Width * 0.285, height: self.yzmLabel.Height))
        d.setTitle("点击获取验证码", for: .normal)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        d.setTitleColor(UIColor.black, for: .normal)
        d.addTarget(self, action: #selector(sendAuthSEL(sender:)), for: .touchUpInside)
        
        return d
    }()
    
    /// 验证事件
    lazy var yzmBtn: UIButton = {
        let D : UIButton = UIButton.init(frame: CGRect.init(x: self.Width * 0.5, y: self.cancelBtn.TopY, width: self.cancelBtn.Width, height: self.cancelBtn.Height))
        D.addTarget(self, action: #selector(confirmSEL), for: .touchUpInside)
        return D
    }()
    
    
    
    /// 背景图片
    lazy var bgImgV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: self.bounds)
        d.image = #imageLiteral(resourceName: "alertPassV")
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImgV)
        addSubview(cancelBtn)
        addSubview(yzmBtn)
        
        addSubview(phNum)
        addSubview(yzmLabel)
        
        addSubview(sendAuthCode)
    }
    
    @objc fileprivate func sendAuthSEL(sender : CountDownBtn) {
        sender.initwith(color: UIColor.colorWithHexString("E6E6E6"), title: "点击获取验证码", superView: self)
    }
    
    /// 验证事件
    @objc fileprivate func confirmSEL() {
        
        /// 验证电话格
        if phNum.text?.characters.count > 0 {
            if !(phNum.text?.checkMobile(mobileNumbel: phNum.text! as NSString))! {
                toast(toast: "电话格式不对")
                return
            }
        } else {
            toast(toast: "电话不为空")
            return
        }
        
        if yzmLabel.text?.characters.count > 0 {
            if !(yzmLabel.text?.checkAuthStr(password: yzmLabel.text! as NSString))! {
                toast(toast: "验证码格式不对")
                return
            }
        } else {
            toast(toast: "验证码不为空")
            return
        }
        
            
        ////...
//        self.removeFromSuperview()
        self.delegate?.restoreBGColor()
    }
    
    // MARK: - UitextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.frame = CGRect.init(x: 0, y: -150 * SCREEN_SCALE, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }
        
        return true
    }
    
    /// 取消事件
    @objc fileprivate func dismissSELF() {
        self.removeFromSuperview()
        self.delegate?.restoreBGColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
