//
//	ZDxListData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ZDxListData : NSObject, NSCoding{

	var headImg : String!
	var id : Int!
	var isFriend : Int!
	var msg : String!
	var noticeNum : Int!
	var submitTime : String!
	var trueName : String!
	var userName : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		headImg = dictionary["HeadImg"] as? String
		id = dictionary["Id"] as? Int
		isFriend = dictionary["IsFriend"] as? Int
		msg = dictionary["Msg"] as? String
		noticeNum = dictionary["NoticeNum"] as? Int
		submitTime = dictionary["SubmitTime"] as? String
		trueName = dictionary["TrueName"] as? String
		userName = dictionary["UserName"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if headImg != nil{
			dictionary["HeadImg"] = headImg
		}
		if id != nil{
			dictionary["Id"] = id
		}
		if isFriend != nil{
			dictionary["IsFriend"] = isFriend
		}
		if msg != nil{
			dictionary["Msg"] = msg
		}
		if noticeNum != nil{
			dictionary["NoticeNum"] = noticeNum
		}
		if submitTime != nil{
			dictionary["SubmitTime"] = submitTime
		}
		if trueName != nil{
			dictionary["TrueName"] = trueName
		}
		if userName != nil{
			dictionary["UserName"] = userName
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         headImg = aDecoder.decodeObject(forKey: "HeadImg") as? String
         id = aDecoder.decodeObject(forKey: "Id") as? Int
         isFriend = aDecoder.decodeObject(forKey: "IsFriend") as? Int
         msg = aDecoder.decodeObject(forKey: "Msg") as? String
         noticeNum = aDecoder.decodeObject(forKey: "NoticeNum") as? Int
         submitTime = aDecoder.decodeObject(forKey: "SubmitTime") as? String
         trueName = aDecoder.decodeObject(forKey: "TrueName") as? String
         userName = aDecoder.decodeObject(forKey: "UserName") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if headImg != nil{
			aCoder.encode(headImg, forKey: "HeadImg")
		}
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if isFriend != nil{
			aCoder.encode(isFriend, forKey: "IsFriend")
		}
		if msg != nil{
			aCoder.encode(msg, forKey: "Msg")
		}
		if noticeNum != nil{
			aCoder.encode(noticeNum, forKey: "NoticeNum")
		}
		if submitTime != nil{
			aCoder.encode(submitTime, forKey: "SubmitTime")
		}
		if trueName != nil{
			aCoder.encode(trueName, forKey: "TrueName")
		}
		if userName != nil{
			aCoder.encode(userName, forKey: "UserName")
		}

	}

}
