//
//  NameCerWithDetailVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/25.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  实名验证相信页面

import UIKit

class NameCerWithDetailVC: UIViewController,UITableViewDataSource,UITableViewDelegate,BindPhoneFooterVDelegate,UPloadIDImgDelegate,UIImagePickerControllerDelegate {
    
    fileprivate lazy var tbV: UITableView = {
        let d : UITableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        d.register(BindPhoneCell.self, forCellReuseIdentifier: "sss")
        d.register(UPloadIDImgCell.self, forCellReuseIdentifier: "sss2")
        d.delegate = self;
        d.dataSource = self;
        d.separatorStyle = .none
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
        
//        view.addSubview(footerV)
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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        UploadHeadTool.shared.choosePic { (uploa, ddd) in
//            CCog(message: uploa)
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableView.dequeueReusableCell(withIdentifier: "sss") as! BindPhoneCell
        switch indexPath.section {
        case 0:
            cel.titLabel.text = dataSource["title"]?[indexPath.row]
            cel.sizeToFit()
            cel.inputTF.placeholder = dataSource["content"]?[indexPath.row]
            break
        case 1:
            switch indexPath.row {
            case 0:
                cel.titLabel.text = "上传身份证"

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

                return 150 * SCREEN_SCALE

        default:
            return 45
        }
    }

    
    // MARK: - FooterViewDelegateMethod
    func bindPhonSELDelegate() {
        CCog(message: "")
    }
    // MARK: - upLaodImgDelegate
    func frontChooseImgSEL() {
//        UploadHeadTool.shared.choosePic { (uploa, ddd) in
//            CCog(message: uploa)
//        }
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
    
    fileprivate lazy var leftImg: CommonBtn = {
        let d : CommonBtn = CommonBtn.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN + 45, width: SCREEN_WIDTH / 2 - 2 * COMMON_MARGIN, height: (SCREEN_WIDTH / 2 - 2 * COMMON_MARGIN) * (176 / 280)))

        d.addTarget(self, action: #selector(frontChoose), for: .touchUpInside)

        d.setImage(#imageLiteral(resourceName: "uploadIDFront"), for: .normal)
        return d
    }()
    
    fileprivate lazy var rightImg : UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: self.leftImg.RightX + 2 * COMMON_MARGIN, y: 45 + COMMON_MARGIN, width: SCREEN_WIDTH / 2 - 2 * COMMON_MARGIN, height: (SCREEN_WIDTH / 2 - 2 * COMMON_MARGIN) * (176 / 280)))
        d.image = #imageLiteral(resourceName: "uploadIDBack")
        d.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(backChoose))
        d.addGestureRecognizer(tapGes)
        return d
    }()
    
    
    /// 正面选择事件
    func frontChoose() -> Void {
        CCog(message: "frontChoose")
        UploadHeadTool.shared.choosePic { (uploa, ddd) in
            CCog(message: uploa)
        }

    }
    
    /// 正面选择事件
    func backChoose() -> Void {
        CCog(message: "backChoose")
        self.delegate?.backChooseImgSEL()
    }

    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(leftImg)
        contentView.addSubview(rightImg)
        
//        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
