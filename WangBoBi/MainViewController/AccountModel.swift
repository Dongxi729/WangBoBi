//
//  AccountModel.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/21.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  用户信息模型


//public static String userId = "";
////帐号
//public static String userpassword = "";
////密码
//public static String userToker = "";
////唯一的 token
//public static String userName = "";
////姓名
//public static String userImghead = "";
////头像地址
//public static String userWallet = "";
////钱包地址
//
//public static String userQRcode = "";
////加好友的二维码
//
//public static String user_Pay_QRcode = "";
////付款二维码id  暂无
//
//public static String user_Collect_QRcode = "";
////收款二维码id
//
//public static int realNameInt= 0;
////是否实名认证 0 未认证 1 审核中，2认证失败 3认证成功
//
//public static boolean realDoubleBoo = false;
////是否双重认证
//
//public static boolean payPasswordBoo = false;
////是否设置过支付密码
//
//public static boolean phoneBoo = false;
////是否绑定了手机号
//
//
//public static int WBC = 0;
////网博币
//
//public static Float JP = 0.0f;
////和日币的比例
//
//public static Float CP = 0.0f;
////和人民币的比例
//
//public static int JF = 0;
////积分
//
//public static Float Trading = 0.0f;
//交易量
//({
//    AcctType = "<null>";
//    AdressCopy = "";
//    BirthDate = "";
//    ContractCopy = "";
//    Credential = "";
//    CredentialCopy = "";
//    Email = "946737816@qq.com";
//    ExpiryDate = "";
//    Financed = "";
//    FrinQCode = "wbf://e9b001fc-7891-48b1-9600-f99a3c507231";
//    HeadImg = "http://192.168.1.10:8010/images/logo.jpg";
//    Id = 6;
//    Integral = 0;
//    IssueDate = "";
//    Nationality = "";
//    OpenedDate = "2017-06-27";
//    PayQCode = "wbp://0ea29461-85be-41ca-8bee-6e115ef2d45c";
//    Phone = "";
//    Profession = "";
//    Referee = "";
//    Remark = "";
//    ResidenceAdress = "";
//    SIMCardNo = "";
//    SelfieCopy = "";
//    Sex = "";
//    SubmitTime = "2017-06-27T16:18:42";
//    Token = 82fc33ad885742bdb917873eab438089;
//    TraderPass = "";
//    TraderStatus = "<null>";
//    TrueName = "";
//    UserName = "946737816@qq.com";
//    UserPass = e10adc3949ba59abbe56e057f20f883e;
//    VerifiStatus = 0;
//    WBC = "0.000000";
//    WBCAdress = WecT9nJx8xMkJxFK3idsdDYG1upYzUBZNT;
//    WorkingAdress = "";
//    YearlySalary = "";
//})


import UIKit


/// 交易状态http://192.168.1.10:8010/images/logo.jpg
///
/// - loingOncePass: 每次登录只输入一次交易密码
/// - tracWithPass: 每笔交易都输入交易密码
/// - traceWithOutPass: 每次交易都不需要输入交易密码
enum TraderStatus :Int {
    case loingOncePass = 0,tracWithPass,traceWithOutPass
}

/// 性别
///
/// - male: 男
/// - female: 女
enum SEXEnum : Int {
    case male = 0,female
}

/// 证件类型
///
/// - passport: 护照
/// - IDCard: 身份证
enum CredentialEnum : Int {
    case passport = 0,IDCard
}

/// 矿机型号
///
/// - typeOne: 矿机1
/// - typeTwo: 矿机2
/// - typeThree: 矿机3
enum OreMachineEnum : Int {
    case typeOne = 0,typeTwo,typeThree
}

/// 职业
///
/// - Hired: 受雇人员
/// - Hiring: 自雇人员
/// - student: 学生
/// - retired: 退休
/// - other: 其他
enum ProfessionEnum : Int {
    case Hired = 0,Hiring,student,retired,other = -1
}

/// 资金来源
///
/// - wage: 工资
/// - Savings: 存储
/// - heritage: 遗产
/// - other: 其他
enum FinancedEnum : Int {
    case wage = 1,Savings,heritage,other = 0
}

/// 会员类型
///
/// - staff: 离职
/// - GeneralAgent: 总代理商
enum AcctTypeEnum : Int {
    case staff = 0,GeneralAgent
}

/// 认证状态
///
/// - unNamed: 未认证
/// - authing: 审核中
/// - auhFailed: 认证失败
/// - authSuccess: 认证成功
enum realNameIntEnum : Int {
    case unNamed = 0,authing,auhFailed,authSuccess
}

/// 添加朋友方式
///
/// - scan: 扫描
/// - search: 搜索
/// - add: 添加
enum addFriendType : Int {
    case scan = 0,search,add,rmk,acpt
}


class AccountModel: NSObject,NSCoding {
    
    /// 账号
    var userId : String?
    
    /// 密码
    var userpassword : String?
    
    /// 唯一的 token
    var userToker : String?
    
    /// 头像地址
    var userImghead : String?
    
    /// 钱包地址
    var userWallet : String?
    
    /// 加好友用户二维码
    var userQRcode : String?
    
    ///     //付款二维码id  暂无
    var user_Pay_QRcode : String?
    
    /// 收款二维码id
    var user_Collect_QRcode : String?
    
    /// 是否实名认证 0 未认证 1 审核中，2认证失败 3认证成功
    var realNameInt : realNameIntEnum?
    
    /// /是否双重认证
    var realDoubleBoo : Bool?
    
    /// 是否设置过支付密码
    var payPasswordBoo : Bool?
    
    /// 是否绑定了手机号
    var phoneBoo : Bool?
    
    /// 网博币
    var WBC : String?
    
    /// 和日币的比例
    var JP : Int?
    
    /// 和人民币的比例
    var CP : Int?
    
    /// 积分
    var JF : NSNumber?
    
    /// /交易量
    var Trading : CGFloat?
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //// 记录输入信息
    /// 昵称
    var nickName : String = ""
    
    
    
    /// 验证码
    var autoCode : String = ""
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /// 令牌
    var Token : String?
    
