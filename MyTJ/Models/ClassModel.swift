//
//  ClassModel.swift
//  Tareeq
//
//  Created by Mudassir Abbas on 08/10/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class ClassModel: NSObject, NSCoding{
    
    var classDate : String!
    var classURL : String!
    var stdName : String!
    var name : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        classDate = dictionary["classDate"] as? String
        classURL = dictionary["classURL"] as? String
        stdName = dictionary["StudentName"] as? String
        name = dictionary["Name"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if classDate != nil{
            dictionary["classDate"] = classDate
        }
        if classURL != nil{
            dictionary["classURL"] = classURL
        }
        if stdName != nil{
            dictionary["stdName"] = stdName
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        classDate = aDecoder.decodeObject(forKey: "classDate") as? String
        classURL = aDecoder.decodeObject(forKey: "classURL") as? String
        stdName = aDecoder.decodeObject(forKey: "stdName") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if classDate != nil{
            aCoder.encode(classDate, forKey: "classDate")
        }
        if classURL != nil{
            aCoder.encode(classURL, forKey: "classURL")
        }
        if stdName != nil{
            aCoder.encode(stdName, forKey: "stdName")
        }
        if name != nil{
            aCoder.encode(stdName, forKey: "name")
        }
    }
}
