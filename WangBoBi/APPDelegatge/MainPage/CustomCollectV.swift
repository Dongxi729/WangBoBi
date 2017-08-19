//
//  CustomCollectV
//  TimeStamp
//
//  Created by 郑东喜 on 2017/8/11.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  自定义CollectionView

import UIKit

protocol CustomCollectDelegate {
    /// 选择的cell
    func selectCell(_ indexPath : IndexPath)
}

class CustomCollect : UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var delegate : CustomCollectDelegate?
    
    /// collectionView布局
    lazy var layout: UICollectionViewFlowLayout = {
        let d: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        d.scrollDirection = .vertical
        d.itemSize = self.cellItemSize
        return d
    }()
    
    /// UICollectionView
    lazy var collecTTC: UICollectionView = {

        let d : UICollectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: self.layout)
        d.delegate = self
        d.dataSource = self
        d.backgroundColor = .clear
        d.register(MyTestCollectionViewCell.self, forCellWithReuseIdentifier: "MyTestCollectionViewCell")
        
        return d
    }()
    
    /// 标题数组
    var titles : [String] = []

    /// 多少个collectionView
    var cells : Int = 0
    
    /// uicollectionViewFlowLayout 中itemSize 的大小
    var cellItemSize : CGSize = CGSize.init(width: 0, height: 10)
    
    /// 初始化collectionView
    ///
    /// - Parameters:
    ///   - titles: 数组
    ///   - imgs: 图片名字数组
    ///   - rect: 大小
    ///   - cellItemSize: cellItemSize  的大小
    init(_ titles :[String],_ rect : CGRect,_ cellItemSize :CGSize) {
        super.init(frame: rect)
        self.cells = titles.count
        self.titles = titles
        self.layout.itemSize = cellItemSize
        addSubview(collecTTC)
        
    }
    
    // MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewFlowLayout
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTestCollectionViewCell", for: indexPath) as! MyTestCollectionViewCell
        
        cell.myLabel.setTitle(titles[indexPath.row], for: .normal)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MyTestCollectionViewCell
        updateCellStatus(cell, selected: false)
        if indexPath.row == 0 {
            updateCellStatus(cell, selected: false)
        }
    }
    
    func updateCellStatus(_ cell: MyTestCollectionViewCell, selected: Bool) {
        
        cell.myLabel.backgroundColor = selected ? UIColor.colorWithHexString("2796DD") : UIColor.white
        cell.myLabel.setTitleColor(selected ? UIColor.white : UIColor.black, for: .normal)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MyTestCollectionViewCell
        self.delegate?.selectCell(indexPath)
        updateCellStatus(cell, selected: true)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MyTestCollectionViewCell: UICollectionViewCell {

    lazy var myLabel: UIButton = {
        let label : UIButton = UIButton.init(frame: self.bounds)
        label.titleLabel?.font = UIFont.systemFont(ofSize: 13 * SCREEN_SCALE)
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.colorWithHexString("F3F3F3").cgColor
        label.isUserInteractionEnabled = false
        label.setTitleColor(.black, for: .normal)
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

