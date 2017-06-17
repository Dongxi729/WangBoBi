//
//  BandCardsViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/17.
//  Copyright © 2017年 郑东喜. All rights reserved.
//

import UIKit

class BandCardsViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let d : UIScrollView = UIScrollView.init(frame: self.view.bounds)
        return d
    }()

    var dataSource : [String] = ["说得对","说得对","说得对","说得对","说得对","说得对","说得对","说得对","说得对","说得对","说得对","说得对"]
    
    var d : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        var index = 0
        for value in dataSource {
            d = UIView.init(frame: CGRect.init(x: COMMON_MARGIN, y: CGFloat(100 * index) + CGFloat(5 * index), width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: CGFloat(100)))
            d.backgroundColor = UIColor.randomColor()
            scrollView.addSubview(d)
            
            if index == dataSource.count - 1 {
                let d = UIView.init(frame: CGRect.init(x: COMMON_MARGIN, y: CGFloat(100 * index) + CGFloat(5 * index), width: SCREEN_WIDTH - 2 * COMMON_MARGIN, height: CGFloat(50)))
                d.backgroundColor = UIColor.red
                scrollView.addSubview(d)
            }
            
            index += 1
        }
        scrollView.contentSize = CGSize.init(width: SCREEN_WIDTH, height: CGFloat(dataSource.count * (100 + 5)) + 20)
    }
}

