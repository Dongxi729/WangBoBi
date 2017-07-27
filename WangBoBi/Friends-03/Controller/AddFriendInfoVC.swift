//
//  AddFriendInfoVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/24.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  填加好友信息详情

import UIKit

class AddFriendInfoVC: BaseViewController,AddPersonInfoEditVDelegate {
    
    /// 背景视图
    fileprivate lazy var backGroundV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (500 / 640)))
        d.image = #imageLiteral(resourceName: "friendBg")
        return d
    }()
    
    fileprivate lazy var personInfoV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN * SCREEN_SCALE, y: self.backGroundV.bounds.midX / 1.05, width: SCREEN_WIDTH - 2 * COMMON_MARGIN * SCREEN_SCALE , height: (SCREEN_WIDTH - 2 * COMMON_MARGIN * SCREEN_SCALE) * (504 / 598)))
        d.image = #imageLiteral(resourceName: "friendInfoBgv")
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.isUserInteractionEnabled = true
        return d
    }()
    
    /// 添加朋友信息视图
    fileprivate lazy var editV: AddPersonInfoEditV = {
        let d : AddPersonInfoEditV = AddPersonInfoEditV.init(frame: CGRect.init(x: 0, y: self.personInfoV.Height * 0.2, width: self.personInfoV.Width, height: self.personInfoV.Height * 0.7))
        d.delegate = self
        return d
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "信息详情"
        view.addSubview(backGroundV)
        view.addSubview(personInfoV)
        
        personInfoV.addSubview(editV)
        
        view.backgroundColor = COMMON_TBBGCOLOR
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: - AddPersonInfoEditVDelegate

    func pushMoney() {
        self.navigationController?.pushViewController(ReceiveMonVC(), animated: true)
    }
    
    func jumpToAddFriendMark() {
        self.navigationController?.pushViewController(AddFriendMarkVC(), animated: true)
    }
}

protocol AddPersonInfoEditVDelegate {
    /// 转账
    func pushMoney()
    
    /// 加好友
    func jumpToAddFriendMark()
}

// MARK: - 我的信息编辑视图
class AddPersonInfoEditV : UIView {
    
    var delegate : AddPersonInfoEditVDelegate?
    
