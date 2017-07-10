//
//  WKVC.swift
//  TimeStamp
//
//  Created by 郑东喜 on 2017/7/9.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import WebKit

class WKVC: UIViewController {
    
    var url : String? {
        didSet {
            /// 有网络、没网络处理
            NetCheck.shared.returnNetStatus { (result) in
                if result {
                    DispatchQueue.main.async {
                        self.webView.load(URLRequest.init(url: URL.init(string: self.url!)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0))
                    }
                } else {
                    self.webView.load(URLRequest.init(url: URL.init(string: self.url!)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10.0))
                }
            }
        }
    }

    lazy var webView: WKWebView = {
        let d : WKWebView = WKWebView.init(frame: self.view.bounds)
        d.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        d.addObserver(self, forKeyPath: #keyPath(WKWebView.loading), options: .new, context: nil)
        d.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        d.load(URLRequest.init(url: URL.init(string: "https://www.baidu.com")!))
        return d
    }()
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
   
        guard let keyPath = keyPath else {return}
        guard let change = change else {return}
        
        
        switch keyPath {
        case "title":
            
            if let val = change[.newKey] as? String {
                print(val)
                self.navigationItem.title = val
            }
            break
            case "loading":
                if let val = change[.newKey] as? Bool {
                    print(val)
                }
            break
            
        case "estimatedProgress":
            if let val = change[.newKey] as? Double {
                print(val)
            }
            break
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("dealloc")
        // using KVO, always tear down, take no chances
        self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.loading))
        self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.title))
        self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(webView)
        
        view.backgroundColor = COMMON_TBBGCOLOR
    }
}
