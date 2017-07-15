//
//  DetailViewController.swift
//  VotingApp
//
//  Created by 郑东喜 on 2017/3/17.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  订单

import UIKit
import WebKit

class DetailViewController2: WkBaseViewController {
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 64)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if self.navigationController?.viewControllers.count > 1 {
            
            let bounds = self.navigationController!.navigationBar.bounds
            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 64)


        } else {

   
            let bounds = self.navigationController!.navigationBar.bounds
            
            CCog(message: self.navigationController!.navigationBar.bounds)
            
            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 54)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.urlString = TEST_URL
        
        
        let request : URLRequest = NSURLRequest.init(url: URL.init(string: self.urlString)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 0) as URLRequest
        
        self.webView.load(request)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


extension DetailViewController2 {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        self.getURLStr = (navigationAction.request.url?.absoluteString)!
        
        CCog(message: self.getURLStr)
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
  
            self.aaa(str:self.getURLStr)
            
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
}


extension DetailViewController2 {
    
    /// 页面跳转
    ///
    /// - Parameter str: 跳转的链接
    fileprivate func aaa(str : String) -> Void {
        
        CCog(message: str)
        
        let vvv = DetailReplaceVC()
        vvv.getURLStr = str
        
        self.navigationController?.pushViewController(vvv, animated: true)
        
    }
}
