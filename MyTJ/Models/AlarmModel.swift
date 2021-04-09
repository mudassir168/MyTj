//
//  AlarmModel.swift
//  Tareeq
//
//  Created by Mudassir Abbas on 11/10/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class AlarmModel:  NSObject{
    
    var teacherName: String!
    var classDate: String!
    var time:String!
    var classUrl: String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        
        teacherName = dictionary["teacherName"] as? String
        classDate = dictionary["classDate"] as? String
        classUrl = dictionary["classURL"] as? String
        
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
}
