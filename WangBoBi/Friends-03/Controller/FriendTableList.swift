//
//  FriendTableList.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/7/25.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  http://www.hangge.com/blog/cache/detail_751.html

import UIKit

class FriendTableList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView?
    
    var adHeaders:[String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表视图
        self.tableView = UITableView(frame:UIScreen.main.applicationFrame,
                                     style:.grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")
        self.view.addSubview(self.tableView!)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return adHeaders
    }
    
    //点击索引，移动TableView的组位置
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String,
                   at index: Int) -> Int {
        var tpIndex:Int = 0
        //遍历索引值
        for character in adHeaders{
            //判断索引值和组名称相等，返回组坐标
            if character == title{
                return tpIndex
            }
            tpIndex += 1
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return adHeaders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的头部
    func tableView(_ tableView:UITableView, titleForHeaderInSection
        section:Int)->String?
    {
        var headers =  self.adHeaders;
        return headers[section];
    }
    
    //设置分组尾部高度（不需要尾部，设0.0好像无效）
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        //为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "SwiftCell"
        //同一形式的单元格重复使用，在声明时已注册
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)
            as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        let secno = indexPath.section
        cell.textLabel?.text = self.adHeaders[secno]+String(indexPath.item)
        return cell
    }

}