    /// var 用户ID
    var Id : NSNumber = 0
    
    /// 开户日期
    var OpenedDate : String?
    
    /// 用户名
    var UserName : String?
    
    /// 用户密码
    var UserPass : String?
    
    /// 头像地址
    var HeadImg :String?
    
    /// https://stackoverflow.com/questions/36154590/how-to-encode-int-as-an-optional-using-nscoding
    /// 积分
    var Integral : NSNumber = 0
    
    /// 认证状态
    var VerifiStatus : NSNumber = 0
    
    /// 我的二维码地址(加好友)
    var FrinQCode : String?
    
    /// 收款二维码地址
    var PayQCode : String?
    
    /// 交易密码
    var TraderPass : String?
    
    /// 交易状态
    var TraderStatus : TraderStatus?
    
    /// 姓名
    var TrueName : String?
    
    /// 性别
    var Sex : SEXEnum?
    
    /// 国籍
    var Nationality : String?
    
    /// 出生年月
    var BirthDate : String?
    
    /// 证件
    var Credential : CredentialEnum?
    
    /// ID签发日期
    var IssueDate : String?
    
    /// ID有效期
    var ExpiryDate : String?
    
    /// 单位地址
    var WorkingAdress : String?
    
    
    /// 居住地址
    var ResidenceAdress : String?
    
    /// 邮箱
    var Email : String?
    
    /// 手机号码
    var Phone : String?
    
    /// 开户推荐人ID
    var Referee : String?
    
    /// 矿机型号
    var OreMachine : OreMachineEnum?
    
    /// SIM card 号码
    var SIMCardNo : String?
    
    /// 备注
    var Remark : String?
    
    /// 职业
    var Profession : ProfessionEnum?
    
    /// 资金来源
    var Financed : FinancedEnum?
    
    /// 年薪
    var YearlySalary : String?
    
    /// 合同副本
    var ContractCopy : String?
    
    /// 身份证明文件／护照
    var CredentialCopy : String?
    
    /// 一张手持政府签发有效证件的自拍照
    var SelfieCopy : String?
    
    /// 住址证明文件
    var AdressCopy : String?
    
    /// 总代理商
    var AcctType : AcctTypeEnum?
    
    /// 网博币钱包地址
    var WBCAdress : String?
    
    /// 提交时间 http://www.hangge.com/blog/cache/detail_1198.html#
    var SubmitTime : String?
    
    
    // KVC 字典转模型
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
    // 持久保存到内存中
    fileprivate static var userAccount: AccountModel?
    
    // 归档账号的路径
    static let accountPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! + "/Account.plist"
    
    // 首页数据保存
    static let userData = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! + "/Data.plist"
    
    // MARK: - 保存对象
    func saveAccount() {
        
        NSKeyedArchiver.archiveRootObject(self, toFile: AccountModel.accountPath)
    }
    
