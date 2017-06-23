//
//  CodeProductor.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/22.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  二维码生产           https://github.com/fuaiyi/QRCode

import UIKit

class CodeProductor: UIViewController {
    
    lazy var generatImgView: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH / 2 - SCREEN_WIDTH / 6, y: SCREEN_HEIGHT * 0.15, width: SCREEN_WIDTH / 3 , height: SCREEN_WIDTH / 3))
        return d
    }()
    
    lazy var descLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.generatImgView.BottomY + COMMON_MARGIN * SCREEN_SCALE, width: SCREEN_WIDTH, height: 30 * SCREEN_SCALE))
        d.text = "用网博支付钱包扫一扫二维码，加我好友"
        d.textAlignment = .center
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(generatImgView)
        
        view.addSubview(descLabel)

        title = "我的二维码"
        
        view.backgroundColor = UIColor.lightText
        
        
        DispatchQueue.global().async {
            
            let context = ((AccountModel.shared()?.nickName)! + (AccountModel.shared()?.email)!)
            
            let image = context.generateQRCode()
            
            DispatchQueue.main.async {
                self.generatImgView.image = image
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)

    
    }
}
