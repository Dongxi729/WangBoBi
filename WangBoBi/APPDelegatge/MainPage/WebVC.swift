//
//  WebVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/30.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  网页

import UIKit
import WebKit

class WebVC: UIViewController,WKNavigationDelegate,WKUIDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    /// 断网视图
    fileprivate lazy var netLoatV: NetLostV = {
        let d : NetLostV = NetLostV.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH / 2, height: SCREEN_WIDTH / 2 * (116 / 123)))
        //
        return d
    }()
    
    var url : String? {
        didSet {
            NetCheck.shared.returnNetStatus { (result) in
                if result {
                    DispatchQueue.main.async {
                        self.webView.load(URLRequest.init(url: URL.init(string: self.url!)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0))
                    }
                } else {
                    self.webView.load(URLRequest.init(url: URL.init(string: self.url!)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10.0))
                }
            }
            
            CCog(message: "设置了")
            
        }
    }
    
    ///网页模板
    lazy var webView: WKWebView = {
        var wkV : WKWebView = WKWebView.init()
        
        //配置webview
        var configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        // 禁止选择CSS
        let css = "body{-webkit-user-select:none;-webkit-user-drag:none;}"
        
        // CSS选中样式取消
        let javascript = NSMutableString.init()
        
        javascript.append("var style = document.createElement('style');")
        javascript.append("style.type = 'text/css';")
        javascript.appendFormat("var cssContent = document.createTextNode('%@');", css)
        javascript.append("style.appendChild(cssContent);")
        javascript.append("document.body.appendChild(style);")
        
        
        // javascript注入
        let noneSelectScript = WKUserScript.init(source: javascript as String, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        userContentController.addUserScript(noneSelectScript)
        
        configuration.userContentController = userContentController
        
        
        ///由于设置了edgesForExtendedLayout,防止了页面全部控件向上偏移，所以在子页面数大于2的时候，矫正
        wkV = WKWebView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), configuration: configuration)
        
        wkV.navigationDelegate = self;
        
        //词句注释，无法唤起微信支付
        wkV.uiDelegate = self
        
        //监听KVO--用来监督进度
        wkV.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil) // add observer for key path
        
        //动画过度
        wkV.alpha = 0
        
        UIView.animate(withDuration: 1.0) {
            wkV.alpha = 1.0
        }
        
        
        /// 取出webView中滑动视图的横竖滑动条
        wkV.scrollView.showsVerticalScrollIndicator = false
        wkV.scrollView.showsHorizontalScrollIndicator = false
        
        return wkV
        
    }()
    
    /// 进度条
    fileprivate lazy var progressView: UIProgressView = {
        let pro : UIProgressView = UIProgressView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 20))
        
        //设置进度条颜色
        pro.progressTintColor = UIColor.red
        
        return pro
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = []
        view.addSubview(webView)
        
        view.addSubview(progressView)
        
        view.backgroundColor = COMMON_TBBGCOLOR
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") { // listen to changes and updated view
            
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("是GV")
        self.view.addSubview(netLoatV)
        self.netLoatV.center = view.center
        print(error.localizedDescription)
    }
    
    ///开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    
    /// 加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        CCog(message: webView.title as Any)
        self.navigationItem.title = webView.title
    }
    
    
    @available(iOS 10.0, *)
    func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
        return false
    }
    
    
    // MARK:- 允许拦截
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let ddd = (navigationAction.request.url?.absoluteString)!
        decisionHandler(.allow)
        print(ddd)
        
    }
    
    // MARK: - deinit
    deinit {
        CCog(message: "zxl")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }


}
