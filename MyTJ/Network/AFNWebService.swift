
//  WebService.swift
//  BrandsPK

//  Created by musharraf on 12/1/16.
//  Copyright © 2016 Stars Developer. All rights reserved.


import UIKit
import AFNetworking


//typealias SuccessBlock = (_ response: AnyObject) -> Void
//typealias FailureBlock = (_ response: AnyObject) -> Void

class AFNWebService: NSObject {
    
   let authorization = "VGhlU3BvcnRzT25UaGVHbzpUc090R0AxMjM="
    
    static let sharedInstance = AFNWebService()

//    private override init() {
//
//    } if (UserDefaults.standard.value(forKey: "schoolKey") != nil){

    private func urlString(subUrl: String) -> String {
        let key = UserDefaults.standard.value(forKey: "schoolKey")
        
//         return "http://schoolchain.com/demo/api/rest/\(String(describing: key!))/\(subUrl)"
                 return "https://www.tareequljannah.com/\(subUrl)"
        
       
    }

    func doGetData(parameters: Dictionary<String, AnyObject>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {

        self.getMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }

    func doPostData(parameters: Dictionary<String, AnyObject>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        
        self.postMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    func doPostDataWithImage(parameters: Dictionary<String, AnyObject>, method: String, image: UIImage?, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {

        self.postMethodWithParamsAndImage(parameters: parameters, forMethod: self.urlString(subUrl: method), image: image, success: success, fail: fail)
    }
    
    func doPostDataWithMedia(parameters: Dictionary<String, AnyObject>, method: String, media: URL?,name: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        
        self.postMethodWithParamsAndMedia(parameters: parameters, forMethod: self.urlString(subUrl: method), media: media, name: name, success: success, fail: fail)
    }
   

    private func postMethodWithParamsAndMedia(parameters: Dictionary <String, AnyObject>, forMethod: String, media: URL?, name: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()

        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        
        manager.requestSerializer.setValue(authorization, forHTTPHeaderField: "Authorization")
        
        
        if Utilities.isLoggedIn(){
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_token") as? String, forHTTPHeaderField: "oauth_token")
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_secret") as? String, forHTTPHeaderField: "oauth_secret")
        }
        print(media as Any)
        print(forMethod)
        
        manager.post(forMethod, parameters: parameters, constructingBodyWith: { (formData) in
            if media != nil {
                do {
                    try formData.appendPart(withFileURL: media!, name: name)
                } catch {
                    
                }
            }
        }, success: { (task, data) in
            
            success(data as AnyObject)
        }) { (task, err) in
            fail(err as AnyObject)
        }
    }

    
    
    private func postMethodWithParamsAndImage(parameters: Dictionary <String, AnyObject>, forMethod: String, image: UIImage?, success:@escaping SuccessBlock, fail:@escaping FailureBlock){

        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()

        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")

        manager.requestSerializer.setValue(authorization, forHTTPHeaderField: "Authorization")
        
        
        if Utilities.isLoggedIn(){
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_token") as? String, forHTTPHeaderField: "oauth_token")
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_secret") as? String, forHTTPHeaderField: "oauth_secret")
        }


//        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        manager.post(forMethod, parameters: parameters, success: { (task, formData) in
            
        if image != nil
        {
            var imgData = (image?.jpeg(.lowest))!
            
            print(imgData.count)
            
            (formData as AnyObject).appendPart(withFileData:imgData, name: "photo", fileName: "photo.png", mimeType: "image/jpeg")
//            (formData as AnyObject).appendPart(withFileData: imageData!, name: "photo", fileName: "photo.jpg",mimeType: "image/jpeg")
            
//            (formData as AnyObject).appendPart(withForm: "photo".data(using: String.Encoding.utf8, allowLossyConversion: true)!, name: "photo.jpg")
        }
            success(formData as AnyObject)
            
        }) { (task, error) in
            fail(error as AnyObject)
        }
    }
    
    private func postMethodWithParams(parameters: Dictionary <String, AnyObject>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
//      
        print(forMethod)
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()

        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        
        manager.requestSerializer.setValue(authorization, forHTTPHeaderField: "Authorization")
        
        if Utilities.isLoggedIn(){
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_token") as? String, forHTTPHeaderField: "oauth_token")
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_secret") as? String, forHTTPHeaderField: "oauth_secret")
        }

       
        manager.post(forMethod, parameters: parameters, success: { (task, formData) in
            
            success(formData as AnyObject)
        }) { (task, error) in
            fail(error as AnyObject)
        }
        
    }

    private func getMethodWithParams(parameters: Dictionary<String, AnyObject>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){

        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()

        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue(authorization, forHTTPHeaderField: "Authorization")
        
        
        if Utilities.isLoggedIn(){
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_token") as? String, forHTTPHeaderField: "oauth_token")
//            manager.requestSerializer.setValue(UserDefaults.standard.value(forKey: "oauth_secret") as? String, forHTTPHeaderField: "oauth_secret")
        }

        manager.get(forMethod, parameters: parameters, success: { (task, formData) in
            success(formData as AnyObject)
        }) { (task, error) in
            fail(error as AnyObject)
        }
 
    }
}
