//
//  RequestCommon.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/20.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  请求链接常量

import Foundation

/// 登录链接
let LOGIN_URL = "\(COMMON_PREFIX)/ifs/login.ashx"


//\(COMMON_PREFIX)/ifs/passfind.ashx  忘记密码接口  返回格式：JSON
//请求参数：email  邮箱地址 ，pwd  登陆密码MD5加密密文，code 验证码       ac  操作类型值（semail：发送验证码，femail：重置密码）

/// 前缀请求
let COMMON_PREFIX = "http://wbpay.ie1e.com"

/// 忘记密码链接
let FORGETPASS_URL = "\(COMMON_PREFIX)/ifs/passfind.ashx"

/// 注册请求
let RIGISTER_URL = "\(COMMON_PREFIX)/ifs/reg.ashx"

/// 首页请求接口
let INDEX_URL = "\(COMMON_PREFIX)/ifs/index.ashx"

/// 双重验证
let DOB_AUTH = "\(COMMON_PREFIX)/ifs/dobauth.ashx"

/// 修改登录密码
let CHANGELOGIN_PASS = "\(COMMON_PREFIX)/ifs/resetpwd.ashx"

/// 绑定手机接口
let BIND_PHONE = "\(COMMON_PREFIX)/ifs/toiv.ashx"

/// 支付密码
let PAY_PASS = "\(COMMON_PREFIX)/ifs/resetpaypwd.ashx"

/// 上传图片
let UPLOAD_IMGDATA = "\(COMMON_PREFIX)/ifs/headimg.ashx"

/// 实名认证
let TRUENAME_AUTH = "\(COMMON_PREFIX)/ifs/realauth.ashx"

/// 刷新接口
let REFRESH_INFO = "\(COMMON_PREFIX)/ifs/basicinfo.ashx"

/// 个人接口
let PERSON_INFO = "\(COMMON_PREFIX)/ifs/basicinfo.ashx"

/// 商家接口
let TELLTOPAY = "\(COMMON_PREFIX)/ifs/tofellowpay.ashx"

/// 商户
let STOTRURL = "\(COMMON_PREFIX)/store.aspx"

/// 测试王海珍
let TEST_URL = "https://laod.cn/hosts/2017-google-hosts.html"

/// 我的好友接口列表
let MY_FRIEND = "\(COMMON_PREFIX)/ifs/myfriend.ashx"

/// 添加好友列表
let ADD_FRIEND = "\(COMMON_PREFIX)/ifs/addfriend.ashx"

/// 好友列表
let FRIEND_LIST = "\(COMMON_PREFIX)/ifs/tranfriend.ashx"

// MARK: - URL数组
var SHOP_URLArray = NSMutableArray()

/// 新的朋友接口
var NEWFRIEND_LIST = "\(COMMON_PREFIX)/ifs/alyfriend.ashx"


/// 用户转账订单接口
var TRANPAY_ORDER = "\(COMMON_PREFIX)/ifs/tranpayorder.ashx"
