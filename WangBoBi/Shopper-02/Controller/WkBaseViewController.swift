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

class WkBaseViewController: UIViewController,LostNetVDelegate {
    
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
        
        // 登录
        userContentController.add(LeakAvoider.init(delegate: self as WKScriptMessageHandler), name: "login")
        
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
    
    /// 断网视图
    lazy var lostNetV: LostNetV = {
        let d : LostNetV = LostNetV.init(frame: self.view.bounds)
        d.delegate = self
        return d
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
        view.addSubview(lostNetV)
        lostNetV.isHidden = true
        showDowV.alpha = 0
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        view.bringSubview(toFront: self.progressView)
    }
    
    deinit {
        print("dealloc")
        // using KVO, always tear down, take no chances
        if isLoad {
            self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
        }
    }
    
    // MARK: - 断网事件
    func tapFUN() {
        loadNetFunc()
    }
    
    // MARK: - loadNetFunc
    func loadNetFunc() -> Void {
        
        if self.getURLStr.characters.count == 0 {
            var stringUrl = self.getURLStr
            
            if STOTRURL.contains(COMMON_PREFIX) {
                if STOTRURL.contains("?") {
                    stringUrl = STOTRURL + ("&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                } else {
                    stringUrl = STOTRURL + ("?&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                }
                
                self.webView.load(URLRequest.init(url: URL.init(string: stringUrl)!))
                
            } else {
                CCog(message: "")
                lostNetV.isHidden = false
            }
        } else {
            if isLoad {
                self.webView.reload()
            } else {
                var stringUrl = STOTRURL
                
                if STOTRURL.contains(COMMON_PREFIX) {
                    if STOTRURL.contains("?") {
                        stringUrl = STOTRURL + ("&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                    } else {
                        stringUrl = STOTRURL + ("?&token=") + (AccountModel.shared()?.Token)! + "&uid=" + (AccountModel.shared()?.Id.stringValue)!
                    }
                    
                    self.webView.load(URLRequest.init(url: URL.init(string: stringUrl)!))
                    
                } else {
                    CCog(message: "")
                    lostNetV.isHidden = false
                }
            }
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

// MARK: - 禁止3d touch预览
extension WkBaseViewController : WKUIDelegate {
    @available(iOS 10.0, *)
    func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
        return false
    }
    
}

// MARK: - WKNavigationDelegate
extension WkBaseViewController : WKNavigationDelegate {
    
    
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        //        toast(toast: error.localizedDescription)
        //
        //        view.bringSubview(toFront: lostNetV)
        //        lostNetV.isHidden = false
        
        
    }
    
    
    ///开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        if self.limited == true {
            self.navigationItem.title = "请检查网络设置~"
        }
    }
    
    
    /// 加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        CCog(message: "")
        
        lostNetV.isHidden = true
        
        if self.navigationController?.viewControllers.count > 1 {
            ///标题赋值
            self.navigationItem.title = webView.title
            isLoad = true
        }
        
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
        
        if msg == "login" {
            CCog(message: "返回登录")
            DispatchQueue.main.async {
                let alertConte = UIAlertController.init(title: "友情提示", message: "该用户未登录,是否登录？", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction.init(title: "好的", style: .default, handler: { (alert) in
                    var nav = LoginNav()
                    nav = LoginNav.init(rootViewController: LoginViewController())
                    
                    UIApplication.shared.keyWindow?.rootViewController = nav
                })
                
                let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
                
                alertConte.addAction(okAction)
                alertConte.addAction(cancelAction)
                self.present(alertConte, animated: true, completion: nil)
            }
        }
        
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
        
        NetCheck.shared.returnNetStatus { (result) in
            if result {
                self.webView.reload()
                self.loadNetFunc()
            } else {
                d.endRefresh()
                toast(toast: "网络不给力，请检查后重试")
            }
        }
        
        
    }
}

protocol LostNetVDelegate {
    /// 单机屏幕事件
    ///
    func tapFUN() -> Void
}

// MARK: - 断网视图
class LostNetV: UIView {
    
    var delegate : LostNetVDelegate?
    
    
    fileprivate lazy var imgView: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: self.center.x - SCREEN_WIDTH * 0.1 * SCREEN_SCALE, y: SCREEN_HEIGHT * 0.3, width:SCREEN_WIDTH * 0.2 * SCREEN_SCALE, height: SCREEN_WIDTH * 0.2 * (256 / 291) * SCREEN_SCALE))
        d.layer.borderWidth = 1
        d.image = #imageLiteral(resourceName: "xxx")
        d.isUserInteractionEnabled = true
        
        /// 单机事件
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(tapSEL))
        d.addGestureRecognizer(tapGes)
        return d
    }()
    
    /// 标题
    lazy var titleLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.imgView.BottomY + COMMON_MARGIN * SCREEN_SCALE, width: SCREEN_WIDTH, height: 30 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 25 * SCREEN_SCALE)
        d.text = "网络不给力"
        d.textColor = UIColor.darkGray
        d.textAlignment = .center
        return d
    }()
    
    /// 描述文本
    lazy var descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.titleLabel.BottomY + COMMON_MARGIN, width: SCREEN_WIDTH, height: 15 * SCREEN_SCALE))
        d.text = "请检查网络后点击屏幕重试"
        d.textColor = UIColor.darkGray
        d.textAlignment = .center
        return d
    }()
    
    @objc fileprivate func tapSEL() {
        self.delegate?.tapFUN()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imgView)
        addSubview(titleLabel)
        addSubview(descLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
