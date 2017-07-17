//
//  WkBaseViewController.swift
//  VotingApp
//
//  Created by 郑东喜 on 2017/3/20.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  总的网页控制器

import UIKit
import WebKit


/// 前往订单
var jumpToDetail : Bool = false

// MARK:- 投票用户标识
var toupiaoUserInfo = ""

class WkBaseViewController: UIViewController {
    
    // MARK:- 当前捕获的链接
    var getURLStr : String = ""
    
    var urlString : String = ""
    
    /// 支付标识
    var payResult : Bool = false
    
    /// 网络限制
    var limited : Bool = false
    
    /// 拦截的字符串
    var blokStr : String = ""


    /// 左上角按钮
    var leftBarItem : UIButton = UIButton()
    
    
    /// 是否加载完成
    var isLoad = false
    
    lazy var showDowV: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 20))
        d.backgroundColor = UIColor.colorWithHexString("2796DC")
        return d
    }()
    
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
        
        //支付宝
//        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "alipay")

        
        if self.navigationController?.viewControllers != nil {
            ///由于设置了edgesForExtendedLayout,防止了页面全部控件向上偏移，所以在子页面数大于2的时候，矫正
            if (self.navigationController?.viewControllers.count)! > 1 {
                
                UIView.animate(withDuration: 0.5, animations: {
                    let rect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
                    wkV = WKWebView.init(frame: rect, configuration: configuration)
                })
            } else {

                UIView.animate(withDuration: 0.5, animations: {
                    let rect = CGRect(x: 0, y: 20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 30)
                    
                    wkV = WKWebView.init(frame: rect, configuration: configuration)
                })
            }
        }
        

        //添加刷新控件
        wkV.scrollView.addHeaderViewfun()
        
        let d : headerView = wkV.viewWithTag(888) as! headerView
        d.delegate = self;
        
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
    
    @objc fileprivate func back() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 控制器加载
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.prepareUI()
        
        leftBarItem.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT * 0.01, width: SCREEN_WIDTH * 0.15, height: 20 * SCREEN_SCALE)
        
        leftBarItem.addTarget(self, action:#selector(back), for: .touchUpInside)
        leftBarItem.setBackgroundImage(UIImage.init(named: "rean"), for: .normal)

        view.addSubview(showDowV)
        showDowV.alpha = 0
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CCog(message: self.navigationController?.viewControllers.count)
        
        if (self.navigationController?.viewControllers.count)! > 1 {
            UIApplication.shared.statusBarStyle = .default
            self.leftBarItem.setImage(#imageLiteral(resourceName: "back"), for: .normal)
            
            let navBar = self.navigationController?.navigationBar
            navBar?.barTintColor = UIColor.white
            navBar?.isTranslucent = false
        } else {
            UIApplication.shared.statusBarStyle = .lightContent
            
            let navBar = self.navigationController?.navigationBar
            navBar?.barTintColor = UIColor.colorWithHexString("2796DC")
            navBar?.isTranslucent = false
        }
    }

    
    deinit {
        print("dealloc")
        // using KVO, always tear down, take no chances
        if isLoad {
            self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
        }
    }
}

// MARK:- 观察进度
extension WkBaseViewController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") { // listen to changes and updated view
            
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
}


extension WkBaseViewController {
    // MARK: - 添加控件
    fileprivate func prepareUI() -> Void {
        
        DispatchQueue.main.async {
//            self.view.addSubview(self.webView)
            self.view.insertSubview(self.webView, aboveSubview: (self.navigationController?.navigationBar)!)
        }
        
        
        
        //设置不拉伸界面
        self.edgesForExtendedLayout = UIRectEdge()
        
        if self.navigationController?.viewControllers.count > 1 {
            let height: CGFloat = 10 //whatever height you want
            let bounds = self.navigationController!.navigationBar.bounds
            
            self.progressView = UIProgressView.init(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height))
        } else {
            let height: CGFloat = 54 //whatever height you want
            let bounds = self.navigationController!.navigationBar.bounds
            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
            self.progressView = UIProgressView.init(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height))
        }
        
        view.addSubview(self.progressView)
    }
}

// MARK: - 禁止3d touch预览
extension WkBaseViewController : WKUIDelegate {
    @available(iOS 10.0, *)
    func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
        return false
    }
    
}

// MARK: - WKNavigationDelegate
extension WkBaseViewController : WKNavigationDelegate {
    
    
    
    
    ///开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        if self.limited == true {
            self.navigationItem.title = "请检查网络设置~"
        }
    }
    
    
    /// 加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if self.navigationController?.viewControllers.count > 1 {
            ///标题赋值
            self.navigationItem.title = webView.title
            isLoad = true
        }
        
        print("\((#file as NSString).lastPathComponent):(\(#line))\n","finish Loaded")
        
        /// 加载完毕标识符
        self.isLoad = true
        
        blokStr = ""
        self.limited = false
        
        //解决ios9 以上机型长按弹出alertController的问题，但是有时候灵，有时候不灵验
        if view.window != nil {
            self.webView.evaluateJavaScript("document.documentElement.style.webkitTouchCallout='none';", completionHandler: nil)
        }
        
        
        ///获取进度条的数字
        self.progressView.progress = Float(webView.estimatedProgress)
        
        //走满进度条，停止选择
        if self.webView.isLoading == false {
            UIView.animate(withDuration: 0.5, animations: {
                self.progressView.alpha = 0
            })
        }
    }

}



// MARK:- 接收支付宝app接收结果
extension WkBaseViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        let msg = message.name
        
    }
}


// MARK:- 弱引用交互事件
class LeakAvoider : NSObject, WKScriptMessageHandler {
    weak var delegate : WKScriptMessageHandler?
    init(delegate:WKScriptMessageHandler) {
        self.delegate = delegate
        super.init()
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.delegate?.userContentController(
            userContentController, didReceive: message)
    }
}



// MARK: - 第三方刷新代理方法实现
extension WkBaseViewController : headerViewelegate {
    func headerViewEndfun(_ _endRefresh: () -> Void) {
        
        /// 取出刷新头
        let d : headerView = self.webView.viewWithTag(888) as! headerView
        d.endRefresh()
        
        self.webView.reload()
    }
    
}
