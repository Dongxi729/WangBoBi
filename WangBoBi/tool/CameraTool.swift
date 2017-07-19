//
//  CameraTool.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/19.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit
import Photos

class CameraTool: NSObject {
    /// 判断访问相机权限
    ///
    /// - Returns: 返回bool值
    class func cameraPermissions() -> Bool {
        
        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        
        if(authStatus == AVAuthorizationStatus.denied || authStatus == AVAuthorizationStatus.restricted) {
            return false
        } else {
            return true
        }
        
    }
    
    /// 访问相册权限
    ///
    /// - Returns: 返回布尔值
    class func PhotoLibraryPermissions() -> Bool {
        
        let library:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if(library == PHAuthorizationStatus.denied || library == PHAuthorizationStatus.restricted) {
            return false
        }else {
            return true
        }
    }
}
