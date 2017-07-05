//
//  NameCerWithDetailVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/25.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  实名验证相信页面

import UIKit

class NameCerWithDetailVC: UIViewController,UITableViewDataSource,UITableViewDelegate,BindPhoneFooterVDelegate,UPloadIDImgDelegate,UIImagePickerControllerDelegate,BindPhoneCellDelegate {
    
    fileprivate lazy var tbV: UITableView = {
        let d : UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.register(BindPhoneCell.self, forCellReuseIdentifier: "sss")
        d.register(UPloadIDImgCell.self, forCellReuseIdentifier: "sss2")
        d.register(UITableViewCell.self, forCellReuseIdentifier: "ccc")
        
        d.delegate = self;
        d.dataSource = self;
//        d.separatorStyle = .none
        return d
    }()
    
    fileprivate var dataSource : [String : [String]] = ["title" : ["姓名","身份证号"],
                                                        "content" : ["请输入姓名","请输入身份证号"]]
    
    fileprivate lazy var footerV: BindPhoneFooterV = {
        let d : BindPhoneFooterV = BindPhoneFooterV.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - 64 * 2, width: SCREEN_WIDTH, height: 64))
        d.delegate = self;
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(tbV)
        
        title = "实名认证"
        
        view.addSubview(footerV)
        footerV.setFooterTitle(str: "提交信息")
    }
    
   
    
    // MARK: - 表格代理属性和方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
            
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 2
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 0.00001
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableView.dequeueReusableCell(withIdentifier: "sss") as! BindPhoneCell
        
        cel.separatorInset = UIEdgeInsets.zero
        cel.layoutMargins = UIEdgeInsets.zero
        cel.preservesSuperviewLayoutMargins = false
        cel.delegate = self
        switch indexPath.section {
        case 0:

            cel.textLabel?.text = dataSource["title"]?[indexPath.row]
            cel.inputTF.placeholder = dataSource["content"]?[indexPath.row]
            cel.inputTF.frame = CGRect.init(x: cel.Width * 0.3, y: cel.inputTF.TopY, width: cel.Width * 0.6, height: cel.inputTF.Height)
            cel.inputTF.layer.borderWidth = 1
            cel.indexPath = indexPath as NSIndexPath
            cel.delegate = self
            
            switch indexPath.row {
            case 0:
                cel.inputTF.keyboardType = .default
                break
            case 1:
                cel.inputTF.keyboardType = .numbersAndPunctuation
                break
            default:
                break
            }
            
            break
        case 1:
            switch indexPath.row {
            case 0:
                
                cel.textLabel?.text = "上传身份证"
                
                cel.sizeToFit()
                cel.inputTF.isEnabled = false
            default:
                break
            }
            
        case 2:
            let cekkk = tableView.dequeueReusableCell(withIdentifier: "sss2") as! UPloadIDImgCell
            cekkk.delegate = self;
            return cekkk
        default:
            break
        }
        
        return cel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            
        case 2:
            
            return 112 * SCREEN_SCALE
            
        default:
            return 45
        }
    }
    
    
    // MARK: - FooterViewDelegateMethod
    func bindPhonSELDelegate() {
        /// 名字检查
        if nameLabel?.characters.count > 0 {
            
            if (nameLabel?.checkUserName(userName: nameLabel! as NSString))! {
                /// 身份证检查
                if cardID?.characters.count > 0 {
                    
                    if (cardID?.checkUserIdCard(idCard: cardID!))! {
                        
                        /// 身份证前面路径
                        if CardModel.shared.frontUrl != nil {
                            
                            /// 身份证反面路径
                            if CardModel.shared.backURL != nil {
                                AccountModel.trueNameCertify(frontImg: CardModel.shared.frontUrl!, backImgURL: CardModel.shared.backURL!, idCode: cardID!, nameStr: nameLabel!, finished: { (result) in
                                    if result {
                                        
                                        ////        //返回首页
                                        let allVC = self.navigationController?.viewControllers

                                        let inventoryListVC = allVC![1]
                                        
                                        if (inventoryListVC.isKind(of: AccountAndSaveVC.self)) {
                                            self.navigationController!.popToViewController(inventoryListVC, animated: true)
                                        }
                                    }
                                })
                            } else {
                                toast(toast: "请上传身份证反面照片")
                            }
                            
                        } else {
                            toast(toast: "请上传身份证正面照片")
                        }
                    } else {
                        toast(toast: "身份证格式不对")
                    }
                } else {
                    toast(toast: "身份证不为空")
                }
            } else {
                toast(toast: "姓名不合法")
            }
            
            
        } else {
            toast(toast: "姓名不为空")
        }
    }
    
    // MARK: - upLaodImgDelegate
    func frontChooseImgSEL() {
        //        UploadHeadTool.shared.choosePic { (uploa, ddd) in
        //            CCog(message: uploa)
        //        }
    }
    
    /// 名字
    fileprivate var nameLabel : String?
    
    
    /// 身份证
    fileprivate var cardID : String?
    
    /// 正面身份证路径
    fileprivate var frontIDCardURL : String?
    
    /// 背面身份证路径
    fileprivate var backIDCardURL : String?
    
    // MARK: - BindPhoneCellDelegate
    func text(indexPath: NSIndexPath, text: String) {
        switch indexPath.row {
        case 0:
            nameLabel = text
            break
        case 1:
            cardID = text
            break
        default:
            break
        }
    }

    
    func backChooseImgSEL() {
        
    }
    
}

