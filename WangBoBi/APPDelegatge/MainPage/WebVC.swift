//
//  WebVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/30.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  网页

import UIKit
import WebKit

class WebVC: UIViewController {
    
    var url : String? {
        didSet {
            CCog(message: "设置了")
            self.webView.load(URLRequest.init(url: URL.init(string: url!)!))
        }
    }
    
    lazy var webView: WKWebView = {
        let d : WKWebView = WKWebView.init(frame: self.view.bounds)
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(webView)
        self.webView.load(URLRequest.init(url: URL.init(string: "http://sale.jd.com/act/4kIOxPynN5TQjMf0.html?cpdad=1DLSUE")!))
    }
}
