//
//  MainViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/13.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class MainViewController: ViewController,UITableViewDelegate,UITableViewDataSource {
    
    var str : [String] = ["成功","失败","提示","正常toast"]

    
    lazy var tbv: UITableView = {
        let d : UITableView = UITableView.init(frame: self.view.bounds)
        
        d.delegate = self;
        d.dataSource = self;
        d.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return d
    }()
    
    lazy var cameraBtn: UIButton = {
        let d : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        d.backgroundColor = UIColor.gray
        d.addTarget(self, action: #selector(cameraSEl), for: .touchUpInside)
        
        return d
    }()

    
    lazy var img: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: 100, y: 100, width: self.view.bounds.midX, height: self.view.bounds.midY))
        d.backgroundColor = UIColor.red
        d.setAvatarImage(urlString: "https://www.google.co.jp/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png", placeholderImage: #imageLiteral(resourceName: "replaceImg.png"))
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(cameraBtn)
        
        view.addSubview(tbv)
        
        view.addSubview(img)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        FTIndicator.showToastMessage("asdsa")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return str.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = str[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            
            break
        case 1:
            
            break
        case 2:
            
            break
        case 3:
//            FTIndicator.showSuccess(withMessage: "asdsd")
            
            break
        default:
            break
        }
    }
}
