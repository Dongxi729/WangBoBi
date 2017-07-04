//
//  MainPageViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  首页

import UIKit

class MainPageViewController: BaseViewController {
    
    @objc fileprivate func refreshSEL(sender : UIRefreshControl) {
        CCog(message: "refreshSEL")
        
        AccountModel.indexInfo(finished: { (commenModel) in
            self.topModel = commenModel
            
            CCog(message: commenModel.count)
        }, finishedTop: { (merTopModel) in
            self.mertopModel = merTopModel
            CCog(message: merTopModel.count)
        }) { (xxx) in
            self.loginModel = xxx
            CCog(message: xxx)
            
            sleep(UInt32(2.0))
            self.collV.reloadData()
            sender.endRefreshing()
        }
        

    }
    
    /// 九宫格
    lazy var collV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        
        //列数
        let columnsNum = 3
        
        //整个view的宽度
        let collectionViewWidth = SCREEN_BOUNDS
        
        //计算单元格的宽度
        let itemWidth = SCREEN_WIDTH / 3.5
        
        //设置单元格宽度和高度
        layout.itemSize = CGSize(width:itemWidth, height:itemWidth * 1.4)
        layout.minimumLineSpacing = COMMON_MARGIN
        layout.minimumInteritemSpacing = COMMON_MARGIN
        
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
    
    /// 热评商户
    var mertopModel = [IndexMertopModel]()
    
    /// 头条推荐
    var topModel = [IndexCommentTopModel]()
    
    /// 模型总数
    var loginModel : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "钱包"
        
        view.addSubview(collV)
        view.backgroundColor = COMMON_TBBGCOLOR
        
        AccountModel.indexInfo(finished: { (commenModel) in
            self.topModel = commenModel

            CCog(message: commenModel.count)
        }, finishedTop: { (merTopModel) in
            self.mertopModel = merTopModel
            CCog(message: merTopModel.count)
        }) { (xxx) in
            self.loginModel = xxx
            CCog(message: xxx)
            self.collV.reloadData()
        }
        self.collV.addHeaderViewfun()
        let d : headerView = collV.viewWithTag(888) as! headerView
        d.delegate = self;
        

    }
    
    static let shared = MainPageViewController()

}

extension MainPageViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HeadReuseDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CollectCell
        
        if indexPath.section == 0 {
            
            let xxx = mertopModel[indexPath.row]
            cell.dataSource2 = xxx
            
            cell.topView.isHidden = true
        } else {
            let xxx2 = topModel[indexPath.row]
            cell.dataSource = xxx2
            cell.topView.setLabelNo(str: "TOP" + String(indexPath.row))
        }

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top:0, left: COMMON_MARGIN, bottom: 0, right:COMMON_MARGIN)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return loginModel - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.mertopModel.count
        default:
            return self.topModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind:
                UICollectionElementKindSectionHeader, withReuseIdentifier: "headReuse",
                                                      for: indexPath) as? HeadReuse
            header?.delegate = self
            header?.sectionImg.setTitle("热评商户", for: .normal)
            header?.sectionImg.setImage(#imageLiteral(resourceName: "hot"), for: .normal)
            header?.sectionImg.sizeToFit()
            return header!
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind:
                UICollectionElementKindSectionHeader, withReuseIdentifier: "HeadInfoView",
                                                      for: indexPath) as? ReuseV
            header?.sectionImg.setTitle("头条推荐", for: .normal)
            header?.sectionImg.setImage(#imageLiteral(resourceName: "suggest"), for: .normal)
            return header!
        }
    }
    
    //返回头部间距
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        if section == 0 {
            return CGSize.init(width: SCREEN_WIDTH, height: SCREEN_WIDTH * (749 / 640) + SCREEN_WIDTH *  (309 / 640) + 30 * SCREEN_SCALE)
        } else {
            return CGSize.init(width: SCREEN_WIDTH, height: 30 * SCREEN_SCALE)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize.init(width: SCREEN_WIDTH, height: COMMON_MARGIN)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.section == 0 {

        } else {
            let xxx2 = topModel[indexPath.row]
            
            let webVIew = WebVC()
            webVIew.url = xxx2.Href
            self.navigationController?.pushViewController(webVIew, animated: true)
            webVIew.view.backgroundColor = UIColor.white
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

// MARK: - 刷新控件
extension MainPageViewController : headerViewelegate {
    func headerViewEndfun(_ _endRefresh: () -> Void) {
        
        /// 取出刷新头
        let d : headerView = self.collV.viewWithTag(888) as! headerView
        
        AccountModel.indexInfo(finished: { (commenModel) in
            self.topModel = commenModel
            
            CCog(message: commenModel.count)
        }, finishedTop: { (merTopModel) in
            self.mertopModel = merTopModel
            CCog(message: merTopModel.count)
        }) { (xxx) in
            self.loginModel = xxx
            CCog(message: xxx)

            self.collV.reloadData()
            d.endRefresh()
        }
    }
}

