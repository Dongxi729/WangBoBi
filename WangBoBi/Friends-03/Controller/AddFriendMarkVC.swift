//
//  AddFriendMarkVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/25.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class AddFriendMarkVC: BaseViewController,BindPhoneFooterVDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(bgV)
        view.addSubview(footerView)
        self.bgV.addSubview(sendTf)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        let touchPoint: CGPoint? = touch?.location(in: self.view)
        print("\((touchPoint?.x)! / self.view.Width)==\((touchPoint?.y)! / self.view.Height)")
        let stringFloat = Int((touchPoint?.x)!)
        let stringFloat1 = Int((touchPoint?.y)!)
        print("\(stringFloat)\(stringFloat1)")
    }
    
    lazy var sendTf: TfPlaceHolder = {
        let d : TfPlaceHolder = TfPlaceHolder.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.bgV.Height * 0.27, width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: 35 * SCREEN_SCALE))
        d.layer.borderWidth = 1
        return d
    }()
    

    
    fileprivate lazy var bgV: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (287 / 640)))
        d.image = #imageLiteral(resourceName: "friendRequest")
        d.isUserInteractionEnabled = true
        return d
    }()
    
    fileprivate lazy var footerView: BindPhoneFooterV = {
        let d : BindPhoneFooterV = BindPhoneFooterV.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - 60, width: SCREEN_WIDTH, height: 60))
        d.setFooterTitle(str: "发送")
        d.delegate = self
        return d
    }()
    
    // MARK: - footervieDelegate 
    func bindPhonSELDelegate() {
        CCog(message: "")
    }

}