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
        let d : UICollectionView = UICollectionView.init(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), collectionViewLayout: layout)
        
        d.backgroundColor = UIColor.clear
        
        d.dataSource = self
        d.delegate = self
        
        
        d.register(CollectCell.self, forCellWithReuseIdentifier: "cellID")
        d.register(MainHeadCell.self, forCellWithReuseIdentifier: "headCell")
        d.register(ReuseV.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeadInfoView")
        d.register(HeadReuse.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headReuse")
        
        d.showsVerticalScrollIndicator = false
        return d
    }()
    
    /// 热评商户
    var mertopModel = [IndexMertopModel]()
    
    /// 头条推荐
    var topModel = [IndexCommentTopModel]()
    
    /// 模型总数
    var loginModel : Int = 0
    
    
    
    /// 导航栏遮罩视图
    lazy var replaceV: UIView = {
        let d : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        d.backgroundColor = UIColor.colorWithHexString("2693DA")
        return d
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        /// 测试 一进来刷新信息
//        AccountModel.reloadSEL()  
    }
   
    /// 账单
    lazy var detailList: UIBarButtonItem = {
        let d : UIBarButtonItem = UIBarButtonItem.init(title: "账单", style: .plain, target: self, action: #selector(jumpToDetailVC))
        
        return d
    }()

    /// 日币汇率
    var janRate : Int = 0
    
    /// 人民币汇率
    var chiRate : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AccountModel.afterLogin(finished: { (commenModel) in
            self.topModel = commenModel
        }, finishedTop: { (merTopModel) in
            self.mertopModel = merTopModel
        }, finishedTotalModel: { (sectionCount) in
            self.loginModel = sectionCount
            self.collV.reloadData()
        }, chineseRate: { (ee) in
            ///
            self.chiRate = ee
            
        }) { (ff) in
            ///
            self.janRate = ff
        }
        
        /// 添加刷新控件
        self.collV.addHeaderViewfun()
        ///  头部视图
        let d : headerView = collV.viewWithTag(888) as! headerView
        d.delegate = self;
        self.title = "钱包"
        
        view.addSubview(collV)
        
        /// 添加导航栏渐变视图
        view.addSubview(replaceV)
        replaceV.alpha = 0
        
        // Do any additional setup after loading the view.
        view.backgroundColor = COMMON_TBBGCOLOR

        // 账单
        self.navigationItem.rightBarButtonItem = detailList
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }

    
    /// 账单
    @objc fileprivate func jumpToDetailVC() {
        let v : UIViewController = DetailVC()
        self.navigationController?.pushViewController(v, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MainPageViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HeadReuseDelegate,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //计算单元格的宽度
        let itemWidth = SCREEN_WIDTH / 3.5
        
        if indexPath.section == 0 {
            return CGSize.init(width: itemWidth, height: itemWidth * 1.4)
        } else {
            return CGSize.init(width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: itemWidth * 1.8)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CollectCell
            
            let xxx = mertopModel[indexPath.row]
            cell.dataSource2 = xxx
            cell.topView.setLabelNo(str: "TOP" + String(indexPath.row + 1))
            
            
            return cell
        } else {
            let ccc = collectionView.dequeueReusableCell(withReuseIdentifier: "headCell", for: indexPath) as! MainHeadCell
            
            ccc.dataSource = topModel[indexPath.row]
            
            return ccc
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top:0, left: COMMON_MARGIN, bottom: COMMON_MARGIN, right:COMMON_MARGIN)
    }
    
    /// 返回几行
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    /// 返回每行对应的数量
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

            header?.convertWBCToR.text = String(Double((AccountModel.shared()?.WBC)!)! * Double(chiRate))

            header?.convertWBCToJ.text = String(Double((AccountModel.shared()?.WBC)!)! * Double(janRate))

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
        
        /// 网页跳转
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
    
    
    // MARK: - 四个索引图标
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
extension MainPageViewController : headerViewelegate,footerViewelegate {
    func headerViewEndfun(_ _endRefresh: () -> Void) {
    
        UIApplication.shared.statusBarStyle = .lightContent
        
        /// 取出刷新头
        let d : headerView = self.collV.viewWithTag(888) as! headerView
        
        /// 有网络、没网络处理
        NetCheck.shared.returnNetStatus { (result) in
            
            if result {

//                AccountModel.indexInfo(finished: { (commenModel) in
//                    self.topModel = commenModel
//                    
//                }, finishedTop: { (merTopModel) in
//                    self.mertopModel = merTopModel
//                    
//                }) { (xxx) in
//                    self.loginModel = xxx
//                    
//                    self.collV.reloadData()
//                    
//                    toast(toast: "刷新成功")
//                }
                
                
                AccountModel.indexInfo(finished: { (commenModel) in
                    self.topModel = commenModel
                }, finishedTop: { (merTopModel) in
                    self.mertopModel = merTopModel
                }, finishedTotalModel: { (xxx) in
                    self.loginModel = xxx
                    self.loginModel = xxx
                    
                    self.collV.reloadData()
                    
                    toast(toast: "刷新成功")
                }, chineseRate: { (chinese) in
                    
                }, janRate: { (jpanRate) in
                    
                })
                
                d.endRefresh()
            } else {
                d.endRefresh()
                
                toast(toast: "似乎已断开与互联网的连接")
                return
            }
        }
        
        AccountModel.reloadSEL()
    }
    
    /// 尾部刷新
    func footerViewEndfun(_ _endRefresh: () -> Void) {
        CCog(message: "尾部刷新")
    }
}

// MARK: - 监听滑动距离将过度视图补充
extension  MainPageViewController: UITableViewDelegate {
    
    //MARK:UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY > 0 {
            
            UIView.animate(withDuration: 1.0, animations: {
                self.replaceV.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 1.0, animations: {
                self.replaceV.alpha = 0
            })
        }
    }
    
}
