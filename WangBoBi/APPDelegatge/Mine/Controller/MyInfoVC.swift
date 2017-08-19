//
//  MyInfoVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/22.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  我的信息页面

import UIKit

class MyInfoVC: BaseViewController {

    /// 背景视图
    fileprivate lazy var backGroundV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (500 / 640)))
        d.image = #imageLiteral(resourceName: "bgV")
        return d
    }()
    
    lazy var personInfoV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN * SCREEN_SCALE, y: self.backGroundV.bounds.midX / 1.05, width: SCREEN_WIDTH - 2 * COMMON_MARGIN * SCREEN_SCALE , height: (SCREEN_WIDTH - 2 * COMMON_MARGIN * SCREEN_SCALE) * (369 / 598)))
        d.image = #imageLiteral(resourceName: "infoV")
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.isUserInteractionEnabled = true

        return d
    }()
    
    lazy var editV: PersonInfoEditV = {
        let d : PersonInfoEditV = PersonInfoEditV.init(frame: CGRect.init(x: 0, y: self.personInfoV.Height * 0.25, width: self.personInfoV.Width, height: self.personInfoV.Height * 0.7))
        return d
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        toast(toast: "长按钱包地址可复制")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "我的信息"
        
        view.addSubview(backGroundV)
        view.addSubview(personInfoV)
        
        self.personInfoV.addSubview(editV)
        view.backgroundColor = UIColor.white
    }
}


// MARK: - 我的信息编辑视图
class PersonInfoEditV : UIView {
    
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
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.nameLabel.LeftX, y: self.emailAdd.BottomY + COMMON_MARGIN * 1.5 * SCREEN_SCALE, width: 60 * SCREEN_SCALE, height: self.nameLabel.Height))
        d.text = "钱包地址 :"
        
        d.textColor = UIColor.lightGray
        d.font = UIFont.systemFont(ofSize: 11 * SCREEN_SCALE)

        return d
    }()
    
    /// 钱包地址显示
    lazy var moneyAddresShow: LabelWithPaste = {
        let d : LabelWithPaste = LabelWithPaste.init(frame: CGRect.init(x: self.moneyAddress.RightX, y: self.moneyAddress.TopY, width: self.Width * 0.7, height: self.moneyAddress.Height))
        
        d.font = UIFont.systemFont(ofSize: 11 * SCREEN_SCALE)
        d.numberOfLines = 0
        d.lineBreakMode = .byWordWrapping
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
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.nameLabel.LeftX, y: self.nameLabel.BottomY + COMMON_MARGIN * SCREEN_SCALE * 1.5, width: self.nameLabel.Width, height: self.nameLabel.Height))
        d.text = "邮箱 :"
        d.textColor = UIColor.lightGray
        d.font = UIFont.systemFont(ofSize: 11 * SCREEN_SCALE)
        return d
    }()
    
    /// 头像
    lazy var avatarImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: self.Width - 65 * SCREEN_SCALE - COMMON_MARGIN * SCREEN_SCALE, y: self.nameLabel.TopY, width: 65 * SCREEN_SCALE, height: 65 * SCREEN_SCALE))
        
        d.isUserInteractionEnabled = true
        /// 添加上传头像动作
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(uploadHeadImg))
        d.addGestureRecognizer(tapGes)
        
        return d
    }()
    
    /// 显示是否验证
    lazy var cerNameIcon: CertifieNamed = {
        let d : CertifieNamed = CertifieNamed.init(frame: CGRect.init(x: self.nameShowLabel.RightX , y: self.nameShowLabel.TopY, width: 50 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        return d
    }()
    
    /// 上传头像接口
    @objc fileprivate func uploadHeadImg() {
        CCog(message: "")
        
        UploadHeadTool.shared.choosePic { (_, _) in
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nameLabel)
        addSubview(nameShowLabel)
        
        addSubview(emailAdd)
        addSubview(emailShowLabel)
        
        addSubview(moneyAddress)
        addSubview(moneyAddresShow)
        
        addSubview(avatarImg)
        
        addSubview(cerNameIcon)
        
        /// 实名显示
        if AccountModel.shared()?.TrueName?.characters.count == 0 {
            cerNameIcon.showCerNam(str: "未实名")
            cerNameIcon.frame = CGRect.init(x: self.nameLabel.RightX, y: self.nameLabel.TopY, width: 55 * SCREEN_SCALE, height: self.nameLabel.Height)
        } else {
            nameShowLabel.text = AccountModel.shared()?.TrueName
        }
        
        /// 头像
        avatarImg.setImage(urlString: AccountModel.shared()?.HeadImg, placeholderImage: #imageLiteral(resourceName: "logo"))
        
        /// 邮箱
        emailShowLabel.text = AccountModel.shared()?.UserName
        
        /// 钱包地址
        moneyAddresShow.text = AccountModel.shared()?.WBCAdress
        
        
        /// 接收图片选择器传来的数据信息
        NotificationCenter.default.addObserver(self, selector: #selector(view(dd:)), name: NSNotification.Name(rawValue: "imgData"), object: nil)
        
    }
    
    @objc fileprivate func view(dd : Notification) -> Void {
        
        if let imgDataDic = dd.userInfo {
            if let imgData = imgDataDic["ima"] as? Data {
                
                AccountModel.uploadHeadImg(imgData: imgData, finished: { (result) in
                    CCog(message: result)
                    
                    if result {
                        DispatchQueue.main.async {
                            self.avatarImg.image = UIImage.init(data: imgData)
                            
                            AccountModel.reloadSEL()
                        }
                    }
                })
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: - 实名认证
class CertifieNamed: UIView {
    
    var mark = "已实名"
    
    lazy var descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: 20 * SCREEN_SCALE))

        
        d.textAlignment = .center
        d.textColor = UIColor.colorWithHexString("2796DD")
        return d
    }()
    
    func showCerNam(str : String) -> Void {
        
        self.layer.borderColor = UIColor.colorWithHexString("2796DD").cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.descLabel.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        self.descLabel.text = str
        
        self.descLabel.textAlignment = .center

        addSubview(self.descLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
