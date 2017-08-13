//
//  TransferVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/8/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  转账界面

import UIKit

class TransferVC: BaseViewController,UITextFieldDelegate,PickVDelegate,BindPhoneFooterVDelegate {
    
    /// 背景图片
    private lazy var bgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (361 / 640)))
        d.image = #imageLiteral(resourceName: "TransFerBgImg")
        d.isUserInteractionEnabled = true
        return d
    }()
    
    
    /// 转账地址tf
    private lazy var transformLabel: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.2, y: self.bgImg.Height * 0.25, width: SCREEN_WIDTH - SCREEN_WIDTH * 0.2, height: 30 * SCREEN_SCALE))
        let toolBar = ToolBar()
        toolBar.seToolBarWithOne(confirmTitle: "完成", comfirmSEL: #selector(transferDone), target: self)
        d.inputAccessoryView = toolBar
        d.tag = 111
        d.delegate = self
        return d
    }()
    
    
    /// 转账地址占位符
    private lazy var placeHoderLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: self.transformLabel.frame)
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        d.text = "请输入转账地址"
        d.textColor = UIColor.lightGray
        return d
    }()
    
    //////////////////////////////////////////////////////////////////////////////////////
    
    /// 网博币地址
    private lazy var wbcLabel: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: self.transformLabel.LeftX, y: self.transformLabel.BottomY + COMMON_MARGIN * SCREEN_SCALE, width: 90 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        let toolBar = ToolBar()
        toolBar.seToolBarWithOne(confirmTitle: "完成", comfirmSEL: #selector(inputWbc), target: self)
        d.inputAccessoryView = toolBar
        d.tag = 222
        d.delegate = self
        
        return d
    }()
    
    
    /// 网博币占位符
    private lazy var wbcPlaceHolder: UILabel = {
        let d : UILabel = UILabel.init(frame: self.wbcLabel.frame)
        d.text = "0.00"
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        d.textColor = UIColor.lightGray
        return d
    }()
    
    /// 兑换文本
    private lazy var exhangeTF: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.7, y: self.wbcPlaceHolder.TopY, width: 100 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        let toolBar = ToolBar()
        toolBar.seToolBarWithOne(confirmTitle: "完成", comfirmSEL: #selector(exchangeSEL), target: self)
        d.tag = 333
        d.inputAccessoryView = toolBar
        d.delegate = self
        return d
    }()
    
    private lazy var exchangePlaceHolder: UILabel = {
        let d: UILabel = UILabel.init(frame: self.exhangeTF.frame)
        d.text = "0.00"
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        d.textColor = UIColor.lightGray
        return d
    }()
    
    //////////////////////////////////////////////////////////////////////////////////////
    /// 城市选择器
    private lazy var city: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: self.wbcPlaceHolder.RightX, y: self.wbcPlaceHolder.TopY, width: 30 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        let cityV : PickerV = PickerV.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 200))
        cityV.delegate = self
        d.inputView = cityV
        
        let toolBar = ToolBar()
        toolBar.seToolBarWithOne(confirmTitle: "完成", comfirmSEL: #selector(cityChoose), target: self)
        d.text = "JPY"
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    //////////////////////////////////////////////////////////////////////////////////////
    private lazy var desc: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.wbcLabel.BottomY, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 20 * SCREEN_SCALE))
        d.text = "敖德萨多撒多"
        d.textColor = UIColor.colorWithHexString("2796DD")
        d.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        return d
    }()
    
    //////////////////////////////////////////////////////////////////////////////////////
    lazy var footerV: BindPhoneFooterV = {
        let d:BindPhoneFooterV = BindPhoneFooterV.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - 64, width: SCREEN_WIDTH, height: 64))
        d.delegate = self
        d.setFooterTitle(str: "提交转账")
        return d
    }()
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(bgImg)
        
        title = "转账信息"
        
        bgImg.addSubview(transformLabel)
        bgImg.addSubview(placeHoderLabel)
        
        bgImg.addSubview(wbcLabel)
        bgImg.addSubview(wbcPlaceHolder)
        
        bgImg.addSubview(exhangeTF)
        bgImg.addSubview(exchangePlaceHolder)
        
        bgImg.addSubview(city)
        bgImg.addSubview(desc)
        
        view.addSubview(footerV)
        
        view.backgroundColor = COMMON_TBBGCOLOR
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case 111:
            self.placeHoderLabel.isHidden = true
            break
            
        case 222:
            self.wbcPlaceHolder.isHidden = true
            break
        case 333:
            self.exchangePlaceHolder.isHidden = true
            break
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 111:
            if textField.text?.characters.count == 0{
                self.placeHoderLabel.isHidden = false
            }
            break
        case 222:
            if textField.text?.characters.count == 0{
                self.wbcPlaceHolder.isHidden = false
            }
            break
        case 333:
            if textField.text?.characters.count == 0{
                self.exchangePlaceHolder.isHidden = false
            }
            break
        default:
            break
        }
    }
    
    
    
    @objc private func transferDone() {
        self.transformLabel.resignFirstResponder()
        
        if self.transformLabel.text?.characters.count == 0 {
            self.placeHoderLabel.isHidden = false
        }
    }
    
    @objc private func inputWbc() -> Void {
        self.wbcLabel.resignFirstResponder()
        
        if self.wbcLabel.text?.characters.count == 0 {
            self.wbcPlaceHolder.isHidden = false
        }
    }
    
    @objc private func exchangeSEL() {
        self.exhangeTF.resignFirstResponder()
        
        if self.exhangeTF.text?.characters.count == 0 {
            self.exchangePlaceHolder.isHidden = false
        }
    }
    
    func cityChoose() {
        self.city.resignFirstResponder()
    }
    
    func getSelected(selectedStr: String) {
        CCog(message: selectedStr)
        self.city.text = selectedStr
    }
    
    // MARK: - BindPhoneFooterVDelegate
    func bindPhonSELDelegate() {
        CCog(message: type(of: self))
        self.navigationController?.pushViewController(ConfirmExchangeVC(), animated: true)
    }

}
