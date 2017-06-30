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
    
    
    //所有书籍数据
    fileprivate let books = [
        
        BookPreview(title: "1月新书", images: ["7.jpg", "8000.jpg"]),
        BookPreview(title: "2月新书", images: ["7.jpg", "8.jpg","7.jpg", "8.jpg"]),
        BookPreview(title: "3月新书", images: ["7.jpg", "8.jpg"]),
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
        layout.itemSize = CGSize(width:itemWidth, height:itemWidth * 1.4)
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
    
    
    var movies = [IndexMertopModel]()
    var model2 = [IndexCommentTopModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "钱包"
        
        view.addSubview(collV)
        view.backgroundColor = COMMON_TBBGCOLOR
        
        AccountModel.indexInfo(finished: { (mm) in
            self.model2 = mm
            CCog(message: mm.count)
            self.collV.reloadData()
            
        }) { (mm2) in
            self.movies = mm2
            CCog(message: mm2.count)
        }
        
    }
    
    static let shared = MainPageViewController()
    
    
}

extension MainPageViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HeadReuseDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CollectCell
        
//        cell.descLabl.text = books[indexPath.section].images[indexPath.item]
        let xxx = movies[indexPath.row]
        let xxx2 = model2[indexPath.row]
        
        cell.dataSource = xxx2
        cell.dataSource2 = xxx
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top:0, left: 0, bottom: 0, right:0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind:
                UICollectionElementKindSectionHeader, withReuseIdentifier: "headReuse",
                                                      for: indexPath) as? HeadReuse
            header?.delegate = self
//            header?.sectionImg.setTitle(books[indexPath.section].title, for: .normal)
//            header?.sectionImg.sizeToFit()
            return header!
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind:
                UICollectionElementKindSectionHeader, withReuseIdentifier: "HeadInfoView",
                                                      for: indexPath) as? ReuseV
//            header?.sectionImg.setTitle(books[indexPath.section].title, for: .normal)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vvvvv = UIViewController()
        vvvvv.view.backgroundColor = UIColor.randomColor()
        self.navigationController?.pushViewController(vvvvv, animated: true)
        
        CCog(message: indexPath.row)
        CCog(message: indexPath.section)
        
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
