//
//  MyRequestVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  我的申述

import UIKit
import WebKit

class MyRequestVC: WkBaseViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "我的申述"
        
        self.urlString = APPEAL_URL
        
        /// 拼接用户信息
        if self.urlString.contains("?") {
            self.urlString = self.urlString + ("&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
        } else {
            self.urlString = self.urlString + ("?&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
        }
        
        /// 判断是否网络连通
        NetCheck.shared.returnNetStatus { (result) in
            /// 有网络
            if result {
                
                /// 是否包含前缀
                //                if self.urlString.contains(COMMON_PREFIX) {
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
                if self.getURLStr.contains("?") && !self.getURLStr.contains(".html") && !self.getURLStr.contains("token") {
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
        
        let vvv = MyRequestVC()
        vvv.getURLStr = str
        
    
        self.navigationController?.pushViewController(vvv, animated: true)
        
    }
}

