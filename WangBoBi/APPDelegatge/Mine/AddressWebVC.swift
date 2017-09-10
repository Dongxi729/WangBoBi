//
//  AddressWebVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/8/14.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  我的地址

import UIKit

import WebKit

 

class AddressWebVC: WkBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "地址管理"
        
        
        if (self.navigationController?.viewControllers.count)! == 2 {
            
            self.getURLStr = ADDRESS_URL
            /// 拼接用户信息
            if self.getURLStr.contains("?") {
                self.getURLStr = self.getURLStr + ("&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
            } else {
                self.getURLStr = self.getURLStr + ("?&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
            }
        }
        
        
        /// 拼接用户信息
        if self.getURLStr.contains("?") {
            self.getURLStr = self.getURLStr + ("&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
        } else {
            self.getURLStr = self.getURLStr + ("?&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
        }
        
        /// 判断是否网络连通
        NetCheck.shared.returnNetStatus { (result) in
            /// 有网络
            if result {
                
                let request : URLRequest = NSURLRequest.init(url: URL.init(string: self.getURLStr)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 0) as URLRequest
                
                self.webView.load(request)
                
            } else {
                
                if self.urlString.contains(COMMON_PREFIX) {
                    let request : URLRequest = NSURLRequest.init(url: URL.init(string: self.getURLStr)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 0) as URLRequest
                    
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
        urlStr.add(self.getURLStr)
        
        CCog(message: self.getURLStr)
        
        ///  保存信息成功url
        if self.getURLStr == "http://wbpay.ie1e.com/deliver.aspx" {
            if let allVC = self.navigationController?.viewControllers {
                
                if let inventoryListVC = allVC[allVC.count - 2] as? AddressWebVC {
                    
                    inventoryListVC.webView.reload()
                    self.navigationController!.popToViewController(inventoryListVC, animated: true)
                    
                    decisionHandler(.cancel)
                    return
                }
            }
            
            
            
        }
        
        
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            
            if self.getURLStr.contains(COMMON_PREFIX) {
                if self.getURLStr.contains("?") && !self.getURLStr.contains(".html") && !self.getURLStr.contains("token"){
                    self.getURLStr = self.getURLStr + ("&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                } else {
                    self.getURLStr = self.getURLStr + ("?&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                }
                
                urlStr.add(self.getURLStr)
                
                self.aaa(str:self.getURLStr)
                
                
            } else {
                lostNetV.isHidden = false
                lostNetV.descLabel.text = "网络加载出错，请检查网络设置"
            }
            
            decisionHandler(.cancel)
            
            
            
        } else {
            if self.getURLStr.contains("deliver.aspx") && !self.getURLStr.contains("token") {
                if self.getURLStr.contains("?") && !self.getURLStr.contains(".html") && !self.getURLStr.contains("token"){
                    self.getURLStr = self.getURLStr + ("&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                } else {
                    self.getURLStr = self.getURLStr + ("?&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                }
                urlStr.add(self.getURLStr)
                
                self.aaa(str:self.getURLStr)
                decisionHandler(.cancel)
                
            }
            
            decisionHandler(.allow)
        }
    }
    /// 页面跳转
    ///
    /// - Parameter str: 跳转的链接
    fileprivate func aaa(str : String) -> Void {
        
        let vvv = AddressWebVC()
        vvv.getURLStr = str
        
        
        self.navigationController?.pushViewController(vvv, animated: true)
        
    }
}

