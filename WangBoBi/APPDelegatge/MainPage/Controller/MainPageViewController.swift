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


class MainPageViewController: UIViewController {
    
    // MARK: - 头部视图
    lazy var headV: HeadInfoView = {
        let d : HeadInfoView = HeadInfoView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.25))
        return d
    }()
    
    /// 数据源
    var dataSource : [String] = ["扫一扫","收款","充值","转账"]
    
    
    /// reuse数据源
    var sectionDataSource : [String] = ["猜您喜欢","推荐商家","第三方提供服务"]
    
    //所有书籍数据
    let books = [
        BookPreview(title: "五月新书", images: ["扫一扫","收款","充值","转账"]),
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
        let itemWidth = SCREEN_WIDTH / 4
        
        //设置单元格宽度和高度
        layout.itemSize = CGSize(width:itemWidth * 0.77, height:itemWidth * 0.55)
        
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        /// 设置大小出错///
        let d : UICollectionView = UICollectionView.init(frame:CGRect.init(x: 0, y: self.headV.BottomY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.7), collectionViewLayout: layout)
        
        d.backgroundColor = UIColor.clear
        
        d.dataSource = self
        d.delegate = self
        
        d.register(CollectCell.self, forCellWithReuseIdentifier: "cellID")
        d.register(ReuseV.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headReuse")
        return d
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "钱包"
        UIApplication.shared.statusBarStyle = .default
        
        let rightItem = UIBarButtonItem.init(title: "说得对", style: .done, target: self, action: #selector(rightSEL(sender:)))
        rightItem.tintColor = UIColor.gray
        self.navigationItem.leftBarButtonItem = rightItem
     
        /// 头视图
        view.addSubview(headV)
        
        /// collectionView(扫一扫)
        view.addSubview(collV)
    }
    
    func rightSEL(sender : UIButton) -> Void {
        CCog(message: "")
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
}

extension MainPageViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CollectCell
        
        cell.descLabl.text = books[indexPath.section].images[indexPath.item]
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top:0, left: COMMON_MARGIN * SCREEN_SCALE, bottom: 0, right: COMMON_MARGIN * SCREEN_SCALE)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return sectionDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return books[section].images.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview:UICollectionReusableView!

        // 获取重用的分组头
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind:
            UICollectionElementKindSectionHeader, withReuseIdentifier: "headReuse",
                                                  for: indexPath) as? ReuseV {
            //设置分组标题
            header.titleLabel.text = books[indexPath.section].title
            return header
        }

        return reusableview
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
                /// 扫一扫
            case 0:
                
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(ViewController(), animated: true)
                }
                break
                /// 收款
            case 1:
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(ShouMoneyVC(), animated: true)
                }
                
                break
                /// 充值
            case 2:
                
                
                break
                /// 转账
            case 3 :
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(ReceiveMonVC(), animated: true)
                }
                break
            default:
                break
            }
            break
        default:
            break
        }
    }
    
    //返回分组头大小
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 45.0)
    }
}

class ReuseV : UICollectionReusableView {
    lazy var titleLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: 44))
        d.text = "说的"
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
