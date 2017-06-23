////
////  AccountModel.swift
////  WangBoBi
////
////  Created by 郑东喜 on 2017/6/21.
////  Copyright © 2017年 郑东喜. All rights reserved.
////  用户信息模型
//
//public static String userId = "";
////帐号
//public static String userpassword="";
////密码
//public static String userToker = "";
////唯一的 token
//public static String userName="";
////姓名
//public static String userImghead = "";
////头像地址
//public static String userWallet = "";
////钱包地址
//
//public static String userQRcode = "";
////加好友的二维码
//
//public static String user_Pay_QRcode= "";
////付款二维码id  暂无
//
//public static String user_Collect_QRcode = "";
////收款二维码id
//
//public static boolean realNameBoo = false;
////是否实名认证
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
//public static int WBC = 0;
////网博币
//
//public static Float JP= 0.0f;
////和日币的比例
//
//public static Float CP= 0.0f;
////和人民币的比例
//
//public static int  JF = 0;
////积分
//
//public static Float Trading = 0.0f;
////交易量

import UIKit

class AccountModel: NSObject,NSCoding {
    /// 令牌
    var token : String?
    
    /// 用户ID
//    var userID : Int = 0
//
    /// 昵称
    var nickName : String = ""
//
//    /// 头像路径
//    var avatarUrl : String?
//    
    /// 邮箱
    var email : String = ""
    
    /// 验证码
    var autoCode : String = ""
    
    
    /// 是否实名
    var isCertiFied = false
    
    
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
        
        let param = ["email" : emailStr,"pwd" : pass.md5()]
        
        /// 返回数据
        NetWorkTool.shared.postWithPath(path: LOGIN_URL, paras: param, success: { (result) in

            
            guard let resultData = result as? NSDictionary else {
                
                CCog(message: "登录信息无效")
                return
            }
            
            CCog(message: resultData)
            
            let account = AccountModel(dict: resultData as! [String : Any])
            account.saveAccount()

            guard let alertMsg = resultData["msg"] as? String else {
                return
            }

            
            if alertMsg == "登陆成功" {
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

        let param : [String : Any] = ["email" : AccountModel.shared()?.email ?? "","pwd" : pass.md5(),"referee" : referee]
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
        aCoder.encode(token, forKey: "token")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        token = aDecoder.decodeObject(forKey: "token") as? String
    }

    
}
