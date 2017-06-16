//
//  DetailViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/16.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  账单也没

import UIKit

class DetailViewController: UIViewController {

    /// 表格
    fileprivate lazy var tbV: UITableView = {
        let d : UITableView = UITableView.init(frame: self.view.bounds)
        d.delegate = self;
        d.dataSource = self;
        d.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        return d
    }()
    
    var detailSource : [String] = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.tbV.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "账单"
        
        view.addSubview(tbV)
        
        detailSource = ["asdsa","asds","asdsa","asds","asdsa","asds","asdsa","asds","asdsa","asds","asdsa","asds","asdsa","asds","asdsa","asds","asdsa","asds","asdsa","asds"]
    }
}


extension DetailViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        cell?.textLabel?.text = detailSource[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "2月"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailSource.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let d : tbVHead = tbVHead.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        return d
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 100
            
        default:
            break
        }
        
        return 0
    }
    
}

class tbVHead : UIView {
    lazy var leb: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: 30))
        d.text = "艾斯德斯多撒多撒多"
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(leb)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
