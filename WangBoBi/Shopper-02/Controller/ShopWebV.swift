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
        self.urlString = STOTRURL
        
        if self.urlString.contains(COMMON_PREFIX) {
            let request : URLRequest = NSURLRequest.init(url: URL.init(string: self.urlString)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 0) as URLRequest
            
            self.webView.load(request)
        } else {
            CCog(message: "////")
            
            self.webView.stopLoading()
            self.webView.isHidden = true
            view.bringSubview(toFront: lostNetV)
            lostNetV.isHidden = false
            
        }
    }
}


extension ShopWebV {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        self.getURLStr = (navigationAction.request.url?.absoluteString)!
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            if self.getURLStr.contains(COMMON_PREFIX) {
                if self.getURLStr.contains("?") {
                    self.getURLStr = self.getURLStr + ("&token=")
                } else {
                    self.getURLStr = self.getURLStr + ("?&token=")
                }
                
                self.aaa(str:self.getURLStr)
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
