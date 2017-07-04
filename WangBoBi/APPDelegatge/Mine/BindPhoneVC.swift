//
//  BindPhoneVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  绑定手机

import UIKit

class BindPhoneVC: UIViewController,UITableViewDelegate,UITableViewDataSource,BindPhoneCellDelegate,BindPhoneFooterVDelegate {
    
    lazy var tableView: UITableView = {
        let d: UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.delegate = self;
        d.dataSource = self;
        d.register(BindPhoneCell.self, forCellReuseIdentifier: "cellID")
//        d.separatorStyle = .none
        return d
    }()
    
    
    /// 尾部视图
    lazy var footerView: BindPhoneFooterV = {
        let d : BindPhoneFooterV = BindPhoneFooterV.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - 64 - 64, width: SCREEN_WIDTH, height: 64))
        d.delegate = self
        return d
    }()
    
    var dataSource : [String:[String]] = ["title" : ["手机号","手机验证码"],
                                          "content" : ["请输入手机号","请输入验证码"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "绑定手机"
        
        view.backgroundColor = COMMON_TBBGCOLOR
        
        view.addSubview(tableView)
        
        view.addSubview(footerView)
        footerView.setFooterTitle(str: "绑定手机")
    }
    
    // MARK: - 表格数据源、代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! BindPhoneCell
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = .zero
        
        cell.textLabel?.text = dataSource["title"]?[indexPath.row]
        cell.titLabel.sizeToFit()
        cell.inputTF.placeholder = dataSource["content"]?[indexPath.row]
        cell.indexPath = indexPath as NSIndexPath
        cell.delegate = self
        
        let deveceTyp = UIDevice.current.deviceType
        
        switch indexPath.row {
        case 0:
            cell.sendSMS.isHidden = false
            
            
            if deveceTyp == .iPhone4S {
                cell.inputTF.frame = CGRect.init(x: cell.Width * 0.3, y: cell.bounds.midY - 10 * SCREEN_SCALE, width: cell.Width * 0.4, height: 20 * SCREEN_SCALE)
            } else {
                cell.inputTF.frame = CGRect.init(x: cell.Width * 0.35, y: cell.bounds.midY - 10 * SCREEN_SCALE, width: cell.Width * 0.5, height: 20 * SCREEN_SCALE)
            }
            
            break
        case 1:
            cell.sendSMS.isHidden = true
            
            if deveceTyp == .iPhone4S {
            
                cell.inputTF.frame = CGRect.init(x: cell.Width * 0.3, y: cell.bounds.midY - 10 * SCREEN_SCALE, width: cell.Width * 0.5, height: 20 * SCREEN_SCALE)
            } else {
                cell.inputTF.frame = CGRect.init(x: cell.Width * 0.35, y: cell.bounds.midY - 10 * SCREEN_SCALE, width: cell.Width * 0.8, height: 20 * SCREEN_SCALE)
            }
            
            
            break
        default:
            break
        }
        
        return cell
    }
    
    /// 手机号
    var numText : String?
    
    /// 手机验证码
    var phoneCode : String?
    
    // MARK: - cell代理方法
    func text(indexPath: NSIndexPath, text: String) {
        switch indexPath.row {
        case 0:
            self.numText = text
            break
        case 1:
            self.phoneCode = text
            break
        default:
            break
        }
    
    }
    
    // MARK: - 尾部代理方法
    func bindPhonSELDelegate() {

        if numText?.characters.count > 0 {
            
            if phoneCode?.characters.count > 0 {
                
                if (phoneCode?.checkAuthStr(password: phoneCode! as NSString))! {
                    
                    AccountModel.bindPhoneSEL(auth: phoneCode!, phoneNum: numText!, finished: { (result) in
                        
                        CCog(message: result)
                        if result {
                            self.navigationController?.popViewController(animated: true)
                        }
                    })
                } else {
                    toast(toast: "验证码格式不对")
                }
            } else {
                toast(toast: "验证码不为空")
            }
        } else {
            toast(toast: "手机号不为空")
        }
    }
}


