//  http://www.hangge.com/blog/cache/detail_915.html
//  ViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import AVFoundation

let kMargin = 35
let kBorderW = 140
let scanViewW = UIScreen.main.bounds.width - CGFloat(kMargin * 2)
let scanViewH = UIScreen.main.bounds.width - CGFloat(kMargin * 2)

class ViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
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

    
    /// 定时器
    var timer : Timer?
    
    /// 执行动画的线条
    var slideLineView: UIImageView = UIImageView()

    var scanView: UIView = UIView()

    /// 扫描图标
    var scanImageView : UIImageView = UIImageView()

    /// 线条动画
    @objc fileprivate func scanLineAnimate() {
        timer = Timer.init(timeInterval: 3.0, target: self, selector: #selector(animationView), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
        timer?.fire()
    }
    
    
    /// 扫描动画
    func animationView() -> Void {
        let anim = scanImageView.layer.animation(forKey: "translationAnimation")
        if (anim != nil) {

            scanImageView
                .layer.speed = 1.1
        } else {
            
            let scanImageViewH = 241
            let scanViewH = view.bounds.width - CGFloat(kMargin) * 2
            let scanImageViewW = scanView.bounds.width
            
            scanImageView.frame = CGRect(x: 0, y: -scanImageViewH, width: Int(scanImageViewW), height: scanImageViewH)
            let scanAnim = CABasicAnimation()
            scanAnim.keyPath = "transform.translation.y"
            scanAnim.byValue = [scanViewH]
            scanAnim.duration = 1.8
            scanAnim.repeatCount = MAXFLOAT
            scanImageView.layer.add(scanAnim, forKey: "translationAnimation")
            scanView.addSubview(scanImageView)
        }
    }
    
    

    /// 摄像头事件?
    @objc private func cameraSEl() -> Void {
        
        self.device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            self.device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            
            /// 设置自动对焦
            if device.isAdjustingFocus {
                device.focusMode = AVCaptureFocusMode.autoFocus
            }
            
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
            scanView = UIView(frame: CGRect(x: CGFloat(kMargin), y: CGFloat((view.bounds.height - scanViewW) / 2), width: scanViewW, height: scanViewH))
            scanView.backgroundColor = UIColor.clear
            scanView.clipsToBounds = true
            view.addSubview(scanView)
            
            let widthOrHeight: CGFloat = 18
            
            let topLeft = UIButton(frame: CGRect(x: 0, y: 0, width: widthOrHeight, height: widthOrHeight))
            topLeft.setImage(UIImage.init(named: "sweep_kuangupperleft.png"), for: .normal)
            scanView.addSubview(topLeft)
            
            let topRight = UIButton(frame: CGRect(x: scanViewW - widthOrHeight, y: 0, width: widthOrHeight, height: widthOrHeight))
            topRight.setImage(UIImage.init(named: "sweep_kuangupperright.png"), for: .normal)
            scanView.addSubview(topRight)
            
            let bottomLeft = UIButton(frame: CGRect(x: 0, y: scanViewH - widthOrHeight, width: widthOrHeight, height: widthOrHeight))
            bottomLeft.setImage(UIImage.init(named: "sweep_kuangdownleft.png"), for: .normal)
            scanView.addSubview(bottomLeft)
            
            let bottomRight = UIButton(frame: CGRect(x: scanViewH - widthOrHeight, y: scanViewH - widthOrHeight, width: widthOrHeight, height: widthOrHeight))
            bottomRight.setImage(UIImage.init(named: "sweep_kuangdownright.png"), for: .normal)
            scanView.addSubview(bottomRight)

            let scanImageViewH = 241

            let scanImageViewW = scanView.bounds.width
            
            
            /// 动画图标
            scanImageView.frame = CGRect(x: 0, y: -scanImageViewH, width: Int(scanImageViewW), height: scanImageViewH)
            scanImageView = UIImageView(image: UIImage.init(named: "sweep_bg_line.png"));
            scanView.addSubview(scanImageView)

            
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

    /// 整体遮罩设置
    fileprivate func setupMaskView() {
        let maskView = UIView(frame: CGRect(x: -(view.bounds.height - view.bounds.width) / 2, y: 0, width: view.bounds.height, height: view.bounds.height))
        maskView.layer.borderWidth = (view.bounds.height - scanViewW) / 2
        maskView.layer.borderColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        view.addSubview(maskView)
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
    
    
    // MARK: - 描述文本
    fileprivate lazy var descLabel: UILabel = {
        let scanSize = CGSize(width:SCREEN_WIDTH * 3 / 4, height:SCREEN_WIDTH * 3 / 4)
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT * 0.5 - scanSize.height * 0.5 - 32 + SCREEN_WIDTH * 3 / 4, width: SCREEN_WIDTH, height: 20 * SCREEN_SCALE))
        d.textAlignment = .center
        d.textColor = UIColor.white
        d.text = "放入框内,自动扫描"
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        title = "扫一扫"
    
        self.view.backgroundColor = UIColor.black
        
        self.descLabel.isHidden = false
        
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.8)
        
        DispatchQueue.main.async {
            self.view.addSubview(self.indicator)
            self.indicator.startAnimating()
        }
        
        
        //延时2秒执行
        DispatchQueue.global(qos: .default).asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            DispatchQueue.main.async {
                self.setupMaskView()
                self.cameraSEl()
                self.indicator.stopAnimating()
                self.view.addSubview(self.descLabel)
                self.scanLineAnimate()
            }
        }
    }
}
