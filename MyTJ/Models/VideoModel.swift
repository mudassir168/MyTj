//
//  VideoModel.swift
//  Tareeq
//
//  Created by Mudassir Abbas on 07/10/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class VideoModel:  NSObject, NSCoding{
    
    var desc : String!
    var howOld : String!
    var videoURL : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        desc = dictionary["desc"] as? String
        howOld = dictionary["howOld"] as? String
        videoURL = dictionary["videoURL"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if desc != nil{
            dictionary["desc"] = desc
        }
        if howOld != nil{
            dictionary["howOld"] = howOld
        }
        if videoURL != nil{
            dictionary["videoURL"] = videoURL
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        desc = aDecoder.decodeObject(forKey: "desc") as? String
        howOld = aDecoder.decodeObject(forKey: "howOld") as? String
        videoURL = aDecoder.decodeObject(forKey: "videoURL") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if desc != nil{
            aCoder.encode(desc, forKey: "desc")
        }
        if howOld != nil{
            aCoder.encode(howOld, forKey: "howOld")
        }
        if videoURL != nil{
            aCoder.encode(videoURL, forKey: "videoURL")
        }
    }
}

