//
//  TestViewController.swift
//  WangBoBi
//
//      Created by 郑东喜 on 2017/6/18.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var alertController = UIAlertController()
    
    lazy var chooseBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        d.backgroundColor = UIColor.red
        
        d.addTarget(self, action: #selector(choose), for: .touchUpInside)
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(chooseBtn)
    }
    
    func choose() -> Void {
        UploadHeadTool.shared.choosePic { (dic, diddd) in
            CCog(message: dic)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }
    }
    
    
    
    //选择图片成功后代理
    private func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //获取选择的原图
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //将选择的图片保存到Document目录下
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask, true)[0] as String
        let filePath = "\(rootPath)/pickedimage.jpg"
        let imageData = UIImageJPEGRepresentation(pickedImage, 1.0)
        fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
        
        //上传图片
        if (fileManager.fileExists(atPath: filePath)){
            //取得NSURL
            let _:NSURL = NSURL.init(fileURLWithPath: filePath)

        }
        
        //图片控制器退出
        picker.dismiss(animated: true, completion:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
