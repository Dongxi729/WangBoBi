//
//  TestViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/17.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  http://blog.csdn.net/json_6/article/details/51890313

import UIKit

class TestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var d : [String] = ["sdsad","sdsd","sdsad","sdsd","sdsad","sdsd","sdsad","sdsd","sdsad","sdsd"]
    
    lazy var monY: UITableView = {
        let d : UITableView = UITableView.init(frame: self.view.bounds)
        d.delegate = self;
        d.dataSource = self;
        d.register(CCCryptor.self, forCellReuseIdentifier: "cellID")
        
        d.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: -10, right: -10)
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(monY)
        
        
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return d.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! CCCryptor
        cell.textLabel?.text = d[indexPath.row]
        
        cell.frame = CGRect.init(x: 0, y: Int(cell.Height * CGFloat(indexPath.row)), width: Int(SCREEN_WIDTH), height: 100 * indexPath.row)

        return cell
    }

}


class CCCryptor: UITableViewCell {
    
    
    override var frame:CGRect{
        didSet {
            
            var newFrame = frame
            newFrame.origin.x += 10/2
            newFrame.size.width -= 10
            newFrame.origin.y += 10
            newFrame.size.height -= 10
            super.frame = newFrame
            
            
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        
        //去除高亮效果
        self.selectionStyle = .none
        
      
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

        
        
        CCog(message: "")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }
    
    
 
    
}
