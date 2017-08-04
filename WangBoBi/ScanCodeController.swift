
//  http://www.jianshu.com/p/e48266566336 解决导航栏控件下移64

let kMargin = 35
let kBorderW = 140
let scanViewW = (UIScreen.main.bounds.width - CGFloat(kMargin * 2)) * 0.8
let scanViewH = (UIScreen.main.bounds.width - CGFloat(kMargin * 2)) * 0.8

import UIKit
import AVFoundation

class ScanCodeController: BaseViewController {
    
    var scanView: UIView? = nil
    var scanImageView: UIImageView? = nil
    var session = AVCaptureSession()
    
    // MARK: - 扫描二维码
    fileprivate lazy var scanLabel: BtnWithImage = {
        let d : BtnWithImage = BtnWithImage.init(frame: CGRect.init(x: SCREEN_WIDTH * 0.5 - SCREEN_WIDTH / 6 + 10 * SCREEN_SCALE, y: (self.scanView?.BottomY)! + COMMON_MARGIN * SCREEN_SCALE, width: SCREEN_WIDTH / 2.5, height: 20 * SCREEN_SCALE))
        
        d.setTitle(" 扫描二维码", for: .normal)
        d.setImage(#imageLiteral(resourceName: "Sweep 1"), for: .normal)
        d.setTitleColor(UIColor.white, for: .normal)
        return d
    }()

    
    /// 扫一扫
    fileprivate lazy var descLabel: UILabel = {
        let f : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.scanLabel.BottomY + COMMON_MARGIN / 2 * SCREEN_SCALE, width: SCREEN_WIDTH, height: 15))
        f.textAlignment = .center
        f.textColor = UIColor.white
        f.text = "放入框内,自动扫描"
        f.font = UIFont.systemFont(ofSize: 10 * SCREEN_SCALE)
        return f
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetAnimatinon()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 解决导航栏跳转后，控件下移64 的Bug
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        
        view.clipsToBounds = true
        setupMaskView()
        setupScanView()
        
        view.addSubview(scanLabel)
        view.addSubview(descLabel)
        
        title = "扫一扫"
        