// MARK: - Cell
protocol UPloadIDImgDelegate {
    func frontChooseImgSEL() -> Void
    func backChooseImgSEL() -> Void
}
class UPloadIDImgCell: UITableViewCell {
    
    
    
    var delegate : UPloadIDImgDelegate?
    
    fileprivate lazy var leftImg: NameCerBtn = {
        let d : NameCerBtn = NameCerBtn.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN , width: SCREEN_WIDTH / 2 - 2 * COMMON_MARGIN, height: (SCREEN_WIDTH / 2 - 2 * COMMON_MARGIN) * (176 / 280)))
        
        d.addTarget(self, action: #selector(frontChoose), for: .touchUpInside)
        
        d.setImage(#imageLiteral(resourceName: "uploadIDFront"), for: .normal)
        return d
    }()
    
    fileprivate lazy var rightImg : NameCerBtn = {
        let d : NameCerBtn = NameCerBtn.init(frame: CGRect.init(x: self.leftImg.RightX + 2 * COMMON_MARGIN, y: COMMON_MARGIN, width: SCREEN_WIDTH / 2 - 2 * COMMON_MARGIN, height: (SCREEN_WIDTH / 2 - 2 * COMMON_MARGIN) * (176 / 280)))
        
        d.addTarget(self, action: #selector(backChoose), for: .touchUpInside)
        
        d.setImage(#imageLiteral(resourceName: "uploadIDBack"), for: .normal)
        return d
    }()
    
    
    /// 正在选择图片
    fileprivate var leftSelectedImg = false
    
    fileprivate var rightSelectedImg = false
    
    /// 正面选择事件
    func frontChoose() -> Void {
        CCog(message: "frontChoose")
        
        UploadHeadTool.shared.choosePic { (uploa, ddd) in
            CCog(message: uploa)
            DispatchQueue.main.async {
                
            }
        }
        leftSelectedImg = true
    }
    
    /// 正面选择事件
    func backChoose() -> Void {
        UploadHeadTool.shared.choosePic { (uploa, ddd) in
            //            CCog(message: uploa)
            self.leftImg.setImage(UIImage.init(data: uploa), for: .normal)
        }
        rightSelectedImg = true
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(leftImg)
        contentView.addSubview(rightImg)

        /// 接收图片选择器传来的数据信息
        NotificationCenter.default.addObserver(self, selector: #selector(view(dd:)), name: NSNotification.Name(rawValue: "imgData"), object: nil)

    }
    
    func view(dd : Notification) -> Void {

        if let imgDataDic = dd.userInfo {
            if let imgData = imgDataDic["ima"] as? Data {
                
                CCog(message: imgData)
                
                DispatchQueue.main.async {
                    
                    /// 左边身份证
                    if self.leftSelectedImg {
                        
                        AccountModel.uploadImgFromLocalLibrary(imgData: imgData, finished: { (result, uploadResutl) in
                            if uploadResutl {
                                
                                /// 赋值
                                CardModel.shared.frontUrl = result
                                
                                self.leftImg.setImage(UIImage.init(data: imgData), for: .normal)
                                self.leftSelectedImg = false
                            }
                        })
                    }
                    
                    /// 右边身份证
                    if self.rightSelectedImg {
                        AccountModel.uploadImgFromLocalLibrary(imgData: imgData, finished: { (result, iploadResult) in
                            
                            if iploadResult {
                                CardModel.shared.backURL = result
                                self.rightImg.setImage(UIImage.init(data: imgData), for: .normal)
                                self.rightSelectedImg = false
                            }
                        })
                    }
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class NameCerBtn: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/// 身份证模型
class CardModel: NSObject {
    var frontUrl : String?
    var backURL :String?
    static let shared = CardModel()
}