    /// 名字
    lazy var nameLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN * SCREEN_SCALE, y: COMMON_MARGIN * SCREEN_SCALE, width: 40 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        d.text = "姓名 :"
        d.textColor = UIColor.lightGray
        d.font = UIFont.systemFont(ofSize: 11 * SCREEN_SCALE)
        return d
    }()
    
    /// 名字显示
    lazy var nameShowLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.nameLabel.RightX, y: self.nameLabel.TopY, width: 100 * SCREEN_SCALE, height: self.nameLabel.Height))
        
        
        d.font = UIFont.systemFont(ofSize: 11 * SCREEN_SCALE)
        return d
    }()
    
    /// 钱包地址
    lazy var moneyAddress: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.nameLabel.LeftX, y: self.emailAdd.BottomY + COMMON_MARGIN * 1 * SCREEN_SCALE, width: 60 * SCREEN_SCALE, height: self.nameLabel.Height))
        d.text = "钱包地址 :"
        
        d.textColor = UIColor.lightGray
        d.font = UIFont.systemFont(ofSize: 11 * SCREEN_SCALE)
        
        return d
    }()
    
    /// 钱包地址显示
    lazy var moneyAddresShow: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.moneyAddress.RightX, y: self.moneyAddress.TopY, width: self.Width * 0.7, height: self.moneyAddress.Height))
        
        d.font = UIFont.systemFont(ofSize: 11 * SCREEN_SCALE)
        d.numberOfLines = 0
        d.lineBreakMode = .byWordWrapping
        return d
    }()
    
    /// 转账按钮
    lazy var pushMoneyBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: COMMON_MARGIN * SCREEN_SCALE , y:self.moneyAddress.BottomY + COMMON_MARGIN * SCREEN_SCALE , width: self.Width - 2.5 * COMMON_MARGIN, height: 35 * SCREEN_SCALE))
        d.layer.cornerRadius = 15 * SCREEN_SCALE
        d.backgroundColor = UIColor.colorWithHexString("2796DD")
        d.setTitle("转账", for: .normal)
        d.addTarget(self, action: #selector(pushmoneyBtnSEL), for: .touchUpInside)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    /// 加好友按钮
    lazy var addFrienBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: COMMON_MARGIN * SCREEN_SCALE , y:self.pushMoneyBtn.BottomY + COMMON_MARGIN * SCREEN_SCALE * 0.5 , width: self.Width - 2.5 * COMMON_MARGIN, height: 35 * SCREEN_SCALE))
        d.layer.cornerRadius = 15 * SCREEN_SCALE
        d.backgroundColor = UIColor.colorWithHexString("083857")
        d.setTitle("加为好友", for: .normal)
        d.addTarget(self, action: #selector(addFriendSEL), for: .touchUpInside)
        d.titleLabel?.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    /// 邮件显示
    lazy var emailShowLabel: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: self.emailAdd.RightX, y: self.emailAdd.TopY, width: self.Width * 0.7, height: self.emailAdd.Height))
        
        d.font = UIFont.systemFont(ofSize: 11 * SCREEN_SCALE)
        return d
    }()
    
    /// 邮箱
    lazy var emailAdd: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.nameLabel.LeftX, y: self.nameLabel.BottomY + COMMON_MARGIN * SCREEN_SCALE * 1, width: self.nameLabel.Width, height: self.nameLabel.Height))
        d.text = "邮箱 :"
        d.textColor = UIColor.lightGray
        d.font = UIFont.systemFont(ofSize: 11 * SCREEN_SCALE)
        return d
    }()
    
    /// 头像
    lazy var avatarImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: self.Width - 65 * SCREEN_SCALE - COMMON_MARGIN * SCREEN_SCALE, y: self.nameLabel.TopY, width: 65 * SCREEN_SCALE, height: 65 * SCREEN_SCALE))

        return d
    }()
    
    /// 陌生人logo
    lazy var strangerImg: CertifieNamed = {
        let d : CertifieNamed = CertifieNamed.init(frame: CGRect.init(x: self.avatarImg.LeftX - 25 * SCREEN_SCALE , y: self.avatarImg.BottomY - 20 * SCREEN_SCALE, width: 50 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        return d
    }()
    
    /// 显示是否验证
    lazy var cerNameIcon: CertifieNamed = {
        let d : CertifieNamed = CertifieNamed.init(frame: CGRect.init(x: self.nameShowLabel.RightX , y: self.nameShowLabel.TopY, width: 50 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        CCog(message: type(of: self))
        
        
        DispatchQueue.main.async {
            self.addSubview(self.nameLabel)
            self.addSubview(self.nameShowLabel)
            
            self.addSubview(self.emailAdd)
            self.addSubview(self.emailShowLabel)
            
            self.addSubview(self.moneyAddress)
            self.addSubview(self.moneyAddresShow)
            
            self.addSubview(self.avatarImg)
            
            self.addSubview(self.cerNameIcon)
            
            /// 转账按钮
            self.addSubview(self.pushMoneyBtn)
            
            /// 加好友
            self.addSubview(self.addFrienBtn)
            
            /// 陌生人
            self.addSubview(self.strangerImg)
        }
        
        /// 扫描添加好友
        if AddType == 0 {
            
            /// 扫描添加
            AccountModel.addFriendRequest(AddType!, "", "", ScanModel.shared.codeStr!, "") { (result, model) in
                if result {
                    self.emailShowLabel.text = model[0].Email
                    self.moneyAddresShow.text = model[0].WBCAdress
                    
                    /// 存入单利
                    ScanModel.friendEamil = String(describing: model[0].Id?.intValue)
                    
                    self.avatarImg.setImage(urlString: model[0].HeadImg, placeholderImage: #imageLiteral(resourceName: "arrow"))
                    
                    /// 是否陌生人
                    if model[0].TrueName?.characters.count == 0 {
                        self.strangerImg.showCerNam(str: "陌生人")
                        self.strangerImg.backgroundColor = UIColor.white
                        self.strangerImg.descLabel.textColor = UIColor.black
                    }
                    
                    /// 是否好友
                    if model[0].IsFriend?.intValue == 0 {
                        self.cerNameIcon.showCerNam(str: "未实名")
                    }
                }
            }
        }

        
        /// 搜索添加好友
        if AddType == 1 {
           CCog(message: ScanModel.friemdIDStr as Any)
            AccountModel.addFriendRequest(AddType!, ScanModel.friemdIDStr!, "", "", "") { (result, model) in
                if result {
                    self.emailShowLabel.text = model[0].Email
                    self.moneyAddresShow.text = model[0].WBCAdress
                    self.avatarImg.setImage(urlString: model[0].HeadImg, placeholderImage: #imageLiteral(resourceName: "arrow"))
                    
                    /// 是否陌生人
                    if model[0].TrueName?.characters.count == 0 {
                        self.strangerImg.showCerNam(str: "陌生人")
                        self.strangerImg.backgroundColor = UIColor.white
                        self.strangerImg.descLabel.textColor = UIColor.black
                    }
                    
                    /// 是否好友
                    if model[0].IsFriend?.intValue == 0 {
                        self.cerNameIcon.showCerNam(str: "未实名")
                    }
                }
            }
        }
    
    }
    
    
    // MARK: - 按钮操作事件
    /// 转账跳转
    @objc fileprivate func pushmoneyBtnSEL() {
        self.delegate?.pushMoney()
    }
    
    /// 加为好友
    @objc fileprivate func addFriendSEL() {
        self.delegate?.jumpToAddFriendMark()
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