        /// 开始扫描
        scaning()
        view.backgroundColor = UIColor.black
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetAnimatinon), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 整体遮罩设置
    fileprivate func setupMaskView() {
        let maskView = UIView(frame: CGRect(x: -(view.bounds.height - view.bounds.width) / 2, y: 0, width: view.bounds.height, height: view.bounds.height))
        maskView.layer.borderWidth = (view.bounds.height - scanViewW) / 2
        maskView.layer.borderColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        view.addSubview(maskView)
        
    }
    
    /// 扫描区域设置
    fileprivate func setupScanView() {
        
        scanView = UIView(frame: CGRect(x: UIScreen.main.bounds.width * 0.5 - scanViewW * 0.5, y: CGFloat((view.bounds.height - scanViewW) / 2), width: scanViewW, height: scanViewH))
        scanView?.backgroundColor = UIColor.clear
        scanView?.clipsToBounds = true
        view.addSubview(scanView!)
        
        let scanViewImg : UIImageView = UIImageView.init(frame: (self.scanView?.frame)!)
        scanViewImg.image = #imageLiteral(resourceName: "queue")
        //        scanViewImg.backgroundColor = UIColor.red
        view.addSubview(scanViewImg)
        
        /// 设置扫描图片位置
        scanImageView = UIImageView(image: UIImage.init(named: "sweep_bg_line.png"));
        let widthOrHeight: CGFloat = 18
        
        let topLeft = UIButton(frame: CGRect(x: 0, y: 0, width: widthOrHeight, height: widthOrHeight))
        topLeft.setImage(UIImage.init(named: "sweep_kuangupperleft.png"), for: .normal)
        scanView?.addSubview(topLeft)
        
        let topRight = UIButton(frame: CGRect(x: scanViewW - widthOrHeight, y: 0, width: widthOrHeight, height: widthOrHeight))
        topRight.setImage(UIImage.init(named: "sweep_kuangupperright.png"), for: .normal)
        scanView?.addSubview(topRight)
        
        let bottomLeft = UIButton(frame: CGRect(x: 0, y: scanViewH - widthOrHeight, width: widthOrHeight, height: widthOrHeight))
        bottomLeft.setImage(UIImage.init(named: "sweep_kuangdownleft.png"), for: .normal)
        scanView?.addSubview(bottomLeft)
        
        let bottomRight = UIButton(frame: CGRect(x: scanViewH - widthOrHeight, y: scanViewH - widthOrHeight, width: widthOrHeight, height: widthOrHeight))
        bottomRight.setImage(UIImage.init(named: "sweep_kuangdownright.png"), for: .normal)
        scanView?.addSubview(bottomRight)
    }
    
    
    /// 开始扫描
    fileprivate func scaning() {
        
        CCog(message: CameraTool.cameraPermissions())
        
        /// 判断摄像头是否有权限
        if CameraTool.cameraPermissions() {
            //获取摄像设备
            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            do {
                //创建输入流
                let input = try AVCaptureDeviceInput.init(device: device)
                //创建输出流
                let output = AVCaptureMetadataOutput()
                output.rectOfInterest = CGRect(x: 0.1, y: 0, width: 0.9, height: 1)
                //设置代理,在主线程刷新
                output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                //初始化链接对象 / 高质量采集率
                session.canSetSessionPreset(AVCaptureSessionPresetHigh)
                session.addInput(input)
                session.addOutput(output)
                
                //在上面三行之后写下面代码,不然报错如下:Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[AVCaptureMetadataOutput setMetadataObjectTypes:] Unsupported type found - use -availableMetadataObjectTypes'
                //http://stackoverflow.com/questions/31063846/avcapturemetadataoutput-setmetadataobjecttypes-unsupported-type-found
                //设置扫码支持的编码格式
                output.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]
                
                let layer = AVCaptureVideoPreviewLayer(session: session)
                layer?.videoGravity = AVLayerVideoGravityResizeAspectFill
                layer?.frame = view.layer.bounds
                view.layer.insertSublayer(layer!, at: 0)
                //开始捕捉
                session.startRunning()
                
            } catch let error as NSError  {
                //                print("errorInfo\(error.domain)")
                CCog(message: error.domain)
            }
        } else {
            //弹出提示框
            let sheet = UIAlertController(title: nil, message: "请在设置中打开摄像头权限", preferredStyle: .alert)
            
            let tempAction = UIAlertAction(title: "确定", style: .cancel) { (action) in
                
                let url = NSURL.init(string: UIApplicationOpenSettingsURLString)
                
                if UIApplication.shared.openURL(url! as URL) {
                    UIApplication.shared.openURL(url! as URL)
                }
            }
            sheet.addAction(tempAction)
            DispatchQueue.main.async {
                UIApplication.shared.keyWindow?.rootViewController?.present(sheet, animated: true, completion: nil)
            }
        }
    }
    
    ///重置动画
    @objc fileprivate func resetAnimatinon() {
        let anim = scanImageView?.layer.animation(forKey: "translationAnimation")
        if (anim != nil) {
            //将动画的时间偏移量作为暂停时的时间点
            let pauseTime = scanImageView?.layer.timeOffset
            //根据媒体时间计算出准确的启动时间,对之前暂停动画的时间进行修正
            let beginTime = CACurrentMediaTime() - pauseTime!
            ///便宜时间清零
            scanImageView?.layer.timeOffset = 0.0
            //设置动画开始时间
            scanImageView?.layer.beginTime = beginTime
            scanImageView?.layer.speed = 1.1
        } else {
            
            let scanImageViewH = 241
            let scanViewH = view.bounds.width - CGFloat(kMargin) * 2
            let scanImageViewW = scanView?.bounds.width
            
            scanImageView?.frame = CGRect(x: 0, y: -scanImageViewH, width: Int(scanImageViewW!), height: scanImageViewH)
            let scanAnim = CABasicAnimation()
            scanAnim.keyPath = "transform.translation.y"
            scanAnim.byValue = [scanViewH]
            scanAnim.duration = 1.8
            scanAnim.repeatCount = MAXFLOAT
            scanImageView?.layer.add(scanAnim, forKey: "translationAnimation")
            scanView?.addSubview(scanImageView!)
        }
    }
}

extension ScanCodeController:AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects.count > 0 {
            session.stopRunning()
            let object = metadataObjects[0]
            let string: String = (object as AnyObject).stringValue
            
            CCog(message: string)
            
            if let _ = URL(string: string) {
                
                //获取非链接结果
                ScanModel.shared.codeStr = (object as AnyObject).stringValue
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeScanCode"), object: nil)
                
                let alertViewController = UIAlertController(title: "扫描结果", message: (object as AnyObject).stringValue, preferredStyle: .alert)
                let actionCancel = UIAlertAction(title: "确定", style: .cancel, handler: { (action) in
                    
                    /// 支付信息
                    if (ScanModel.shared.codeStr?.hasPrefix("wbp://"))! {
                        self.navigationController?.pushViewController(PaymentThreeVC(), animated: true)
                    }
                    
                    /// 添加朋友
                    if (ScanModel.shared.codeStr?.hasPrefix("wbf://"))! {
                        
                        self.navigationController?.pushViewController(AddFriendInfoVC(), animated: true)
                        AddType = 0
                    }
                    
                })
                let actinSure = UIAlertAction(title: "再次扫描", style: .default, handler: { (action) in
                    self.session.startRunning()
                })
                alertViewController.addAction(actionCancel)
                alertViewController.addAction(actinSure)
                self.present(alertViewController, animated: true, completion: nil)
            }
        }
    }
}



class BtnWithImage: UIButton {
    
    // MARK:- 屏幕放大比例
    let SCREEN_SCALE = UIScreen.main.bounds.width / 320
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.isEnabled = false
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        self.setTitleColor(UIColor.black, for: .normal)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect.init(x: SCREEN_SCALE * 20, y: 0, width: UIScreen.main.bounds.width - SCREEN_SCALE * 20, height: self.bounds.height)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        return CGRect.init(x: 0, y: self.bounds.height * 0.1, width: 20 * 0.8 * SCREEN_SCALE , height: self.bounds.height * 0.8)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
