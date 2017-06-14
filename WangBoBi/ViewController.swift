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
    
    func cameraSEl() -> Void {
        print("照相机事件")
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
}
