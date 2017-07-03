//
//  RequestCommon.swift
//  WangBoBi
//
//  Created by 郑东喜 on 2017/6/20.
//  Copyright © 2017年 郑东喜. All rights reserved.
//  请求链接常量

import Foundation

/// 登录链接
let LOGIN_URL = "http://192.168.1.10:8010/ifs/login.ashx"


//http://192.168.1.10:8010/ifs/passfind.ashx  忘记密码接口  返回格式：JSON
//请求参数：email  邮箱地址 ，pwd  登陆密码MD5加密密文，code 验证码       ac  操作类型值（semail：发送验证码，femail：重置密码）
/// 忘记密码链接
let FORGETPASS_URL = "http://192.168.1.10:8010/ifs/passfind.ashx"

/// 发生验证码
let SENDAUTHO_URL = ""

/// 邮箱验证码
let EMAILSIGNED_URL = ""

/// 登录密码修改
let MODIFYLOGINPASS_URL = ""

/// 注册请求
let RIGISTER_URL = "http://192.168.1.10:8010/ifs/reg.ashx"

/// 验证token借口
let CHECK_TOKEN = ""

/// 首页请求接口
let INDEX_URL = "http://192.168.1.10:8010/ifs/index.ashx"

/// 双重验证
let DOB_AUTH = "http://192.168.1.10:8010/ifs/dobauth.ashx"

/// 修改登录密码
let CHANGELOGIN_PASS = "http://192.168.1.10:8010/ifs/resetpwd.ashx"

/// 绑定手机接口
let BIND_PHONE = "http://192.168.1.10:8010/ifs/toiv.ashx"

/// 支付密码
let PAY_PASS = "http://192.168.1.10:8010/ifs/resetpaypwd.ashx"


/// 上传图片
let UPLOAD_IMGDATA = "http://192.168.1.10:8010/ifs/headimg.ashx"
