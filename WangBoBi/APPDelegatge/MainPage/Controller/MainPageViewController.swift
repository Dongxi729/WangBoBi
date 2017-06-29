//
//  MainPageViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  首页

import UIKit


//每月书籍
struct BookPreview {
    var title:String
    var images:[String]
}


class MainPageViewController: BaseViewController {
    
    /// reuse数据源
    var sectionDataSource : [String] = ["猜您喜欢","推荐商家","第三方提供服务"]
    
    //所有书籍数据
    fileprivate let books = [
        
        BookPreview(title: "六月新书", images: ["7.jpg", "8000.jpg"]),
        BookPreview(title: "六月新书", images: ["7.jpg", "8.jpg","7.jpg", "8.jpg"]),
        BookPreview(title: "六月新书", images: ["7.jpg", "8.jpg"]),
        BookPreview(title: "六月新书", images: ["7.jpg", "8.jpg"]),
        BookPreview(title: "六月新书", images: ["7.jpg", "8.jpg"]),
        BookPreview(title: "六月新书", images: ["7.jpg", "8.jpg"]),
        BookPreview(title: "六月新书", images: ["7.jpg", "8.jpg"]),
        BookPreview(title: "六月新书", images: ["7.jpg", "8.jpg"]),
        BookPreview(title: "七月新书", images: ["10.jpg", "11.jpg", "12.jpg", "13.jpg"])
    ]
    
    
    /// 九宫格
    lazy var collV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        
        //列数
        let columnsNum = 3
        
        //整个view的宽度
        let collectionViewWidth = SCREEN_BOUNDS
        
        //计算单元格的宽度
        let itemWidth = SCREEN_WIDTH / 3
        
        //设置单元格宽度和高度
        layout.itemSize = CGSize(width:itemWidth * 0.8, height:itemWidth * 0.6)
        
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        /// 设置大小出错///
        let d : UICollectionView = UICollectionView.init(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), collectionViewLayout: layout)
        
        d.backgroundColor = UIColor.clear
        
        d.dataSource = self
        d.delegate = self
        
        d.register(CollectCell.self, forCellWithReuseIdentifier: "cellID")
        d.register(ReuseV.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeadInfoView")
        d.register(HeadReuse.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headReuse")
        
        return d
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "钱包"
        
        view.addSubview(collV)
        view.backgroundColor = COMMON_TBBGCOLOR
        
    }
    
}

extension MainPageViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HeadReuseDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CollectCell
        
        cell.descLabl.text = books[indexPath.section].images[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top:0, left: COMMON_MARGIN * SCREEN_SCALE, bottom: 2 * COMMON_MARGIN * SCREEN_SCALE, right: COMMON_MARGIN * SCREEN_SCALE)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return books.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return books[section].images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind:
                UICollectionElementKindSectionHeader, withReuseIdentifier: "headReuse",
                                                      for: indexPath) as? HeadReuse
            header?.delegate = self
            
            header?.titleLabel.text = books[indexPath.section].title
            return header!
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind:
                UICollectionElementKindSectionHeader, withReuseIdentifier: "HeadInfoView",
                                                      for: indexPath) as? ReuseV
            header?.titleLabel.text = books[indexPath.section].title
            return header!
        }
    }
    
    
    
    //返回头部间距
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        if section == 0 {
            return CGSize.init(width: SCREEN_WIDTH, height: SCREEN_WIDTH * (749 / 640) + 100 + 44 + 2 * COMMON_MARGIN)
        } else {
            return CGSize.init(width: SCREEN_WIDTH, height: 45)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize.init(width: SCREEN_WIDTH, height: 15)
        
    }
    
    // MARK: - HeadReuseDelegate
    func chooseIndex(index: Int) {
        
        let cc = UIViewController()
        cc.view.backgroundColor = UIColor.randomColor()
        switch index {
        /// 扫一扫
        case 600:
            self.navigationController?.pushViewController(ScanCodeController(), animated: true)
            break
        /// 首付款
        case 601:
            self.navigationController?.pushViewController(PaymoneyVC(), animated: true)
            break
        /// 充值
        case 602:
            self.navigationController?.pushViewController(PushingMoneyVC(), animated: true)
            break
        /// 转账
        case 603:
            self.navigationController?.pushViewController(cc, animated: true)
            break
        default:
            break
        }
    }
    
}
