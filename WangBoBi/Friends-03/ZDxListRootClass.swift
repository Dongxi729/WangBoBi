//
//	ZDxListRootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ZDxListRootClass : NSObject, NSCoding{

	var data : [ZDxListData]!
	var msg : String!
	var status : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		data = [ZDxListData]()
		if let dataArray = dictionary["Data"] as? [[String:Any]]{
			for dic in dataArray{
				let value = ZDxListData(fromDictionary: dic)
				data.append(value)
			}
		}
		msg = dictionary["Msg"] as? String
		status = dictionary["Status"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if data != nil{
			var dictionaryElements = [[String:Any]]()
			for dataElement in data {
				dictionaryElements.append(dataElement.toDictionary())
			}
			dictionary["Data"] = dictionaryElements
		}
		if msg != nil{
			dictionary["Msg"] = msg
		}
		if status != nil{
			dictionary["Status"] = status
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         data = aDecoder.decodeObject(forKey :"Data") as? [ZDxListData]
         msg = aDecoder.decodeObject(forKey: "Msg") as? String
         status = aDecoder.decodeObject(forKey: "Status") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if data != nil{
			aCoder.encode(data, forKey: "Data")
		}
		if msg != nil{
			aCoder.encode(msg, forKey: "Msg")
		}
		if status != nil{
			aCoder.encode(status, forKey: "Status")
		}

	}

}