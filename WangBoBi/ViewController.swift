//  http://www.hangge.com/blog/cache/detail_915.html
//  ViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    lazy var cameraBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        d.backgroundColor = UIColor.gray
//        d.addTarget(self, action: #selector(cameraSEl(sender:)), for: .touchUpInside)
        return d
    }()
    
    
    /// 输入数据源设备
    var device : AVCaptureDevice!
    
    /// 输入
    var input : AVCaptureDeviceInput!
    
    /// 输出
    var output : AVCaptureMetadataOutput!
    
    /// 会话
    var session : AVCaptureSession!
    
    /// 预览视图
    var preview : AVCaptureVideoPreviewLayer!
    
    /// 扫描区域视图
    var scanRectView:UIView!

    // MARK: - 描述文本
    lazy var descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.scanRectView.BottomY + COMMON_MARGIN, width: SCREEN_WIDTH, height: 20 * SCREEN_SCALE))
        d.textAlignment = .center
        d.text = "放入框内,自动扫描"
        return d
    }()
    
    @objc private func cameraSEl() -> Void {
        
        self.device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            self.device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            
            /// 设置自动对焦
//            if device.isAdjustingFocus {
//                device.focusMode = AVCaptureFocusMode.autoFocus
//            }
            
            self.input = try AVCaptureDeviceInput(device: device)
            
            self.output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            self.session = AVCaptureSession()
            if UIScreen.main.bounds.size.height<500 {
                self.session.sessionPreset = AVCaptureSessionPreset640x480
            }else{
                self.session.sessionPreset = AVCaptureSessionPresetHigh
            }
            
            self.session.addInput(self.input)
            self.session.addOutput(self.output)
            
            self.output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            //计算中间可探测区域
            let windowSize = UIScreen.main.bounds.size
            let scanSize = CGSize(width:windowSize.width*3/4, height:windowSize.width*3/4)
            var scanRect = CGRect(x:(windowSize.width-scanSize.width)/2,
                                  y:(windowSize.height-scanSize.height)/2,
                                  width:scanSize.width, height:scanSize.height)
            //计算rectOfInterest 注意x,y交换位置
            scanRect = CGRect(x:scanRect.origin.y/windowSize.height,
                              y:scanRect.origin.x/windowSize.width,
                              width:scanRect.size.height/windowSize.height,
                              height:scanRect.size.width/windowSize.width);
            //设置可探测区域
            self.output.rectOfInterest = scanRect
            
            self.preview = AVCaptureVideoPreviewLayer(session:self.session)
            self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.preview.frame = UIScreen.main.bounds
            self.view.layer.insertSublayer(self.preview, at:0)
            
            //添加中间的探测区域绿框
            self.scanRectView = UIView();
            self.view.addSubview(self.scanRectView)
            self.scanRectView.frame = CGRect(x:SCREEN_WIDTH * 0.5 - scanSize.width * 0.5, y:SCREEN_HEIGHT * 0.5 - scanSize.height * 0.5 - 32, width:scanSize.width,
                                             height:scanSize.height);
            self.scanRectView.layer.borderColor = UIColor.green.cgColor
            self.scanRectView.layer.borderWidth = 1;
            
            //开始捕获
            self.session.startRunning()
        }catch _ {
            //打印错误消息
            let alertController = UIAlertController(title: "提醒",
                                                    message: "请在iPhone的\"设置-隐私-相机\"选项中,允许本程序访问您的相机",
                                                    preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        var stringValue:String?
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
            
            if stringValue != nil{
                self.session.stopRunning()
            }
        }
        self.session.stopRunning()
        //输出结果
        let alertController = UIAlertController(title: "二维码",
                                                message: stringValue,preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            //继续扫描
            self.session.startRunning()
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    var maskLayer = CALayer()
    

    lazy var indicator: UIActivityIndicatorView = {
        let d : UIActivityIndicatorView = UIActivityIndicatorView.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - 50, y: SCREEN_HEIGHT * 0.5 - 50 - 32, width: 100, height: 100))
        d.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "扫一扫"
        self.view.backgroundColor = UIColor.black
        
        
        
        DispatchQueue.main.async {
            self.view.addSubview(self.indicator)
            self.indicator.startAnimating()
        }
        
        
        //延时2秒执行
        DispatchQueue.global(qos: .default).asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            DispatchQueue.main.async {
                self.cameraSEl()
                self.indicator.stopAnimating()
                self.view.addSubview(self.descLabel)
            }
        }
        
        
        
        
        maskLayer = CALayer()
        maskLayer.frame = view.layer.bounds
        maskLayer.delegate = self as? CALayerDelegate
        view.layer.insertSublayer(maskLayer, above: preview)
        maskLayer.setNeedsDisplay()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func drawLayer(_ layer: CALayer, inContext ctx: CGContext?) {
        if layer == maskLayer {
            UIGraphicsBeginImageContextWithOptions(maskLayer.frame.size, false, 1.0)
            ctx?.setFillColor(UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(0.6)).cgColor)
            ctx?.fill(maskLayer.frame)
            let scanFrame = view.convert(self.view.frame, to: scanRectView.superview)
            ctx?.clear(scanFrame)
        }
    }

}
