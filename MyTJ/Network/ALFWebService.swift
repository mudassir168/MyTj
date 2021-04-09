//
//  WebService.swift
//  BrandsPK
//
//  Created by musharraf on 12/1/16.
//  Copyright © 2016 Stars Developer. All rights reserved.
//

import UIKit
import Alamofire
import MediaPlayer

typealias SuccessBlock = (_ response: AnyObject) -> Void
typealias FailureBlock = (_ response: AnyObject) -> Void
typealias ProgressBlock = (_ response: AnyObject) -> Void

class ALFWebService: NSObject {
    let authorization = "VGhlU3BvcnRzT25UaGVHbzpUc090R0AxMjM="
    
    static let sharedInstance = ALFWebService()

    private func urlString(subUrl: String) -> String {
        
//        let key = UserDefaults.standard.value(forKey: "schoolKey")
        
//        return "http://schoolchain.com/\(String(describing: key!))/api/rest/\(subUrl)"
        return "https://www.tareequljannah.com/\(subUrl)"
    }
    
    /****************************  ***********************************/
    /******************* GET Method with PARAMS **********************/
    /****************************  ***********************************/
    
    func doGetData(parameters: Dictionary<String, AnyObject>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        
        self.getMethodWithParams(parameters: parameters as Dictionary<String, AnyObject>, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    
    private func getMethodWithParams(parameters: Dictionary<String, AnyObject>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        print(forMethod)
        let manager = Alamofire.SessionManager.default
        let headers: HTTPHeaders?
        
        headers =  ["Authorization":authorization,"Accept":"application/json"]

        
        if Utilities.isLoggedIn(){
            
//            headers?["oauth_token"] = UserDefaults.standard.value(forKey: "oauth_token") as? String
//            headers?["oauth_secret"] = UserDefaults.standard.value(forKey: "oauth_secret") as? String
            print(headers!)
            }
        
        
        
        manager.request(forMethod, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            switch(response.result) {
            case .success(_):
                
                if response.result.value != nil{
                    success(response.result.value as AnyObject)
                }
                break
                
            case .failure(_):
                fail(response.result.error as AnyObject)
                break
            }
        }
    }
    
    
    /******************* END OF GET Method with PARAMS **********************/
    
    /****************************  ***********************************/
    /******************* GET Method with PARAMS **********************/
    /****************************  ***********************************/
    
    func doGetDataPrivacyAndTerms(parameters: Dictionary<String, AnyObject>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        
        self.getMethodWithParamsPrivacyAndTerms(parameters: parameters as Dictionary<String, AnyObject>, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    
    private func getMethodWithParamsPrivacyAndTerms(parameters: Dictionary<String, AnyObject>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        print(forMethod)
        let manager = Alamofire.SessionManager.default
        let headers: HTTPHeaders?
        headers =  ["Authorization":authorization,"Accept":"application/json"]
        
        manager.request(forMethod, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            switch(response.result) {
            case .success(_):
                
                if response.result.value != nil{
                    success(response.result.value as AnyObject)
                }
                break
                
            case .failure(_):
                fail(response.result.error as AnyObject)
                break
            }
        }
    }
    
    
    /******************* END OF GET Method with PARAMS **********************/
    

    
    /****************************  ***********************************/
    /******************* POST Method with PARAMS *********************/
    /****************************  ***********************************/
    
    func doPostData(parameters: Dictionary<String, AnyObject>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        print(parameters)
        self.postMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    private func postMethodWithParams(parameters: Dictionary<String, AnyObject>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        print(forMethod)
        let manager = Alamofire.SessionManager.default
        let headers: HTTPHeaders?
        
        headers =  ["Authorization":authorization,"Accept":"application/json"]

        
        if Utilities.isLoggedIn(){
            
//            headers?["oauth_token"] = UserDefaults.standard.value(forKey: "oauth_token") as? String
//            headers?["oauth_secret"] = UserDefaults.standard.value(forKey: "oauth_secret") as? String
            print(headers!)
        }

        
        manager.request(forMethod, method: .post, parameters: parameters,  headers: headers).responseJSON { response in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    success(response.result.value as AnyObject)
                }
                break
                
            case .failure(_):
                print(response)
                fail(response.result.error as AnyObject)
                break
            }
        }
        
    }
    /******************* END OF POST Method with PARAMS **********************/
    
    
    /****************************  ***********************************/
    /******************* DELETE Method with PARAMS *********************/
    /****************************  ***********************************/
    
    func doDeleteData(parameters: Dictionary<String, AnyObject>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        print(parameters)
        self.deleteMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    private func deleteMethodWithParams(parameters: Dictionary<String, AnyObject>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        
        let manager = Alamofire.SessionManager.default
        let headers: HTTPHeaders?
        
        headers =  ["Authorization":authorization,"Accept":"application/json"]
        
        
        if Utilities.isLoggedIn(){
            
//            headers?["oauth_token"] = UserDefaults.standard.value(forKey: "oauth_token") as? String
//            headers?["oauth_secret"] = UserDefaults.standard.value(forKey: "oauth_secret") as? String
            print(headers!)
        }
        
        
        manager.request(forMethod, method: .delete, parameters: parameters,  headers: headers).responseJSON { response in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    success(response.result.value as AnyObject)
                }
                break
                
            case .failure(_):
                print(response)
                fail(response.result.error as AnyObject)
                break
            }
        }
        
    }
    /******************* END OF DELETE Method with PARAMS **********************/

    
    
    /****************************  ***********************************/
    /******************* PUT Method with PARAMS *********************/
    /****************************  ***********************************/
    
    func doPutData(parameters: Dictionary<String, AnyObject>, method: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        print(parameters)
        self.putMethodWithParams(parameters: parameters, forMethod: self.urlString(subUrl: method), success: success, fail: fail)
    }
    
    private func putMethodWithParams(parameters: Dictionary<String, AnyObject>, forMethod: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        
        let manager = Alamofire.SessionManager.default
        let headers: HTTPHeaders?
        headers =  ["Authorization":authorization,"Accept":"application/json"]
        
        if Utilities.isLoggedIn(){
            
//            headers?["oauth_token"] = UserDefaults.standard.value(forKey: "oauth_token") as? String
//            headers?["oauth_secret"] = UserDefaults.standard.value(forKey: "oauth_secret") as? String
            print(headers!)
        }
        
        
        manager.request(forMethod, method: .put, parameters: parameters,  headers: headers).responseJSON { response in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    success(response.result.value as AnyObject)
                }
                break
                
            case .failure(_):
                fail(response.result.error as AnyObject)
                break
            }
        }
        
    }
    /******************* END OF PUT Method with PARAMS **********************/
    
    
    
