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
//Optional({
//    AcctType = "<null>";
//    AdressCopy = "";
//    BirthDate = "";
//    ContractCopy = "";
//    Credential = "";
//    CredentialCopy = "";
//    Email = "946737816@qq.com";
//    ExpiryDate = "";
//    Financed = "";
//    FrinQCode = "wbf://c1ebc999-9d41-4127-99ce-7ddca383f01f";
//    HeadImg = "http://192.168.1.10:8010/images/logo.jpg";
//    Id = 1;
//    IssueDate = "";
//    Nationality = "";
//    OpenedDate = "2017-06-23";
//    OreMachine = "<null>";
//    PayQCode = "wbp://ce6604ed-6c7b-4de8-80c3-49b00683dfdd";
//    Phone = "";
//    Profession = "";

//    Referee = "";
//    Remark = "";
//    ResidenceAdress = "";
//    SIMCardNo = "";
//    SelfieCopy = "";
//    Sex = "";
//    SubmitTime = "2017-06-23T16:58:44";
//    Token = ad84b3d10e994342bfb665e346d6b289;
//    TraderPass = "";
//    TraderStatus = "<null>";
//    TrueName = "";
//    UserName = "946737816@qq.com";
//    UserPass = e10adc3949ba59abbe56e057f20f883e;
//    WBCAdress = WXVxpEzLsP8nzmZS22PGYTuTsU1aCbT5gG;
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
    var WBC : Int?
    
    /// 和日币的比例
    var JP : Int?
    
    /// 和人民币的比例
    var CP : Int?
    
    /// 积分
    var JF : Int?
    
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
    
    /// 开户日期
    var OpenedDate : String?
    
    /// 用户名
    var UserName : String?
    
    /// 用户密码
    var UserPass : String?
    
    /// 头像地址
    var HeadImg :String?
    
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
    
    
    
    // MARK: - 保存对象
    func saveAccount() {
        NSKeyedArchiver.archiveRootObject(self, toFile: AccountModel.accountPath)
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
            
            CCog(message: resultData["data"])
            
            let account = AccountModel(dict: resultData["data"] as! [String : Any])
            account.saveAccount()

            
            CCog(message: accountPath)
            
            guard let alertMsg = resultData["msg"] as? String else {
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
                
                
                
                UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
            } else {
                toast(toast: alertMsg)
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
        CCog(message: param)
        
        NetWorkTool.shared.postWithPath(path: RIGISTER_URL, paras: param, success: { (result) in
            CCog(message: result)
            
            guard let resultData = result as? NSDictionary else {
                return
            }
            
            /// 抽取提示信息
            guard let alertMsg = resultData["msg"] as? String else {
                
                return
            }
            
            if alertMsg == "恭喜您，注册成功" {
                UIApplication.shared.keyWindow?.rootViewController = MainTabBarViewController()
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
            CCog(message: result)
            
            
            
            guard let resultData = result as? NSDictionary else {
                return
            }
            
            
            
            /// 抽取提示信息
            guard let alertMsg = resultData["msg"] as? String else {
                
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
    class func modifyPass(emailStr : String,code : String,newPass : String,finished: @escaping (_ result : Bool)->()){
        let param : [String : String] = ["email" : emailStr,"pwd" : newPass.md5(),"code" : code,"ac" : "femail"]
        
        CCog(message: param)
        
        NetWorkTool.shared.postWithPath(path: FORGETPASS_URL, paras: param, success: { (result) in
            CCog(message: result)
            
            
            guard let resultData = result as? NSDictionary  else {
                return
            }
            
            /// 抽取提示信息
            guard let alertMsg = resultData["msg"] as? String else {
                
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
    
    
    /// 登录保存
    func updateUserInfo() -> Void {
        AccountModel.userAccount = self
        // 归档用户信息
        saveAccount()
    }
    
    // MARK: - 是否登录
    class func isLogin() -> Bool{
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
    
    
    
    // MARK: - 检查用户是否有效
    class func checuUserInfo() {
        if isLogin() {
            // 已经登录并且保存过的信息
            
            let params : [String : String ] = [:]
            NetWorkTool.shared.postWithPath(path: CHECK_TOKEN, paras: params, success: { (result) in
                
            }, failure: { (error) in
                CCog(message: error.localizedDescription)
            })
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
        
        if Phone?.characters.count == 0 {
            self.realNameInt = realNameIntEnum(rawValue: 3)
        }
        
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
    }
    
    
}
