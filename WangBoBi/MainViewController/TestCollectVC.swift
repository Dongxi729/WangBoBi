//
//  TestCollectVC.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class TestCollectVC: UIViewController {
    
    /// 文字
    var dataSource : [String] = ["1","2","3","4"]
    
    let commonMargin : CGFloat = 12.0
    
    /// 九宫格
    lazy var collV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        
        //列数
        let columnsNum = 3
        
        //整个view的宽度
        let collectionViewWidth = SCREEN_BOUNDS
        
        //计算单元格的宽度
        let itemWidth = SCREEN_WIDTH / 4
        
        //设置单元格宽度和高度
        layout.itemSize = CGSize(width:itemWidth * 0.77, height:itemWidth * 0.55)
        
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        /// 设置大小出错///
        let d : UICollectionView = UICollectionView.init(frame:SCREEN_BOUNDS, collectionViewLayout: layout)
        
        d.backgroundColor = UIColor.clear
        
        d.dataSource = self
        d.delegate = self
        
        d.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        
        return d
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(collV)
    }
}



extension TestCollectVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CollectionViewCell
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top:0, left: commonMargin * SCREEN_SCALE, bottom: 0, right: commonMargin * SCREEN_SCALE)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.count
        
    }
    
}
