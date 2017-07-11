//
//  MainPageViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/15.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  首页

import UIKit

class MainPageViewController: BaseViewController {
    
    /// 九宫格
    lazy var collV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        
        /// 设置大小出错///
        let d : UICollectionView = UICollectionView.init(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), collectionViewLayout: layout)
        
        d.backgroundColor = UIColor.clear
        
        d.dataSource = self
        d.delegate = self
        
        
        d.register(CollectCell.self, forCellWithReuseIdentifier: "cellID")
        d.register(MainHeadCell.self, forCellWithReuseIdentifier: "headCell")
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
    
    lazy var replaceV: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        d.backgroundColor = UIColor.colorWithHexString("2693DA")
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "钱包"
        
        view.addSubview(collV)
        view.backgroundColor = COMMON_TBBGCOLOR
        
        /// 模型取值
        AccountModel.indexInfo(finished: { (commenModel) in
            self.topModel = commenModel
            
        }, finishedTop: { (merTopModel) in
            self.mertopModel = merTopModel
        }) { (xxx) in
            self.loginModel = xxx
            CCog(message: xxx)
            self.collV.reloadData()
        }
        
        /// 添加刷新控件
        self.collV.addHeaderViewfun()
        let d : headerView = collV.viewWithTag(888) as! headerView
        d.delegate = self;
        
        /// 将过度视图插入到导航栏之下
        view.insertSubview(replaceV, aboveSubview: (self.navigationController?.navigationBar)!)
        
        replaceV.alpha = 0
        
    }
}

extension MainPageViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HeadReuseDelegate,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //计算单元格的宽度
        let itemWidth = SCREEN_WIDTH / 3.5
        
        if indexPath.section == 0 {
            return CGSize.init(width: itemWidth, height: itemWidth * 1.4)
        } else {
            return CGSize.init(width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: itemWidth * 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CollectCell
            
            let xxx = mertopModel[indexPath.row]
            cell.dataSource2 = xxx
            cell.topView.setLabelNo(str: "TOP" + String(indexPath.row))
            
            return cell
        } else {
            let ccc = collectionView.dequeueReusableCell(withReuseIdentifier: "headCell", for: indexPath) as! MainHeadCell
            
            ccc.dataSource = topModel[indexPath.row]
            
            return ccc
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top:0, left: COMMON_MARGIN, bottom: 0, right:COMMON_MARGIN)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.mertopModel.count
        case 1:
            return self.topModel.count
        default:
            
            return 0
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
        
        if indexPath.section == 1 {
            let xxx2 = topModel[indexPath.row]
            
            let webVIew = WKVC()
            webVIew.url = xxx2.Href
            UIApplication.shared.statusBarStyle = .default
            
            let ccc = UIViewController()
            ccc.view.backgroundColor = UIColor.white
            
            self.navigationController?.pushViewController(webVIew, animated: true)
        }
    }
    
    
    // MARK: - HeadReuseDelegate
    func chooseIndex(index: Int) {
        
        switch index {
        /// 扫一扫
        case 600:
            self.navigationController?.pushViewController(ScanCodeController(), animated: true)
            break
        /// 首付款
        case 601:
            self.navigationController?.pushViewController(GetMoneyScanVC(), animated: true)
            break
        /// 充值
        case 602:
            self.navigationController?.pushViewController(PushingMoneyVC(), animated: true)
            break
        /// 转账
        case 603:
            self.navigationController?.pushViewController(ReceiveMonVC(), animated: true)
            break
        default:
            break
        }
    }
    
}

// MARK: - 刷新控件
extension MainPageViewController : headerViewelegate {
    func headerViewEndfun(_ _endRefresh: () -> Void) {
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        /// 取出刷新头
        let d : headerView = self.collV.viewWithTag(888) as! headerView
        
        AccountModel.indexInfo(finished: { (commenModel) in
            self.topModel = commenModel
            
        }, finishedTop: { (merTopModel) in
            self.mertopModel = merTopModel
            
        }) { (xxx) in
            self.loginModel = xxx
            
            self.collV.reloadData()
            d.endRefresh()
        }
    }
    
}

// MARK: - 监听滑动距离将过度视图补充
extension  MainPageViewController: UITableViewDelegate {
    
    //MARK:UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY > 100 {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.replaceV.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.replaceV.alpha = 0
            })
        }
    }
    
}