    /// 登录操作
    func loginSEL() {
        DispatchQueue.main.async {
            
            AccountModel.logout()
            
            
            /// 清空链接数组
            SHOP_URLArray.removeAllObjects()
            
            let alertConte = UIAlertController.init(title: "友情提示", message: "您的账号在异地登录，请重新登录或者修改密码！", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction.init(title: "好的", style: .default, handler: { (alert) in
                var nav = LoginNav()
                nav = LoginNav.init(rootViewController: LoginViewController())
                
                UIApplication.shared.keyWindow?.rootViewController = nav
            })
            
            alertConte.addAction(okAction)
            
            UIApplication.shared.keyWindow?.rootViewController?.present(alertConte, animated: true, completion: nil)
        }
    }
    
    /// 登录保存
    func updateUserInfo() -> Void {
        AccountModel.userAccount = self
        // 归档用户信息
        saveAccount()
    }
    
    // MARK: - 是否登录
    class func isLogin() -> Bool {
        return AccountModel.shared() != nil
    }
    
    // MARK: - 退出接口
    func logout() -> Void {
        // 清楚内存中的账号对象和归档
        AccountModel.userAccount = nil
        
        do {
            try FileManager.default.removeItem(atPath: AccountModel.accountPath)
        } catch {
            CCog(message: "退出异常")
        }
    }
    
    /**
     注销清理
     */
    class func logout() {
        
        SHOP_URLArray.removeAllObjects()
        
        // 清除内存中的账号对象和归档
        AccountModel.userAccount = nil
        do {
            try FileManager.default.removeItem(atPath: AccountModel.accountPath)
        } catch {
            CCog(message: "退出异常")
        }
    }
    
    // MARK: - 登录
    /// 登录接口
    ///
    /// - Parameters:
    ///   - emailStr: 邮箱地址
    ///   - pass: 密码
    class func getInfo(emailStr : String,pass : String) -> Void {
        
        CCog(message: pass.md5())
        let param = ["email" : emailStr,"pwd" : pass.md5()]
        
        CCog(message: param)
        
        /// 返回数据
        NetWorkTool.shared.postWithPath(path: LOGIN_URL, paras: param, success: { (result) in
            CCog(message: result)
            
            guard let resultData = result as? NSDictionary else {
                
                CCog(message: "登录信息无效")
                return
            }
            
            guard let alertMsg = resultData["Msg"] as? String else {
                return
            }
            
            toast(toast: alertMsg)
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            guard let dataJson = resultData["Data"] as? NSArray else {
                return
            }
            
            if dataJson.count > 0 {
                guard let account = (resultData["Data"] as! NSArray)[0] as? [String : Any] else {
                    return
                }
                
                guard var fourSecData = (resultData["Data"] as! NSArray)[1] as? [String : Any] else {
                    return
                }
                
                for (key,value) in account {
                    fourSecData[key] = value
                }
                
                /// 更新本地存储信息
                let accountInfo = AccountModel(dict: fourSecData)
                accountInfo.saveAccount()
                guard let alertMsg = resultData["Msg"] as? String else {
                    return
                }
                
                if alertMsg == "登陆成功" {
                    
                    /// 记录登录时间
                    let now = Date()
                    let timerStamp : TimeInterval = now.timeIntervalSince1970
                    
                    let timeStamp = Int(timerStamp)
                    
                    /// 记录本地登录成功的时间/更新
                    UserDefaults.standard.set(timeStamp, forKey: "loginTime")
                    UserDefaults.standard.synchronize()
                    
                    // 设置全局颜色
                    UITabBar.appearance().tintColor = TABBAR_BGCOLOR
                    UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
                    
                } else {
                    toast(toast: alertMsg)
                }
            }
            
            
            
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    
    // MARK: - 注册
    /// 注册接口
    ///
    /// - Parameters:
    ///   - referee: 邀请码
    ///   - pass: 密码
    ///   - repeatPass: 确认密码
    class func register(referee : String,pass : String,repeatPass : String) {
        
        let param : [String : Any] = ["email" : tfemail ?? "","pwd" : pass.md5(),"referee" : referee]
        
        NetWorkTool.shared.postWithPath(path: RIGISTER_URL, paras: param, success: { (result) in
            
            guard let resultData = result as? NSDictionary else {
                return
            }
            
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            if alertMsg == "恭喜您，注册成功" {
                UIApplication.shared.keyWindow?.rootViewController = LoginViewController()
                
            } else {
                toast(toast: alertMsg)
            }
            
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    
    // MARK: - 忘记密码
    class func forgetPassRequest(finished : (_ xxx : String)->()) -> Void {
        finished("success")
    }
    
    
    // MARK: - 发生验证码
    /// 发生验证码
    ///
    /// - Parameters:
    ///   - str: 邮箱地址
    ///   - finished: 传回发生成功记号
    class func sendEmailAutoCode(str : String,finished : @escaping (_ sendResult : Bool)->()) {
        let param : [String : String] = ["email" : str,"pwd" : "","ac" :"semail"]
        
        NetWorkTool.shared.postWithPath(path: FORGETPASS_URL, paras: param, success: { (result) in
            
            guard let resultData = result as? NSDictionary else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            if alertMsg == "发送成功" {
                finished(true)
            } else {
                finished(false)
            }
            
            toast(toast: alertMsg)
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    // MARK: - 修改密码
    ///
    /// - Parameters:
    ///   - emailStr: 邮件地址
    ///   - code: 验证码
    ///   - newPass: 新密码
    ///   - finished: 结果
    class func modifyPass(emailStr : String,code : String,newPass : String,finished: @escaping (_ result : Bool)->()) {
        let param : [String : String] = ["email" : emailStr,"pwd" : newPass.md5(),"code" : code,"ac" : "femail"]
        
        NetWorkTool.shared.postWithPath(path: FORGETPASS_URL, paras: param, success: { (result) in
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            if alertMsg == "重置密码成功" {
                finished(true)
            } else {
                finished(false)
            }
            
            toast(toast: alertMsg)
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    /// 获取用户对象(对象静态化，保存在内存中不释放)
    static func shared() -> AccountModel? {
        if userAccount == nil {
            /// 从本地取出数据
            userAccount = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? AccountModel
            return userAccount
        } else {
            return userAccount
        }
    }
    
    
    //外部闭包变量
    var totalCount:((_ _numCount: Int)->Void)?
    var topModel : ((_ commentTopModel : [IndexCommentTopModel])-> Void)?
    var mertopModel : ((_ mertopModel : [IndexMertopModel])-> Void)?
    
    
    //    class func afterLogin(finished : @escaping (_ values : [IndexCommentTopModel])->(),finishedTop : @escaping (_ values : [IndexMertopModel])->(),finishedTotalModel : @escaping (_ values : Int)->()) {
    //        AccountModel.indexInfo(finished: { (aa) in
    //            finished(aa)
    //        }, finishedTop: { (bb) in
    //            finishedTop(bb)
    //        }) { (cc) in
    //            finishedTotalModel(cc)
    //        }
    //    }
    
    class func afterLogin(finished : @escaping (_ values : [IndexCommentTopModel])->(),finishedTop : @escaping (_ values : [IndexMertopModel])->(),finishedTotalModel : @escaping (_ values : Int)->(),chineseRate : @escaping (_ values : Int)->(),janRate : @escaping (_ values : Int)->()) {
        AccountModel.indexInfo(finished: { (aa) in
            finished(aa)
        }, finishedTop: { (bb) in
            finishedTop(bb)
        }, finishedTotalModel: { (cc) in
            finishedTotalModel(cc)
        }, chineseRate: { (dd) in
            chineseRate(dd)
        }) { (ee) in
            janRate(ee)
        }
    }
    
    // MARK: - 首页接口
    ///
    /// - Parameters:
    ///   - finished: 返回结果
    ///   - finishedTop: 热评商户
    ///   - finishedTotalModel: 头条推荐
    class func indexInfo(finished : @escaping (_ values : [IndexCommentTopModel])->(),finishedTop : @escaping (_ values : [IndexMertopModel])->(),finishedTotalModel : @escaping (_ values : Int)->(),chineseRate : @escaping (_ values : Int)->(),janRate : @escaping (_ values : Int)->()) {
        
        if AccountModel.shared()?.Id.stringValue == nil {
            AccountModel.shared()?.loginSEL()
        } else {
            let param : [String :String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                            "token" : (AccountModel.shared()?.Token)!]
            
            NetWorkTool.shared.postWithPath(path: INDEX_URL, paras: param, success: { (result) in
                
                CCog(message: result)
                
                guard let resultData = result as? NSDictionary  else {
                    return
                }
                
                CCog(message: resultData)
                
                
                
                
                guard let statusMsg = resultData["Status"] as? String else {
                    
                    return
                }
                
                if statusMsg == "999" {
                    AccountModel.shared()?.loginSEL()
                }
                
                /// 抽取提示信息
                guard let alertMsg = resultData["Msg"] as? String else {
                    
                    return
                }
                
                /// 取数据
                if alertMsg == "操作成功" {
                    if let dic = resultData["Data"] as? NSArray {

                        finishedTotalModel(dic.count)
                        
                        /// 更新本地存储信息
                        let account = AccountModel(dict: (resultData["Data"] as? NSArray)?[0] as? NSDictionary as! [String : Any])
                        
                        account.saveAccount()
                        
                        AccountModel.shared()?.updateUserInfo()
                        
                        /// 提取汇率
                        if let rateDic = (resultData["Data"] as? NSArray)?.lastObject as? NSDictionary {
                            /// 中文汇率
                            if let cnyRate = ((rateDic["WBCRate"] as? NSArray)?[0] as? NSDictionary)?["Cash"] as? Int {
                                janRate(cnyRate)
                                WBCRateModel.CNYRate = cnyRate
                            }
                            
                            /// 日文汇率
                            if let cnyRate = ((rateDic["WBCRate"] as? NSArray)?[1] as? NSDictionary)?["Cash"] as? Int {
                                chineseRate(cnyRate)
                                WBCRateModel.JPYRate = cnyRate
                            }
                        }
                        
                        //头条推荐
                        if let dicc = [(((resultData["Data"] as? NSArray)?[1]) as? NSDictionary)?["CommendTop"] as? NSArray][0] {
                            
                            var mmm = [IndexCommentTopModel]()
                            for vv in dicc {
                                if let diccc = vv as? NSDictionary {
                                    
                                    let topMedel = IndexCommentTopModel.init(dict: diccc as! [String : Any])
                                    
                                    mmm.append(topMedel)
                                    
                                    if mmm.count == dicc.count {
                                        finished(mmm)
                                    }
                                }
                            }
                        }
                        
                        //热评商户
                        if let dicc = [(((resultData["Data"] as? NSArray)?[0]) as? NSDictionary)?["MerTop"] as? NSArray][0] {
                            
                            var mmm = [IndexMertopModel]()
                            for vv in dicc {
                                if let diccc = vv as? NSDictionary {
                                    
                                    let topMedel = IndexMertopModel.init(dict: diccc as! [String : Any])
                                    
                                    mmm.append(topMedel)
                                    
                                    if mmm.count == dicc.count {
                                        finishedTop(mmm)
                                    }
                                }
                            }
                        }
                    }
                    
                    //头条推荐
                    if let dicc = (resultData["Data"] as? NSArray)?[0] as? NSDictionary {
                        
                        dicc.write(toFile: "/Users/zhengdongxi/Desktop/ddddd.plist", atomically: true)
                        
                        //头条推荐
                        if let dicc = [dicc["CommendTop"] as? NSArray][0] {
                            
                            var mmm = [IndexCommentTopModel]()
                            for vv in dicc {
                                if let diccc = vv as? NSDictionary {
                                    
                                    let topMedel = IndexCommentTopModel.init(dict: diccc as! [String : Any])
                                    
                                    mmm.append(topMedel)
                                    
                                    if mmm.count == dicc.count {
                                        finished(mmm)
                                    }
                                }
                            }
                        }
                        
                        //热评商户
                        if let dicc = [dicc["MerTop"] as? NSArray][0] {
                            var mmm = [IndexMertopModel]()
                            for vv in dicc {
                                if let diccc = vv as? NSDictionary {
                                    
                                    let topMedel = IndexMertopModel.init(dict: diccc as! [String : Any])
                                    
                                    mmm.append(topMedel)
                                    
                                    if mmm.count == dicc.count {
                                        finishedTop(mmm)
                                    }
                                }
                            }
                        }
                    }
                }
                
                
                
            }) { (error) in
                let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
                toast(toast: alertMsg! as! String)
            }
        }
        
    }
    
    // MARK: - 发送验证码 --- 双重验证码接口
    class func sendAuthSEL(phoneNum : String) {
        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                         "token" : (AccountModel.shared()?.Token)!,
                                         "phone" : phoneNum,
                                         "code" : "",
                                         "ac" : "smsg"]
        
        NetWorkTool.shared.postWithPath(path: DOB_AUTH, paras: param, success: { (result) in
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            
            toast(toast: alertMsg)
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    // MARK: - 绑定手机
    ///
    /// - Parameter phoneNum: 手机号
    class func bindPhoneAuthSEL(phoneNum : String) {
        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                         "token" : (AccountModel.shared()?.Token)!,
                                         "phone" : phoneNum,
                                         "code" : "",
                                         "ac" : "smsg"]
        
        NetWorkTool.shared.postWithPath(path: BIND_PHONE, paras: param, success: { (result) in
            
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            toast(toast: alertMsg)
            
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    // MARK: - 双重验证
    ///
    /// - Parameters:
    ///   - auth: 验证码
    ///   - phoneNum: 手机号
    class func doubleCerSEL(auth : String,phoneNum : String) {
        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                         "token" : (AccountModel.shared()?.Token)!,
                                         "phone" : phoneNum,
                                         "code" : auth,
                                         "ac" : "gauth"]
        
        NetWorkTool.shared.postWithPath(path: DOB_AUTH, paras: param, success: { (result) in
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            toast(toast: alertMsg)
            
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    
    // MARK: - 绑定手机接口
    // MARK: - 双重验证
    ///
    /// - Parameters:
    ///   - auth: 验证码
    ///   - phoneNum: 手机号
    ///   - finished: 返回结果
    class func bindPhoneSEL(auth : String,phoneNum : String,finished : @escaping (_ ddd : Bool) -> ()) {
        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                         "token" : (AccountModel.shared()?.Token)!,
                                         "phone" : phoneNum,
                                         "code" : auth,
                                         "ac" : "bpon"]
        
        NetWorkTool.shared.postWithPath(path: BIND_PHONE, paras: param, success: { (result) in
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                return
            }
            
            
            toast(toast: alertMsg)
            
            if alertMsg == "恭喜您，绑定手机成功" {
                finished(true)
            }
            
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    
    
    // MARK: - 修改登录密码
    ///
    /// - Parameters:
    ///   - oldStr: 旧密码
    ///   - newPass: 新密码
    class func changeLoginPass(oldStr : String,newPass : String,finished : @escaping (_ result : Bool) -> ()) -> Void {
        let param = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                     "token" : (AccountModel.shared()?.Token)!,
                     "oldpwd" : oldStr.md5(),
                     "newpwd" : newPass.md5()]
        NetWorkTool.shared.postWithPath(path: CHANGELOGIN_PASS, paras: param, success: { (result) in
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            if alertMsg == "修改登陆密码成功" {
                finished(true)
            }
            
            toast(toast: alertMsg)
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    // MARK: - 设置支付密码
    ///
    /// - Parameters:
    ///   - payPass: 支付密码
    ///   - repeatPass: 重复支付密码
    ///   - finished: 结果
    class func payPassSEL(payPass : String,finished : @escaping (_ result : Bool) -> ()) {
        let param = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                     "token" : (AccountModel.shared()?.Token)!,
                     "oldpwd" : "",
                     "newpwd" : payPass.md5(),
                     "ac" : "spd"]
        NetWorkTool.shared.postWithPath(path: PAY_PASS, paras: param, success: { (result) in
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            if alertMsg == "设置支付密码成功" {
                finished(true)
            }
            
            if alertMsg == "设置支付密码成功" {
                finished(true)
            }
            
            toast(toast: alertMsg)
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    
    
    /// 修改支付密码
    ///
    /// - Parameters:
    ///   - newPass: 新密码
    ///   - oldPass: 旧密码
    ///   - finshed: 完成结果
    class func changePayPass(newPass : String,oldPass : String,finshed : @escaping (_ result : Bool) -> ()) {
        
        let param = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                     "token" : (AccountModel.shared()?.Token)!,
                     "oldpwd" : oldPass.md5(),
                     "newpwd" : newPass.md5(),
                     "ac" : "rpd"]
        
        NetWorkTool.shared.postWithPath(path: PAY_PASS, paras: param, success: { (result) in
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            if alertMsg == "修改支付密码成功" {
                finshed(true)
            }
            
            if alertMsg == "设置支付密码成功" {
                finshed(true)
            }
            
            toast(toast: alertMsg)
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    // MARK: - 上次图片返回图片地址
    /// 上次图片
    ///
    /// - Parameters:
    ///   - imgData: 图片数据
    ///   - finished: 返回图片链接地址
    class func uploadImgFromLocalLibrary(imgData : Data,finished: @escaping (_ imgUrl : String,_ uploadResult : Bool) -> ()) {
        if imgData.count > 0 {
            
            let request = "\(COMMON_PREFIX)/ifs/headimg.ashx?uid=\((AccountModel.shared()?.Id.stringValue)!)&token=\((AccountModel.shared()?.Token)!)&ac=dd"
            
            NetWorkTool.shared.postWithImageWithData(imgData: imgData, path: request, success: { (result) in
                
                CCog(message: result)
                
                guard let resultData = result as? NSDictionary  else {
                    return
                }
                
                guard let statusMsg = resultData["Status"] as? String else {
                    
                    return
                }
                
                if statusMsg == "999" {
                    AccountModel.shared()?.loginSEL()
                }
                
                
                /// 抽取提示信息
                guard let alertMsg = resultData["Msg"] as? String else {
                    
                    return
                }
                
                if alertMsg == "操作成功" {
                    /// 抽取提示信息
                    guard let headImgDic = resultData["Data"] as? NSArray else {
                        
                        return
                    }
                    
                    if headImgDic.count > 0 {
                        finished((((resultData["Data"] as? NSArray)?[0] as? NSDictionary)?["HeadUrl"] as? String)!,true)
                    }
                    
                    CCog(message: headImgDic)
                    
                    toast(toast: "上传成功")
                }
            }, failure: { (error) in
                CCog(message: error.localizedDescription)
                toast(toast: error.localizedDescription)
                finished("",false)
            })
        } else {
            toast(toast: "图片数据不对")
        }
    }
    
    
    // MARK: - 实名认证接口
    ///
    /// - Parameters:
    ///   - frontImg: 正面图片路径
    ///   - backImgURL: 背面图片路径
    ///   - idCode: 身份证号码
    ///   - nameStr: 名字
    ///   - finished: 请求结果
    class func trueNameCertify(frontImg : String,backImgURL :String,idCode : String,nameStr : String,finished : @escaping (_ result : Bool) -> ()) {
        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                         "token" : (AccountModel.shared()?.Token)!,
                                         "name" : nameStr,
                                         "idcode" : idCode,
                                         "front" : frontImg,
                                         "reverse" : backImgURL]
        
        NetWorkTool.shared.postWithPath(path: TRUENAME_AUTH, paras: param, success: { (result) in
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            if alertMsg == "操作成功" {
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
                    toast(toast: "请求成功")
                })
                
                finished(true)
                
                let patram = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                              "token" : (AccountModel.shared()?.Token)!]
                NetWorkTool.shared.postWithPath(path: REFRESH_INFO, paras: patram, success: { (result) in
                    CCog(message: result)
                }, failure: { (error) in
                    CCog(message: error.localizedDescription)
                })
            }
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    // MARK: - 上传头像
    ///
    /// - Parameters:
    ///   - imgData: 图像数据
    ///   - finished: 返回结果
    class func uploadHeadImg(imgData : Data,finished: @escaping (_ result : Bool)->()) {
        let request = "\(COMMON_PREFIX)/ifs/headimg.ashx?uid=\((AccountModel.shared()?.Id.stringValue)!)&token=\((AccountModel.shared()?.Token)!)&ac=myimg"
        
        NetWorkTool.shared.postWithImageWithData(imgData: imgData, path: request, success: { (result) in
            
            CCog(message: result)
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            if alertMsg == "操作成功" {
                finished(true)
            }
            
            guard let headURLStr = ((((result as? NSDictionary)?["Data"]) as? NSArray)?[0] as? NSDictionary)?["HeadUrl"] as? String else {
                
                return
            }
            
            CardModel.shared.applyURL = headURLStr
            
            
            toast(toast: alertMsg)
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    // MARK: - 转账
    ///
    /// - Parameters:
    ///   - wbcCount: 网博币数量
    ///   - passStr: 密码
    ///   - finished: 成功回调
    class func moneySend(_ wbcCount : String,_ passStr : String,_ moneySendType : String,finished : @escaping (_ result : Bool) -> ()) {
        let param : [String : Any] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                      "token" : (AccountModel.shared()?.Token)!,
                                      "topayads" : (ScanModel.shared.codeStr)!,
                                      "wbc" : String(wbcCount) ?? 0,
                                      "paypass" : passStr.md5(),
                                      "ac" : moneySendType]
        
        NetWorkTool.shared.postWithPath(path: TELLTOPAY, paras: param, success: { (result) in
            CCog(message: result)
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            toast(toast: alertMsg)
            
            if alertMsg == "转账成功" {
                
                AccountModel.reloadSEL()
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
                    finished(true)
                })
                
                finished(true)
            }
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    // MARK: - 刷新
    class func reloadSEL() {
        
        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                         "token" : (AccountModel.shared()?.Token)!]
        
        NetWorkTool.shared.postWithPath(path: PERSON_INFO, paras: param, success: { (result) in
            
            userAccount = nil
            
            /// 更新本地存储信息
            guard let resultData = result as? NSDictionary else {
                
                CCog(message: "登录信息无效")
                return
            }
            
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
                
            }
            
            
            guard let arrayData = (resultData["Data"] as? NSArray) else {
                return
            }
            
            if arrayData.count > 0 {
                guard let account = (arrayData[0] as? [String : Any]) else {
                    return
                }
                
                guard var fourSecData = (arrayData[1] as? [String : Any]) else {
                    return
                }
                
                for (key,value) in account {
                    fourSecData[key] = value
                }
                
                
                /// 更新本地存储信息
                let accountInfo = AccountModel(dict: fourSecData)
                accountInfo.saveAccount()
                
                CCog(message: accountPath)
                
                guard let alertMsg = resultData["Msg"] as? String else {
                    return
                }
                
                if alertMsg == "登陆成功" {
                    
                    /// 记录登录时间
                    let now = Date()
                    let timerStamp : TimeInterval = now.timeIntervalSince1970
                    
                    let timeStamp = Int(timerStamp)
                    
                    /// 记录本地登录成功的时间/更新
                    UserDefaults.standard.set(timeStamp, forKey: "loginTime")
                    UserDefaults.standard.synchronize()
                    
                    // 设置全局颜色
                    UITabBar.appearance().tintColor = TABBAR_BGCOLOR
                    UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
                }
                
                /// 发通知刷新提示
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadInfo"), object: nil)
            }
            
            
        }) { (error) in
            
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    // MARK: - 加好友接口
    /// 扫描添加方式
    ///
    /// - Parameters:
    ///   - chooseType: 添加类型
    ///   - friendCount: 朋友账号
    ///   - friendIDStr: 朋友ID
    ///   - frqcodeStr: 好友二维码地址
    ///   - finished:完成
    class func addFriendRequest(_ chooseType : String,_ wbcadrs : String,_ friendCount : String,_ friendIDStr : String,_ frqcodeStr : String,_ rmkStr : String,_ finished : @escaping (_ result : Bool,_ dataDic : [AddFriendModel]) -> ()) {
        
        
        let param : [String : Any] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                      "token" : (AccountModel.shared()?.Token)!,
                                      "frqcode" : frqcodeStr,
                                      "usname" : friendCount,
                                      "frid" : friendIDStr,
                                      "rmk": rmkStr,
                                      "wbcadrs" :wbcadrs,
                                      "ac" : chooseType]
        
        CCog(message: param)
        
        NetWorkTool.shared.postWithPath(path: ADD_FRIEND, paras: param, success: { (result) in
            CCog(message: result)
            
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            toast(toast: alertMsg)
            
            if alertMsg == "操作成功" {
                if let dic = (resultData["Data"] as? NSArray) {
                    CCog(message: dic)
                    
                    var mmm = [AddFriendModel]()
                    
                    for vv in dic {
                        
                        let topMedel = AddFriendModel.init(dict: vv as! [String : Any])
                        
                        mmm.append(topMedel)
                        
                        CCog(message: mmm.count)
                        
                        if mmm.count == dic.count {
                            finished(true,mmm)
                        }
                    }
                }
            } else if alertMsg == "发送成功" {
                finished(true,[AddFriendModel]())
            }  else if alertMsg == "成功加为好友" {
                finished(true,[AddFriendModel]())
            }
            
        }) { (error) in
            
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    // MARK: - 朋友接口
    class func GetFriendList(_ limitCount : String,_ loadCount : String,finished:@escaping (_ result : Bool,_ dataDic : [NewFriendListModel]) -> ()) {
        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                         "token" : (AccountModel.shared()?.Token)!,
                                         "limit" : "1",
                                         "offset" : "10"]
        
        NetWorkTool.shared.postWithPath(path: FRIEND_LIST, paras: param, success: { (result) in
            
            
            guard let resultData = result as? NSDictionary else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            toast(toast: alertMsg)
            
            if alertMsg == "操作成功" {
                
                if let dataArray = resultData["Data"] as? NSArray {
                    if dataArray.count > 0 {
                        if let dic = (resultData["Data"] as? NSArray) {
                            
                            var mmm = [NewFriendListModel]()
                            
                            for vv in dic {
                                
                                let topMedel = NewFriendListModel.init(dict: vv as! [String : Any])
                                
                                mmm.append(topMedel)
                                
                                if mmm.count == dic.count {
                                    finished(true,mmm)
                                }
                            }
                        }
                    }
                }
                
            } else {
                finished(false,[NewFriendListModel]())
            }
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    // MARK: - tranpayorder	用户转账订单接口
    ///
    /// - Parameters:
    ///   - fridStr: 转账人的ID
    ///   - finished: 模型结果.
    class func tranPayOrderRequest(_ fridStr : String,_ finished : @escaping (_ result : Bool,_ dataModel : [TranpayorderModel])-> ()) {
        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                         "token" : (AccountModel.shared()?.Token)!,
                                         "frid" : fridStr]
        
        CCog(message: param)
        
        NetWorkTool.shared.postWithPath(path: TRANPAY_ORDER, paras: param, success: { (result) in
            CCog(message: result)
            
            
            guard let resultData = result as? NSDictionary else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            toast(toast: alertMsg)
            
            if alertMsg == "操作成功" {
                
                if let dataArray = resultData["Data"] as? NSArray {
                    if dataArray.count > 0 {
                        if let dic = (resultData["Data"] as? NSArray) {
                            CCog(message: dic)
                            
                            var mmm = [TranpayorderModel]()
                            
                            for vv in dic {
                                
                                let topMedel = TranpayorderModel.init(dict: vv as! [String : Any])
                                
                                mmm.append(topMedel)
                                
                                CCog(message: mmm.count)
                                CCog(message: vv)
                                
                                if mmm.count == dic.count {
                                    finished(true,mmm)
                                }
                            }
                        }
                    }
                }
                
                
            } else {
                finished(false,[TranpayorderModel]())
            }
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    // MARK: - 新的朋友接口
    class func newFriend(finished:@escaping (_ result : Bool,_ dataDic : [FriendMainListModel]) -> ()) {
        
        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                         "token" : (AccountModel.shared()?.Token)!]
        CCog(message: param)
        
        //// FriendMainListModel
        NetWorkTool.shared.postWithPath(path: NEWFRIEND_LIST, paras: param, success: { (result) in
            CCog(message: result)
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            toast(toast: alertMsg)
            
            if alertMsg == "操作成功" {
                
                if let dataArray = resultData["Data"] as? NSArray {
                    if dataArray.count > 0 {
                        if let dic = (resultData["Data"] as? NSArray) {
                            
                            var mmm = [FriendMainListModel]()
                            
                            for vv in dic {
                                
                                let topMedel = FriendMainListModel.init(dict: vv as! [String : Any])
                                
                                mmm.append(topMedel)
                                
                                CCog(message: mmm.count)
                                CCog(message: vv)
                                
                                if mmm.count == dic.count {
                                    finished(true,mmm)
                                }
                            }
                        }
                    }
                }
                
            } else {
                finished(false,[FriendMainListModel]())
            }
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
        
    }
    
    // MARK: - 朋友列表接口--- 暂时写死
    class func friend_list(finished:@escaping (_ result : Bool,_ dataDic : [FriendListModel]) -> ()) {
        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                         "token" : (AccountModel.shared()?.Token)!]
        
        
        NetWorkTool.shared.postWithPath(path: MY_FRIEND, paras: param, success: { (result) in
            
            //                        if let resultDic = result as? NSDictionary {
            //                            resultDic.write(toFile: "/Users/zhengdongxi/Desktop/FriendList.plist", atomically: true)
            //                        }
            //
            CCog(message: result)
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            CCog(message: userData)
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            toast(toast: alertMsg)
            
            if alertMsg == "操作成功" {
                
                if let dataArray = resultData["Data"] as? NSArray {
                    if dataArray.count > 0 {
                        if let dic = (resultData["Data"] as? NSArray) {
                            
                            var mmm = [FriendListModel]()
                            
                            for vv in dic {
                                
                                let topMedel = FriendListModel.init(dict: vv as! [String : Any])
                                
                                mmm.append(topMedel)
                                if mmm.count == dic.count {
                                    finished(true,mmm)
                                }
                            }
                        }
                    }
                }
                
            } else {
                finished(false,[FriendListModel]())
            }
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
        
    }
    
    // MARK: - 充值卡接口
    ///
    /// - Parameters:
    ///   - rchgcodeStr: 充值卡号
    ///   - rchgpwd: 充值卡密码
    class func rchcardSEL(_ rchgcodeStr : String,_ rchgpwd : String,finished:@escaping (_ result : Bool) -> ()) {
        let param : [String : String] = ["uid" : (AccountModel.shared()?.Id.stringValue)!,
                                         "token" : (AccountModel.shared()?.Token)!,
                                         "rchgcode" : rchgcodeStr,
                                         "rchgpwd" : rchgpwd]
        CCog(message: param)
        
        //// FriendMainListModel
        NetWorkTool.shared.postWithPath(path: RCHGACRD, paras: param, success: { (result) in
            CCog(message: result)
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            guard let statusMsg = resultData["Status"] as? String else {
                
                return
            }
            
            if statusMsg == "999" {
                AccountModel.shared()?.loginSEL()
            }
            
            /// 抽取提示信息
            guard let alertMsg = resultData["Msg"] as? String else {
                
                return
            }
            
            toast(toast: alertMsg)
            
            if alertMsg == "充值成功" {
                finished(true)
            } else {
                finished(false)
            }
            
        }) { (error) in
            let alertMsg = (error as NSError).userInfo["NSLocalizedDescription"]
            toast(toast: alertMsg! as! String)
        }
    }
    
    
    // MARK: - 归档接档
    func encode(with aCoder: NSCoder) {
        /// 令牌
        aCoder.encode(Token, forKey: "Token")
        
        /// 开户日期
        aCoder.encode(OpenedDate, forKey: "OpenedDate")
        
        /// 用户名
        aCoder.encode(UserName, forKey: "UserName")
        
        /// 用户密码
        aCoder.encode(UserPass, forKey: "UserPass")
        
        /// 头像地址
        aCoder.encode(HeadImg, forKey: "HeadImg")
        
        /// 我的二维码地址(加好友)
        aCoder.encode(FrinQCode, forKey: "FrinQCode")
        
        /// 交易密码
        aCoder.encode(PayQCode, forKey: "PayQCode")
        
        /// 交易状态
        aCoder.encode(TraderPass, forKey: "TraderPass")
        
        /// 姓名
        aCoder.encode(TraderStatus, forKey: "TraderStatus")
        
        aCoder.encode(TrueName, forKey: "TrueName")
        
        /// 性别
        aCoder.encode(Sex, forKey: "Sex")
        
        /// 国籍
        aCoder.encode(Nationality, forKey: "Nationality")
        
        /// 出生年月
        aCoder.encode(BirthDate, forKey: "BirthDate")
        
        /// 证件
        aCoder.encode(Credential, forKey: "Credential")
        /// ID签发日期
        aCoder.encode(IssueDate, forKey: "IssueDate")
        
        /// ID有效期
        aCoder.encode(ExpiryDate, forKey: "ExpiryDate")
        
        /// 单位地址
        aCoder.encode(WorkingAdress, forKey: "WorkingAdress")
        
        /// 居住地址
        aCoder.encode(ResidenceAdress, forKey: "ResidenceAdress")
        
        /// 邮箱
        aCoder.encode(Email, forKey: "Email")
        /// 手机号码
        aCoder.encode(Phone, forKey: "Phone")
        
        /// 开户推荐人ID
        aCoder.encode(Referee, forKey: "Referee")
        
        /// 矿机型号
        aCoder.encode(OreMachine, forKey: "OreMachine")
        
        /// SIM card 号码
        aCoder.encode(SIMCardNo, forKey: "SIMCardNo")
        
        /// 备注
        aCoder.encode(Remark, forKey: "Remark")
        
        /// 职业
        aCoder.encode(Profession, forKey: "Profession")
        
        /// 资金来源
        aCoder.encode(Financed, forKey: "Financed")
        
        /// 年薪
        aCoder.encode(YearlySalary, forKey: "YearlySalary")
        
        /// 合同副本
        aCoder.encode(ContractCopy, forKey: "ContractCopy")
        
        /// 身份证明文件／护照
        
        aCoder.encode(CredentialCopy, forKey: "CredentialCopy")
        
        /// 一张手持政府签发有效证件的自拍照
        
        aCoder.encode(SelfieCopy, forKey: "SelfieCopy")
        /// 住址证明文件
        
        aCoder.encode(AdressCopy, forKey: "AdressCopy")
        /// 总代理商
        
        aCoder.encode(AcctType, forKey: "AcctType")
        /// 网博币钱包地址
        
        aCoder.encode(WBCAdress, forKey: "WBCAdress")
        /// 提交时间 http://www.hangge.com/blog/cache/detail_1198.html#
        
        aCoder.encode(SubmitTime, forKey: "SubmitTime")
        
        /// 积分
        aCoder.encode(Integral, forKey: "Integral")
        
        /// 网博币
        aCoder.encode(WBC, forKey: "WBC")
        
        /// 认证状态
        aCoder.encode(VerifiStatus, forKey: "VerifiStatus")
        
        /// 用户ID
        aCoder.encode(Id, forKey: "Id")
    }
    
    required init?(coder aDecoder: NSCoder) {
        Token = aDecoder.decodeObject(forKey: "Token") as? String
        OpenedDate = aDecoder.decodeObject(forKey: "OpenedDate") as? String
        UserName = aDecoder.decodeObject(forKey: "UserName") as? String
        UserPass = aDecoder.decodeObject(forKey: "UserPass") as? String
        HeadImg = aDecoder.decodeObject(forKey: "HeadImg") as? String
        FrinQCode = aDecoder.decodeObject(forKey: "FrinQCode") as? String
        PayQCode = aDecoder.decodeObject(forKey: "PayQCode") as? String
        TraderPass = aDecoder.decodeObject(forKey: "TraderPass") as? String
        TraderStatus = aDecoder.decodeObject(forKey: "TraderStatus") as? TraderStatus
        TrueName = aDecoder.decodeObject(forKey: "TrueName") as? String
        Sex = aDecoder.decodeObject(forKey: "Sex") as? SEXEnum
        Nationality = aDecoder.decodeObject(forKey: "Nationality") as? String
        BirthDate = aDecoder.decodeObject(forKey: "BirthDate") as? String
        Credential = aDecoder.decodeObject(forKey: "Credential") as? CredentialEnum
        IssueDate = aDecoder.decodeObject(forKey: "IssueDate") as? String
        ExpiryDate = aDecoder.decodeObject(forKey: "ExpiryDate") as? String
        WorkingAdress = aDecoder.decodeObject(forKey: "WorkingAdress") as? String
        ResidenceAdress = aDecoder.decodeObject(forKey: "ResidenceAdress") as? String
        Email = aDecoder.decodeObject(forKey: "Email") as? String
        Phone = aDecoder.decodeObject(forKey: "Phone") as? String
        
        /// 识别双重认证状态、绑定手机状态
        if Phone?.characters.count > 0 {
            self.realDoubleBoo = true
        } else {
            self.realDoubleBoo = false
        }
        Integral = (aDecoder.decodeObject(forKey: "Integral") as? NSNumber)!
        
        VerifiStatus = (aDecoder.decodeObject(forKey: "VerifiStatus") as? NSNumber)!
        
        Id = (aDecoder.decodeObject(forKey: "Id") as? NSNumber)!
        
        Referee = aDecoder.decodeObject(forKey: "Referee") as? String
        OreMachine = aDecoder.decodeObject(forKey: "OreMachine") as? OreMachineEnum
        SIMCardNo = aDecoder.decodeObject(forKey: "SIMCardNo") as? String
        Remark = aDecoder.decodeObject(forKey: "Remark") as? String
        Profession = aDecoder.decodeObject(forKey: "Profession") as? ProfessionEnum
        Financed = aDecoder.decodeObject(forKey: "Financed") as? FinancedEnum
        YearlySalary = aDecoder.decodeObject(forKey: "YearlySalary") as? String
        ContractCopy = aDecoder.decodeObject(forKey: "ContractCopy") as? String
        CredentialCopy = aDecoder.decodeObject(forKey: "CredentialCopy") as? String
        SelfieCopy = aDecoder.decodeObject(forKey: "SelfieCopy") as? String
        AdressCopy = aDecoder.decodeObject(forKey: "AdressCopy") as? String
        AcctType = aDecoder.decodeObject(forKey: "AcctType") as? AcctTypeEnum
        WBCAdress = aDecoder.decodeObject(forKey: "WBCAdress") as? String
        SubmitTime = aDecoder.decodeObject(forKey: "SubmitTime") as? String
        WBC = aDecoder.decodeObject(forKey: "WBC") as? String
    }
}