    /****************************  ***********************************/
    /*************** POST Method with PARAMS and IMAGE *******************/
    /****************************  ***********************************/
    func doPostDataWithImage(parameters: [String:String], method: String, image: UIImage?, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
    
        self.postMethodWithParamsAndImage(parameters: parameters, forMethod: self.urlString(subUrl: method), image: image, success: success, fail: fail)
    }
    
    private func postMethodWithParamsAndImage(parameters: [String:String], forMethod: String, image: UIImage?, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        
        let manager = Alamofire.SessionManager.default
        
        let headers: HTTPHeaders?
        
        headers =  ["Authorization":authorization,"Accept":"application/json"]
        
        if Utilities.isLoggedIn(){
            
//            headers?["oauth_token"] = UserDefaults.standard.value(forKey: "oauth_token") as? String
//            headers?["oauth_secret"] = UserDefaults.standard.value(forKey: "oauth_secret") as? String
            print(headers!)
        }
       
            manager.upload(
                multipartFormData: { multipartFormData in
                    print(parameters)
                    print(image as Any)
                    if image != nil {
        
                       var imgData = (image?.jpeg(.lowest))!
                        
                        print(imgData.count)
                        
                        multipartFormData.append(imgData, withName: "photo", fileName: "photo.png", mimeType: "image/jpeg")
                        
                    }
                    if !(parameters.isEmpty) {
                        for (key, value) in parameters {
                            print("key: \(key) -> val: \(value)")
//                            if let dic = value as? Dictionary<String,AnyObject>{
//                                print(key)
//                                print(value)
//                                do {
//                                    let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
//                                    let str = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
//                                    //                                multipartFormData.append(jsonData, withName: key)
//                                    multipartFormData.append(str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
//                                } catch {
//                                    print(error.localizedDescription)
//                                }
//                                
//                            }else{
                                multipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
//                            }
                            
                        }
                    }
                    print(multipartFormData)
            },
                to: forMethod,  method: .post, headers: headers, encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            
                            success(response.result.value as AnyObject)
                        }
                    case .failure(let encodingError):
                        
                        fail(encodingError as AnyObject)
                    }
            })
        
        
        
        
    }
    func doPostDataWithMultiImage(parameters: [String:String], method: String, image: [UIImage], success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        
        self.postMethodWithParamsAndMultiImage(parameters: parameters, forMethod: self.urlString(subUrl: method), image: image, success: success, fail: fail)
    }
    
    private func postMethodWithParamsAndMultiImage(parameters: [String:String], forMethod: String, image: [UIImage], success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        
        let manager = Alamofire.SessionManager.default
        
        let headers: HTTPHeaders?
        
        headers =  ["Authorization":authorization,"Accept":"application/json"]
        
        
        if Utilities.isLoggedIn(){
            
//            headers?["oauth_token"] = UserDefaults.standard.value(forKey: "oauth_token") as? String
//            headers?["oauth_secret"] = UserDefaults.standard.value(forKey: "oauth_secret") as? String
            print(headers!)
        }
        
        manager.upload(
            multipartFormData: { multipartFormData in
                print(parameters)
                print(image as Any)
                if !image.isEmpty {
                    for i in 0..<image.count {
                        let img = image[i]
                        let imgData = (img.jpeg(.lowest))!
                        multipartFormData.append(imgData, withName: "image_\(i)", fileName: "image_\(i).png", mimeType: "image/jpeg")
                    }

                }
//                if image != nil {
//                    
//                    var imgData = (image?.jpeg(.lowest))!
//                    
//                    print(imgData.count)
//                    
//                    multipartFormData.append(imgData, withName: "photo", fileName: "photo.png", mimeType: "image/jpeg")
//                    
//                }
                if !(parameters.isEmpty) {
                    for (key, value) in parameters {
                        print("key: \(key) -> val: \(value)")
                        if let dic = value as? Dictionary<String,AnyObject>{
                            print(key)
                            print(value)
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
                                let str = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
                                //                                multipartFormData.append(jsonData, withName: key)
                                multipartFormData.append(str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                        }else{
                            multipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                        }
                        
                    }
                }
                print(multipartFormData)
        },
            to: forMethod,  method: .post, headers: headers, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        
                        success(response.result.value as AnyObject)
                    }
                case .failure(let encodingError):
                    
                    fail(encodingError as AnyObject)
                }
        })
        
        
        
        
    }
    /******************* END OF POST Method with PARAMS and IMAGE **********************/
    
    /****************************  ***********************************/
    /*************** POST Method with PARAMS and DOCX *******************/
    /****************************  ***********************************/
    func doPostDataWithDocx(parameters: [String:String], method: String, data: URL?, name: String, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        
        self.postMethodWithParamsAndDocx(parameters: parameters, forMethod: self.urlString(subUrl: method), filename: data,name: name, success: success, fail: fail)
    }
    
    private func postMethodWithParamsAndDocx(parameters: [String:String], forMethod: String, filename: URL?,name: String, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        
        let manager = Alamofire.SessionManager.default
        
        let headers: HTTPHeaders?
        
        headers =  ["Authorization":authorization,"Accept":"application/json"]
        
        
        if Utilities.isLoggedIn(){
            
//            headers?["oauth_token"] = UserDefaults.standard.value(forKey: "oauth_token") as? String
//            headers?["oauth_secret"] = UserDefaults.standard.value(forKey: "oauth_secret") as? String
            print(headers!)
        }
        
        manager.upload(
            multipartFormData: { multipartFormData in
                print(parameters)
                print(filename as Any)
                if filename != nil {
                    
                    multipartFormData.append(filename!, withName: name)
                }
                if !(parameters.isEmpty) {
                    for (key, value) in parameters {
                        print("key: \(key) -> val: \(value)")
                        if let dic = value as? Dictionary<String,AnyObject>{
                            print(key)
                            print(value)
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
                                let str = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
                                //                                multipartFormData.append(jsonData, withName: key)
                                multipartFormData.append(str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                        }else{
                            multipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                        }
                        
                    }
                }
                print(multipartFormData)
        },
            to: forMethod,  method: .post, headers: headers, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        
                        success(response.result.value as AnyObject)
                    }
                case .failure(let encodingError):
                    
                    fail(encodingError as AnyObject)
                }
        })

    }
    
    func doPostDataWithMedia(parameters: [String:String], method: String, data: URL?,name: String, success:@escaping SuccessBlock, progress: @escaping ProgressBlock, fail: @escaping FailureBlock) {
        
        self.postMethodWithParamsAndMedia(parameters: parameters, forMethod: self.urlString(subUrl: method), filename: data, name: name, success: success,progress: progress, fail: fail)
    }
    
    private func postMethodWithParamsAndMedia(parameters: [String:String], forMethod: String, filename: URL?,name: String, success:@escaping SuccessBlock,progress: @escaping ProgressBlock, fail:@escaping FailureBlock){
        
        let manager = Alamofire.SessionManager.default
        
        let headers: HTTPHeaders?
        
       headers =  ["Authorization":authorization,"Accept":"application/json"]
        
        
        if Utilities.isLoggedIn(){
            
//            headers?["oauth_token"] = UserDefaults.standard.value(forKey: "oauth_token") as? String
//            headers?["oauth_secret"] = UserDefaults.standard.value(forKey: "oauth_secret") as? String
            print(headers!)
        }
        
        manager.upload(
            multipartFormData: { multipartFormData in
                print(parameters)
                print(filename as Any)
//                var data: Data?
//                do {
//                    data = try NSData(contentsOf: filename!, options: .uncached) as Data
//                    print(data!)
//                } catch {
//                    print(error.localizedDescription)
//                }
                
//                if data != nil {
                    multipartFormData.append(filename!, withName: name)
//                    multipartFormData.append(filename!, withName: "filename")
                    
//                }
                if !(parameters.isEmpty) {
                    for (key, value) in parameters {
                        print("key: \(key) -> val: \(value)")
                        if let dic = value as? Dictionary<String,AnyObject>{
                            print(key)
                            print(value)
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
                                let str = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
                                //                                multipartFormData.append(jsonData, withName: key)
                                multipartFormData.append(str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                        }else{
                            multipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                        }
                        
                    }
                }
                print(multipartFormData)
        },
            to: forMethod,  method: .post, headers: headers, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                        progress(Progress.fractionCompleted as AnyObject)
                    })
                    upload.responseJSON { response in
                        
                        success(response.result.value as AnyObject)
                    }
                case .failure(let encodingError):
                    
                    fail(encodingError as AnyObject)
                }
        })
        
        
        
        
    }

    
    /******************* END OF POST Method with PARAMS and DOCX **********************/
    
    
    func doPostDataWithMusic(parameters: [String:String], method: String, data: URL?,name: String, image: UIImage?, success:@escaping SuccessBlock, fail: @escaping FailureBlock) {
        
        self.postMethodWithParamsAndMusic(parameters: parameters, forMethod: self.urlString(subUrl: method), filename: data, name: name, image: image, success: success, fail: fail)
    }
    
    private func postMethodWithParamsAndMusic(parameters: [String:String], forMethod: String, filename: URL?,name: String, image: UIImage?, success:@escaping SuccessBlock, fail:@escaping FailureBlock){
        
        let manager = Alamofire.SessionManager.default
        
        let headers: HTTPHeaders?
        
        headers =  ["Authorization":authorization,"Accept":"application/json"]
        
        
        if Utilities.isLoggedIn(){
            
//            headers?["oauth_token"] = UserDefaults.standard.value(forKey: "oauth_token") as? String
//            headers?["oauth_secret"] = UserDefaults.standard.value(forKey: "oauth_secret") as? String
            print(headers!)
        }
        
        manager.upload(
            multipartFormData: { multipartFormData in
                print(parameters)
                print(filename as Any)
//                var data: Data?
//                do {
//                    data = try NSData(contentsOf: filename!, options: .uncached) as Data
//                    print(data)
//                } catch {
//                    
//                }
                
//                if data != nil {
//                    multipartFormData.append(data!, withName: name)
//
//                }
                if filename != nil {
                    
                    multipartFormData.append(filename!, withName: name)
                }
                if image != nil {
                    
                    var imgData = (image?.jpeg(.lowest))!
                    
                    print(imgData.count)
                    
                    multipartFormData.append(imgData, withName: "photo", fileName: "photo.png", mimeType: "image/jpeg")
                    
                } else {
                    
                }
                
                if !(parameters.isEmpty) {
                    for (key, value) in parameters {
                        print("key: \(key) -> val: \(value)")
                        if let dic = value as? Dictionary<String,AnyObject>{
                            print(key)
                            print(value)
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
                                let str = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
                                //                                multipartFormData.append(jsonData, withName: key)
                                multipartFormData.append(str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                        }else{
                            multipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                        }
                        
                    }
                }
                print(multipartFormData)
        },
            to: forMethod,  method: .post, headers: headers, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        
                        success(response.result.value as AnyObject)
                    }
                case .failure(let encodingError):
                    
                    fail(encodingError as AnyObject)
                }
        })

    }
    
    
    /******************* END OF POST Method with PARAMS and DOCX **********************/

    
   }
