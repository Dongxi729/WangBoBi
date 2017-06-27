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
    
    // MARK: - 头部视图
    lazy var headV: HeadInfoView = {
        let d : HeadInfoView = HeadInfoView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (749 / 640)))
        return d
    }()
    
    /// 数据源
    var dataSource : [String] = ["扫一扫","收款","充值","转账"]
    
    
    /// reuse数据源
    var sectionDataSource : [String] = ["猜您喜欢","推荐商家","第三方提供服务"]
    
    //所有书籍数据
    fileprivate let books = [
        BookPreview(title: "五月新书", images: ["扫一扫","收款","充值","转账"]),
        BookPreview(title: "六月新书", images: ["7.jpg", "8.jpg"]),
        BookPreview(title: "六月新书", images: ["7.jpg", "8.jpg"]),
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
        let itemWidth = SCREEN_WIDTH / 4
        
        //设置单元格宽度和高度
        layout.itemSize = CGSize(width:itemWidth * 0.77, height:itemWidth * 0.55)
        
        
        layout.minimumLineSpacing = 10
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
        view.backgroundColor = UIColor.gray
    }
    
}

extension MainPageViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HeadReuseDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CollectCell
        
        cell.descLabl.text = books[indexPath.section].images[indexPath.item]
        return cell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top:0, left: COMMON_MARGIN * SCREEN_SCALE, bottom: 0, right: COMMON_MARGIN * SCREEN_SCALE)
    
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
            return header!
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind:
                UICollectionElementKindSectionHeader, withReuseIdentifier: "HeadInfoView",
                                                      for: indexPath) as? ReuseV
                  header?.titleLabel.text = books[indexPath.section].title
            return header!
        }
    }
    
    
    
    //返回分组头大小
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        if section == 0 {
            return CGSize.init(width: SCREEN_WIDTH, height: SCREEN_WIDTH * (749 / 640))
        } else {
            return CGSize.init(width: SCREEN_WIDTH, height: 45)
        }
    
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
            self.navigationController?.pushViewController(cc, animated: true)
            break
            /// 充值
        case 602:
            self.navigationController?.pushViewController(cc, animated: true)
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

/// 头部复用视图
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

/// 第一行头部视图
protocol HeadReuseDelegate {
    func chooseIndex(index : Int) -> Void
}

class HeadReuse : UICollectionReusableView {

    /// 网博币余额
    lazy var WBCLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.Height * 0.28, width: self.Width, height: 30 * SCREEN_SCALE))
        d.font = UIFont.systemFont(ofSize: 25 * SCREEN_SCALE)
        d.text = "6000"
        d.textAlignment = .center
        return d
    }()
    
    /// 网博币/人民币
    lazy var wbBToJp: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: self.Width * 0.173913043478261, y: self.Height * 0.42, width: self.Width * 0.3, height: 20 * SCREEN_SCALE))
        d.text = "网博币/人民币:"
        d.sizeToFit()
        d.layer.borderWidth = 1
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    /// 网博币/日币
    lazy var wbBToRp: UILabel = {
        let d: UILabel = UILabel.init(frame: CGRect.init(x: self.Width * 0.173913043478261, y: self.wbBToJp.BottomY + COMMON_MARGIN * 0.8 * SCREEN_SCALE, width: self.Width * 0.3, height: 20 * SCREEN_SCALE))
        d.text = "网博币/日币:"
        d.sizeToFit()
        d.layer.borderWidth = 1
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    /// 网博币/人民币转换后的
    lazy var convertWBCToR: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.wbBToJp.RightX , y: self.wbBToJp.TopY, width: self.Width * 0.4, height: self.wbBToJp.Height))
        d.font = UIFont.boldSystemFont(ofSize: 12 * SCREEN_SCALE)
        d.layer.borderWidth = 1
        d.text = "2000.0000"
        return d
    }()
    
    lazy var convertWBCToJ: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.wbBToRp.RightX , y: self.wbBToRp.TopY, width: self.Width * 0.4, height: self.wbBToRp.Height))
        d.font = UIFont.boldSystemFont(ofSize: 12 * SCREEN_SCALE)
        d.layer.borderWidth = 1
        d.text = "2000.0000"
        return d
    }()
    
    /// 头部背景图片
    fileprivate lazy var headBgImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (749 / 640)))
        d.image = #imageLiteral(resourceName: "main_Bar")
        return d
    }()
    
    
    // MARK: - 积分
    lazy var jifenLabel: UILabel = {
        let d:UILabel = UILabel.init(frame: CGRect.init(x: COMMON_MARGIN * 1.5, y: self.Height * 0.670093651942526, width: (SCREEN_WIDTH / 2 - 2 * COMMON_MARGIN), height: 20 * SCREEN_SCALE))
        d.text = "13077"
        d.textColor = UIColor.colorWithHexString("1693D9")
        d.textAlignment = .center
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    // MARK: - 交易量
    lazy var WBCSubmitCounts: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.jifenLabel.RightX + COMMON_MARGIN * 0.9, y: self.jifenLabel.TopY, width: self.jifenLabel.Width, height: self.jifenLabel.Height))
        d.textColor = UIColor.colorWithHexString("1693D9")
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        d.textAlignment = .center
        d.text = "6789876"
        return d
    }()


    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        let touchPoint: CGPoint? = touch?.location(in: self)
        print("\((touchPoint?.x)! / self.Width)==\((touchPoint?.y)! / self.Height)")
        let stringFloat = Int((touchPoint?.x)!)
        let stringFloat1 = Int((touchPoint?.y)!)
        print("\(stringFloat)\(stringFloat1)")
    }
    
    var buttons : UIButton!
    
    var delegate : HeadReuseDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headBgImg)
        
        let tag = 600
        for index in 0..<4 {
            self.buttons = UIButton.init(frame: CGRect.init(x: CGFloat(index) * self.Width / 4, y: self.Height * 0.8, width: self.Width / 4 , height: self.Height * 0.2))
//            self.buttons.backgroundColor = UIColor.randomColor()
            self.buttons.tag = tag + index
            self.buttons.addTarget(self, action: #selector(buttonSEL(sender:)), for: .touchUpInside)
            addSubview(buttons)
        }
        
        
        addSubview(WBCLabel)
        addSubview(wbBToJp)
        addSubview(wbBToRp)
        addSubview(convertWBCToR)
        addSubview(convertWBCToJ)
        
        addSubview(jifenLabel)
        addSubview(WBCSubmitCounts)
    }
    
    @objc fileprivate func buttonSEL(sender : UIButton) {
        self.delegate?.chooseIndex(index: sender.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
