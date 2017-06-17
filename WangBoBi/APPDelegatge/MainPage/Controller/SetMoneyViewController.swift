//
//  SetMoneyViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/17.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  设置金额控制器

import UIKit

class SetMoneyViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    lazy var pickV: UIPickerView = {
        let d : UIPickerView = UIPickerView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH / 2, height: 100))
        d.delegate = self;
        d.dataSource = self;
        return d
    }()

    
    var dataSource : [String] = ["颠三倒四多","是的撒多","巫毒娃娃"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "设置金额"
        
        view.addSubview(pickV)
        
        pickV.center = view.center
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CCog(message: dataSource[row])
    }
}
