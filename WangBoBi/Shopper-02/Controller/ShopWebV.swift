//
//  ShopWebV.swift
//  VotingApp
//
//  Created by 郑东喜 on 2017/3/17.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  订单

import UIKit
import WebKit

class ShopWebV: WkBaseViewController {
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 64)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if self.navigationController?.viewControllers.count > 1 {
            
            let bounds = self.navigationController!.navigationBar.bounds
            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 64)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.showDowV.alpha = 0
            })
        } else {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.showDowV.alpha = 1.0
            })
            
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if SHOP_URLArray.count == 0 {
            self.urlString = STOTRURL
        } else {
            self.urlString = SHOP_URLArray.lastObject as! String
        }
        
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
                
                CCog(message: self.urlString)
                
                /// 是否包含前缀
                if self.urlString.contains(COMMON_PREFIX) {
                    let request : URLRequest = NSURLRequest.init(url: URL.init(string: self.urlString)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 0) as URLRequest
                    
                    self.webView.load(request)
                    
                } else {
                    CCog(message: "////")
                    
                    self.webView.stopLoading()
                    self.webView.isHidden = true
                    self.view.bringSubview(toFront: self.lostNetV)
                    self.lostNetV.isHidden = false
                }
                /// 没网络
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
}


extension ShopWebV {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        self.getURLStr = (navigationAction.request.url?.absoluteString)!
        
        CCog(message: self.getURLStr)
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            /// 显示网络加载出错（域名不对图标）
            if self.getURLStr.contains(".html") {
                netWrongV.isHidden = false
                self.webView.isHidden = true
            }
            
            if self.getURLStr.contains(COMMON_PREFIX) {
                if self.getURLStr.contains("?") && !self.getURLStr.contains(".html") && !self.getURLStr.contains("token") {
                    self.getURLStr = self.getURLStr + ("&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                } else {
                    self.getURLStr = self.getURLStr + ("?&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                }
                
                self.aaa(str:self.getURLStr)
                
                SHOP_URLArray.add(self.getURLStr)
            } else {
                lostNetV.isHidden = false
                lostNetV.descLabel.text = "网络加载出错，请检查网络设置"
            }

            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}


extension ShopWebV {
    
    /// 页面跳转
    ///
    /// - Parameter str: 跳转的链接
    fileprivate func aaa(str : String) -> Void {
                
        let vvv = ShopWebReplaceV()
        vvv.getURLStr = str
        
        
        
        self.navigationController?.pushViewController(vvv, animated: true)
        
    }
}
