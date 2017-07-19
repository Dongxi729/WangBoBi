//
//  ShopWebReplaceV.swift
//  VotingApp
//
//  Created by 郑东喜 on 2017/3/27.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import WebKit

class ShopWebReplaceV: WkBaseViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let request : URLRequest = NSURLRequest.init(url: URL.init(string: self.getURLStr)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 0) as URLRequest
        self.webView.load(request)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        title = "订单详情"
    }
}


extension ShopWebReplaceV {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        self.getURLStr = (navigationAction.request.url?.absoluteString)!
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            if self.getURLStr.contains(COMMON_PREFIX) {
                if self.getURLStr.contains("?") {
                    self.getURLStr = self.getURLStr + ("&&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                } else {
                    self.getURLStr = self.getURLStr + ("?&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
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
    
    /// 页面跳转
    ///
    /// - Parameter str: 跳转的链接
    fileprivate func aaa(str : String) -> Void {
        
        let vvv = ShopWebV()
        vvv.getURLStr = str
        
        self.navigationController?.pushViewController(vvv, animated: true)
    }
    
}
