//
//  DetailVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/8/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  账单

import UIKit
import WebKit

class DetailVC: WkBaseViewController,DatePickerVDelegate,DetailSelectVDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        title = "账单"
        
        self.navigationItem.rightBarButtonItems = [typeItem1,typeItem2]
        
        let navBar = navigationController?.navigationBar
        /// 修改导航栏文字样式（富文本）
        navBar?.titleTextAttributes = [
            
            NSForegroundColorAttributeName : UIColor.black,
            NSFontAttributeName : UIFont.systemFont(ofSize: 16 * SCREEN_SCALE)
        ]
        
    }
    
    /// 类型
    private lazy var typeItem1: UIBarButtonItem = {
        let d : UIBarButtonItem = UIBarButtonItem.init(title: "类型", style: .plain, target: self, action: #selector(typeSel))
        d.tintColor = UIColor.black
        return d
    }()
    
    private lazy var typeItem2: UIBarButtonItem = {
        let d: UIBarButtonItem = UIBarButtonItem.init(title: "时间", style: .plain, target: self, action: #selector(timeSel))
        d.tintColor = UIColor.black
        return d
    }()
    
    
    private lazy var detailSelectV: DetailSelectV = {
        let d: DetailSelectV = DetailSelectV.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH * 0.85, height: SCREEN_WIDTH * 0.85 * (320 / 450)))
        d.detailSelectDelegate = self
        return d
    }()
    
    @objc private func typeSel() {
        UIApplication.shared.keyWindow?.addSubview(maskV)
        zdx_setupButtonSpringAnimation(maskV)
        
        UIApplication.shared.keyWindow?.addSubview(detailSelectV)
        zdx_setupButtonSpringAnimation(detailSelectV)
        detailSelectV.center = (UIApplication.shared.keyWindow?.center)!
    }
    
    @objc private func timeSel() {
        
        let dateV = DatePickerV.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - 125, y: SCREEN_HEIGHT * 0.5 - 150, width: 250, height: 300))
        dateV.center = (UIApplication.shared.keyWindow?.center)!
        zdx_setupButtonSpringAnimation(dateV)
        dateV.datePickerDelegate = self
        UIApplication.shared.keyWindow?.addSubview(maskV)
        UIApplication.shared.keyWindow?.addSubview(dateV)
        
        self.datePickerV = dateV
    }
    
    //日期选择器响应方法
    func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月"
        print(formatter.string(from: datePicker.date))
    
    
    }
    
    lazy var maskV: UIView = {
        let d: UIView = UIView.init(frame: (UIApplication.shared.keyWindow?.bounds)!)
        d.backgroundColor = UIColor.gray
        d.alpha = 0.35
        return d
    }()
    
    var datePickerV : DatePickerV!
    
    // MARK: - DatePickerVDelegate
    func chooseMonthAndYear(_ year: String, _ month: String) {
        CCog(message: year)
        CCog(message: month)
        self.maskV.removeFromSuperview()
        self.datePickerV.removeFromSuperview()
        
        /// 或者刷新网页
        /// 拼接用户信息
        if DETAIL_URL.contains("?") {
            self.urlString = DETAIL_URL + ("&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)! + "&ty=0" + "&date=" + year + "-" + month
        } else {
            self.urlString = DETAIL_URL + ("?&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                + "&ty=0" + "&date=" + year + "-" + month
        }
        self.webView.load(URLRequest.init(url: URL.init(string: self.urlString)!))
    }
    
    func datePickerCancel() {
        self.maskV.removeFromSuperview()
        self.datePickerV.removeFromSuperview()
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.urlString = DETAIL_URL
        
        /// 拼接用户信息
        if self.urlString.contains("?") {
            self.urlString = self.urlString + ("&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)! + "&ty=0"
        } else {
            self.urlString = self.urlString + ("?&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
             + "&ty=0"
        }
        
        /// 判断是否网络连通
        NetCheck.shared.returnNetStatus { (result) in
            /// 有网络
            if result {
                
                /// 是否包含前缀
                let request : URLRequest = NSURLRequest.init(url: URL.init(string: self.urlString)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 0) as URLRequest
                
                self.webView.load(request)
                
            } else {
                
                CCog(message: self.urlString)
                /// 是否包含前缀
                if self.urlString.contains(COMMON_PREFIX) {
                    let request : URLRequest = NSURLRequest.init(url: URL.init(string: self.urlString)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 0) as URLRequest
                    
                    self.webView.load(request)
                    
                } else {
                    
                    self.webView.stopLoading()
                    self.webView.isHidden = true
                    self.view.bringSubview(toFront: self.lostNetV)
                    self.lostNetV.isHidden = false
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        self.getURLStr = (navigationAction.request.url?.absoluteString)!
        
        CCog(message: self.getURLStr)
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            /// 显示网络加载出错（域名不对图标）
            if self.getURLStr.contains(".html") {
                netWrongV.isHidden = false
                
                let vc = NetWrongVC()
                
                self.navigationController?.pushViewController(vc, animated: true)
                
                decisionHandler(.cancel)
                return
            }
            
            if self.getURLStr.contains(COMMON_PREFIX) {
                if self.getURLStr.contains("?") && !self.getURLStr.contains(".html") && !self.getURLStr.contains("token") && !self.getURLStr.contains("date=") {
                    self.getURLStr = self.getURLStr + ("&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                } else {
                    self.getURLStr = self.getURLStr + ("?&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                }
                
                self.aaa(str:self.getURLStr)
                
                if !self.getURLStr.contains("html") {
                    SHOP_URLArray.add(self.getURLStr)
                }
                
                
            } else {
                lostNetV.isHidden = false
                lostNetV.descLabel.text = "网络加载出错，请检查网络设置"
            }
            
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    /// 页面跳转
    ///
    /// - Parameter str: 跳转的链接
    fileprivate func aaa(str : String) -> Void {
        
        let vvv = DetailVC()
        vvv.getURLStr = str
        
        
        self.navigationController?.pushViewController(vvv, animated: true)
        
    }
    
    /// 加载账单类型
    private var loadDetailType : Int = 0
    
    // MARK: - DetailSelectVDelegate
    func detailSelectSel(indexPath: IndexPath) {
        self.loadDetailType = indexPath.row
    }

    func detailDelegateCancel() {
        self.maskV.removeFromSuperview()
        self.detailSelectV.removeFromSuperview()
    }
    
    func detailDelegateConfirm() {
        self.maskV.removeFromSuperview()
        self.detailSelectV.removeFromSuperview()
        
        if DETAIL_URL.contains("?") {
            self.urlString = DETAIL_URL + ("&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)! + "&ty=\(loadDetailType)"
        } else {
            self.urlString = DETAIL_URL + ("?&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                + "&ty=\(loadDetailType)"
        }
        self.webView.load(URLRequest.init(url: URL.init(string: self.urlString)!))
    }
}
