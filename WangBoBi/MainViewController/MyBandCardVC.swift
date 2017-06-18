//
//  TestViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/17.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  http://blog.csdn.net/json_6/article/details/51890313

import UIKit

class MyBandCardVC: UIViewController,UITableViewDelegate,UITableViewDataSource,FooterVDelegate {
    
    var d : [String] = ["招商银行","农业银行"]
    
    
    lazy var monY: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        d.delegate = self;
        d.dataSource = self;
        d.register(BandCardCell.self, forCellReuseIdentifier: "cellID")
        
        d.tableFooterView = self.fV
        return d
    }()
    
    lazy var fV: FooterV = {
        let d : FooterV = FooterV.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        d.backgroundColor = UIColor.red
        d.delegate = self
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(monY)
        title = "银行卡"
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return d.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! BandCardCell
        cell.cardsName.text = d[indexPath.row]
        
        cell.frame = CGRect.init(x: 0, y: Int(cell.Height * CGFloat(indexPath.row)), width: Int(SCREEN_WIDTH), height: 100 * indexPath.row)

        return cell
    }

    
    // MARK: - 尾部代理方法
    func addCardsPage() {
        let vc = UIViewController.init()
        vc.view.backgroundColor = UIColor.red
        navigationController?.pushViewController(vc, animated: true)
    }

}

struct CardType {
    var cardsType : String?
}

// MARK: - 银行卡Cell
class BandCardCell: UITableViewCell {
    
    var model = CardType()
    
    // MARK: - 银行图标
    lazy var bankIcon: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: 30 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.backgroundColor = UIColor.randomColor()
        return d
    }()
    
    // MARK: - 银行卡类型
    lazy var cardsName: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.bankIcon.RightX + COMMON_MARGIN / 2, y: COMMON_MARGIN, width: self.Width - self.bankIcon.Width, height: 15 * SCREEN_SCALE))

        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        
        
        /// 其他类型判别
        
        
        return d
    }()
    
    // MARK: - 银行卡名称
    lazy var cardsType: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.cardsName.LeftX, y: self.cardsName.BottomY, width: self.cardsName.Width, height: self.cardsName.Height))
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()

    lazy var cardNum: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.cardsName.LeftX, y: self.cardsType.BottomY + COMMON_MARGIN, width: self.cardsName.Width, height: 15 * SCREEN_SCALE))
        d.text = "622392839202829282"
        
        return d
    }()
    
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
        
        model = CardType.init(cardsType: "存储卡")
        cardsType.text = model.cardsType
        
        cardNum.text = cardNum.text?.replaceIndexStr(replaceStr: cardNum.text!, replaceLength: 13, replaceStr: "**** **** **** ")
        
        //去除高亮效果
        self.selectionStyle = .none
        
        addSubview(bankIcon)
        addSubview(cardsType)
        addSubview(cardsName)
        addSubview(cardNum)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }
}


// MARK: - 银行卡尾视图

protocol FooterVDelegate {
    func addCardsPage() -> Void
}

class FooterV: UIView {
    
    var delegate : FooterVDelegate?
    
    fileprivate lazy var btn: UIButton = {
        let d : UIButton = UIButton.init(frame: self.bounds)
        d.setTitle("添加银行卡", for: .normal)
        d.setTitleColor(UIColor.red, for: .normal)
        d.addTarget(self, action: #selector(addCardsSEL(sender:)), for: .touchUpInside)
        return d
    }()
    
    @objc fileprivate func addCardsSEL(sender : UIButton) -> Void {
        CCog(message: "添加银行卡")
        self.delegate?.addCardsPage()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
