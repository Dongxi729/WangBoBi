//
//  PickerV.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/28.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  选择器

import UIKit

protocol PickVDelegate {
    func getSelected(selectedStr : String) -> Void
}


//http://www.hangge.com/blog/cache/detail_541.html
class PickerV: UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var delegate : PickVDelegate?
    
    fileprivate lazy var pickerV: UIPickerView = {
        let d : UIPickerView = UIPickerView.init(frame: self.bounds)
        d.delegate = self
        d.dataSource = self
        return d
    }()
    
    
    var dataSource : [String] = ["JPY","CHY"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pickerV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIPickerViewDelegate,UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.getSelected(selectedStr: dataSource[row])
    }
    
}