// MARK: - Cell
protocol BindPhoneCellDelegate {
    func text(indexPath : NSIndexPath,text : String) -> Void
}

class BindPhoneCell: UITableViewCell,UITextFieldDelegate {
    
    var delegate : BindPhoneCellDelegate?
    
    var indexPath : NSIndexPath?
    
    lazy var titLabel: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.bounds.midY - 7 * SCREEN_SCALE , width: 100, height: 0))
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        d.textColor = UIColor.lightGray
        d.isEnabled = false
        return d
    }()
    
    
    lazy var inputTF: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: self.titLabel.RightX + COMMON_MARGIN, y: self.bounds.midY - 10 * SCREEN_SCALE, width: self.Width * 0.7, height: 20 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
//        d.clearsOnBeginEditing = true
        d.delegate = self
        return d
    }()
    
    lazy var sendSMS: CountDownBtn = {
        let d : CountDownBtn = CountDownBtn.init(frame: CGRect.init(x: SCREEN_WIDTH - 80 * SCREEN_SCALE - COMMON_MARGIN, y: self.bounds.midY - 15 * SCREEN_SCALE, width: 80 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.setTitle("点击获取验证码", for: .normal)
        d.backgroundColor = UIColor.colorWithHexString("E6E6E6")
        d.layer.borderColor = UIColor.lightGray.cgColor
        d.titleLabel?.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        d.addTarget(self, action: #selector(autoSEL(sender:)), for: .touchUpInside)
        d.setTitleColor(UIColor.black, for: .normal)
        d.layer.borderWidth = 1
        return d
    }()
    
    //验证码事件
    func autoSEL(sender : CountDownBtn) -> Void {
        if !(inputTF.text?.isEmpty)! {
            if (inputTF.text?.checkMobile(mobileNumbel: (inputTF.text as NSString?)!))! {
                
                /// 发生验证码
                AccountModel.bindPhoneAuthSEL(phoneNum: inputTF.text!)
                
                sender.initwith(color: .gray, title: "点击重发", superView: self)
            } else {
                toast(toast: "手机格式不对")
            }
        } else {
            toast(toast: "手机号码不为空")
        }
    }
    
    
    lazy var line: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: self.Height, width: SCREEN_WIDTH, height: 0.5))
        d.backgroundColor = UIColor.gray
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titLabel)
        contentView.addSubview(inputTF)
        contentView.addSubview(sendSMS)
        
//        contentView.addSubview(line)
        
        
        sendSMS.isHidden = true
//        self.selectionStyle = .none
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.text(indexPath: indexPath!, text: textField.text!)
    }
}



protocol BindPhoneFooterVDelegate {
    func bindPhonSELDelegate() -> Void
}

class BindPhoneFooterV : UIView {
    
    var delegate : BindPhoneFooterVDelegate?
    
    lazy var line: UIView = {
        let d: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 1))
        d.backgroundColor = UIColor.gray
        return d
    }()
    
    
    func setFooterTitle(str : String) -> Void {
        self.bindPhoneBtn.setTitle(str, for: .normal)
        
        addSubview(bindPhoneBtn)
        self.bindPhoneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        self.backgroundColor = UIColor.white
        
    }
    
    lazy var bindPhoneBtn: CommonBtn = {
        let d : CommonBtn = CommonBtn.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN * 0.7, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: self.Height - 2 * COMMON_MARGIN * 0.7))
        d.backgroundColor = UIColor.colorWithHexString("2796DD")
        
//        d.setTitle("绑定手机", for: .normal)
        d.addTarget(self, action: #selector(bindPhoneSEL(sender:)), for: .touchUpInside)
        d.titleLabel?.textAlignment = .center
        d.layer.cornerRadius = 5.0
        d.titleLabel?.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    
    func bindPhoneSEL(sender : CommonBtn) -> Void {
        self.delegate?.bindPhonSELDelegate()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bindPhoneBtn)
        
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
