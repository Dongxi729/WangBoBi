//
//  AddFrienVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/24.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  添加朋友

import UIKit

// 添加朋友类型
var AddType : Int?

class AddFrienVC: BaseViewController,UITextFieldDelegate {

    lazy var replaceLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: self.searTf.frame)
        d.font = UIFont.systemFont(ofSize: 12)
        d.text = "搜索好友账号"
        d.textColor = UIColor.darkGray
        return d
    }()
    
    fileprivate lazy var searTf: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.11755231037232, y: COMMON_MARGIN + 64, width: SCREEN_WIDTH - SCREEN_WIDTH * 0.15, height: SCREEN_HEIGHT * 0.075))

        let toolBar = ToolBar()
        toolBar.seToolBar(confirmTitle: "确定", cancelTitle: "取消", comfirmSEL: #selector(confirmSEL), cancelSEL: #selector(cancelSEL), target: self)

        d.delegate = self
        d.inputAccessoryView = toolBar
        
        return d
    }()
    
    
    
    ///  我的二维码
    fileprivate lazy var leftBtn: UIButton = {
        let d: UIButton = UIButton.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT * 0.125 + 64, width: SCREEN_WIDTH * 0.5, height: SCREEN_WIDTH * 0.3))
        d.addTarget(self, action: #selector(jumpToMyInfo), for: .touchUpInside)
        return d
    }()
    
    /// 扫一扫
    fileprivate lazy var rightBtn: UIButton = {
        let d: UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5, y: SCREEN_HEIGHT * 0.125 + 64, width: SCREEN_WIDTH * 0.5, height: SCREEN_WIDTH * 0.3))
        
        d.addTarget(self, action: #selector(jumpToScan), for: .touchUpInside)

        return d
    }()
    
    /// 背景图
    fileprivate lazy var addFrienBgV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: COMMON_MARGIN + 64, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (289 / 640)))
        d.image = #imageLiteral(resourceName: "addFriendGrougV")
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "添加好友"
        view.addSubview(addFrienBgV)
        view.addSubview(searTf)
        view.addSubview(replaceLabel)
        
        view.addSubview(leftBtn)
        view.addSubview(rightBtn)

        view.backgroundColor = COMMON_TBBGCOLOR
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.replaceLabel.isHidden = true
    }

    
    // MARK: - 事件操作
    /// 取消事件
    @objc fileprivate func cancelSEL() {
        self.searTf.resignFirstResponder()
        
        if searTf.text?.characters.count == 0 {
            self.replaceLabel.isHidden = false
        }
    }
    
    /// 确定事件
    @objc fileprivate func confirmSEL() {
        CCog(message: "")
        /// 缩回请求
        
        if self.searTf.text?.characters.count > 0 && (self.searTf.text?.validateEmail())! {
            self.navigationController?.pushViewController(AddFriendInfoVC(), animated: true)
            
            self.searTf.resignFirstResponder()
            // 键盘缩回操作
            UIView.animate(withDuration: 0.5) {
                UIApplication.shared.keyWindow?.frame = (UIApplication.shared.keyWindow?.rootViewController?.view.bounds)!
            }
            
            AddType = 1
            
            ScanModel.friemdIDStr = self.searTf.text
        } else {
            toast(toast: "请输入正确格式的账号信息")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.searTf.resignFirstResponder()
        // 键盘缩回操作
        UIView.animate(withDuration: 0.5) {
            UIApplication.shared.keyWindow?.frame = (UIApplication.shared.keyWindow?.rootViewController?.view.bounds)!
        }
    }
    
    /// 调往我的二维码
    @objc fileprivate func jumpToMyInfo() {
        self.navigationController?.pushViewController(CodeProductor(), animated: true)
    }

    /// 扫一扫
    @objc fileprivate func jumpToScan() {
        self.navigationController?.pushViewController(ScanCodeController(), animated: true)
    }
}
