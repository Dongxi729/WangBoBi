//
//  TestViewController.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/17.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  http://blog.csdn.net/json_6/article/details/51890313

import UIKit

class MyBandCardVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var d : [String] = ["招商银行","农业银行"]
    
    
    fileprivate lazy var monY: UITableView = {
        let d : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: .grouped)
        d.delegate = self;
        d.dataSource = self;
        d.register(BandCardCell.self, forCellReuseIdentifier: "cellID")
        d.register(AddCardCell.self, forCellReuseIdentifier: "cardCell")
        
        d.tableFooterView = self.footerView
        return d
    }()
    
    // MARK: - 尾部视图
    lazy var footerView: FooterView = {
        let d : FooterView = FooterView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 80))
        return d
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(monY)
        title = "银行卡"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return d.count
        default:
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 120
        default:
            return 45
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! BandCardCell
        
        switch indexPath.section {
        case 0:
            
            cell.cardsName.text = d[indexPath.row]
            
            cell.frame = CGRect.init(x: 0, y: Int(cell.Height * CGFloat(indexPath.row)), width: Int(SCREEN_WIDTH), height: 100 * indexPath.row)
            
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as! AddCardCell
            return cell

        default:
            break
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.00001
        default:
            return COMMON_MARGIN
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            navigationController?.pushViewController(AddBankCardVC(), animated: true)
            break
        default:
            break
        }
    }
    
    // MARK: - 尾部代理方法
    func addCardsPage() {
        let vc = UIViewController.init()
        vc.view.backgroundColor = UIColor.red
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - 银行卡Cell
struct CardType {
    var cardsType : String?
}


class BandCardCell: UITableViewCell {
    
    
    
    var model = CardType()
    
    // MARK: - 银行图标
    fileprivate lazy var bankIcon: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: COMMON_MARGIN, width: 30 * SCREEN_SCALE, height: 30 * SCREEN_SCALE))
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.backgroundColor = UIColor.randomColor()
        return d
    }()
    
    // MARK: - 银行卡类型
    fileprivate lazy var cardsName: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.bankIcon.RightX + COMMON_MARGIN / 2, y: COMMON_MARGIN, width: self.Width - self.bankIcon.Width, height: 15 * SCREEN_SCALE))
        
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        
        
        /// 其他类型判别
        
        
        return d
    }()
    
    // MARK: - 银行卡名称
    fileprivate lazy var cardsType: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.cardsName.LeftX, y: self.cardsName.BottomY, width: self.cardsName.Width, height: self.cardsName.Height))
        d.font = UIFont.systemFont(ofSize: 12 * SCREEN_SCALE)
        return d
    }()
    
    fileprivate lazy var cardNum: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.cardsName.LeftX, y: self.cardsType.BottomY + COMMON_MARGIN, width: self.cardsName.Width, height: 15 * SCREEN_SCALE))
        d.text = "622392839202829282"
        d.font = UIFont(name: "SimHei", size: 12 * SCREEN_SCALE)
        
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
        
        contentView.addSubview(bankIcon)
        contentView.addSubview(cardsType)
        contentView.addSubview(cardsName)
        contentView.addSubview(cardNum)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }
}


// MARK: - 银行卡第二组视图
class AddCardCell: UITableViewCell {
    
    lazy var addICon: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: COMMON_MARGIN, y: self.bounds.midY - 10 * SCREEN_SCALE, width: 20 * SCREEN_SCALE, height: 20 * SCREEN_SCALE))
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.backgroundColor = UIColor.gray
        return d
    }()
    
    fileprivate lazy var btn: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: self.addICon.RightX + COMMON_MARGIN / 2 , y: self.bounds.midY - 7.5 * SCREEN_SCALE, width: self.Width - self.addICon.Width + COMMON_MARGIN, height: 15 * SCREEN_SCALE))
        
        d.text = "添加银行卡"
        
        return d
    }()
    
    fileprivate lazy var discolerImg: UIImageView = {
        let d : UIImageView = UIImageView.init(frame: CGRect.init(x: SCREEN_WIDTH - 20 * SCREEN_SCALE , y:self.bounds.midY - 10 * SCREEN_SCALE , width: 20 * SCREEN_SCALE , height: 20 * SCREEN_SCALE))
        d.image = #imageLiteral(resourceName: "home")
        d.contentMode = UIViewContentMode.scaleAspectFit
        d.layer.borderWidth = 1
        d.contentMode = UIViewContentMode.scaleAspectFit
        return d
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(addICon)
        contentView.addSubview(btn)
        contentView.addSubview(discolerImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 第二组视图
class FooterView : UIView {
    
    fileprivate lazy var quesLabel: UILabel = {
        let d : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.Width, height: self.Height))
        d.text = "常见问题"
        d.font = UIFont.init(name: "SimHei", size: 10 * SCREEN_SCALE)
        d.textAlignment = .center
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(quesLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
