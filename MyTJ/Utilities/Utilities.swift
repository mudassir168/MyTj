    
//
//  Utilities.swift
//  CollegEcorps
//
//  Created by musharraf on 03/08/2016.
//  Copyright © 2016 musharraf. All rights reserved.
//

import UIKit
import SystemConfiguration
import AVFoundation
import Photos


class Utilities: NSObject {
    
      static let sharedInstance = Utilities()
      static var player: AVPlayer?
    
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    class func showAlertWithTitle(title: String, withMessage: String, withNavigation: UIViewController) {
        
        let alertController : UIAlertController = UIAlertController(title: title, message: withMessage, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction : UIAlertAction = UIAlertAction(title: "OK", style: .cancel){
            ACTION -> Void in
        }
        alertController.addAction(cancelAction)
        withNavigation.present(alertController, animated: true, completion: nil)
    }
    
    class func isLoggedIn() -> Bool{
        
        var isLogin : Bool = false
        if (UserDefaults.standard.value(forKey: "email") != nil) && (UserDefaults.standard.value(forKey: "password") != nil){
            isLogin = true
        }
        
        return isLogin
        
    }
    
    class func isGuest() -> Bool{
        
        var isLogin : Bool = false
        
        if (UserDefaults.standard.value(forKey: "oauth_token") == nil){
            
            isLogin = true
        }
        
        return isLogin
        
    }
    
    class func isGuestUser() -> Bool{
        
        if UserDefaults.standard.value(forKey: "levelId") as! String == "5"
        {
            return true
        }else{
            
            return false
        }
    }
    
    class func dateFromStringConvertToString(_ stringDate: String) -> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
//        dateFormatter.dateFormat = "yyyy-M-d"
        let date = dateFormatter.date(from: stringDate)
        //        dateFormatter.dateFormat =  "hh:mm a"
        //        let  newTime =  dateFormatter.string(from: date!)
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        if date == nil {
            return ""
        } else {
            let newDate = dateFormatter.string(from: date!)
            return newDate
        }
        
    }
    
    class func dateFromString(_ stringDate: String) -> NSDate  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: stringDate)
        if date == nil {
            return Date() as NSDate
        } else {
            return date! as NSDate
        }
//        print(date!)
//        return date! as NSDate
    }
    

    class func stringFromDate(_ date: Date) -> String  {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    class func stringFromDatewithoutSecAndAM(_ date: Date) -> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

    class func stringFromDateWithoutSec(_ date: Date) -> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    class func showAlertForGuestUser(controller: UIViewController){
        
        
        let alertController = UIAlertController(title: "Guest User", message: "Please Sign In/Register to Proceed", preferredStyle: .alert)
        
        let signInAction = UIAlertAction(title: "Sign In", style: .default) { (action) in
            
                    Utilities.guestLogout()
        }
        
        let cancelAction = UIAlertAction(title: "Continue", style: .cancel) { (action) in
            
            
        }
        alertController.addAction(signInAction)
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    
   class func guestLogout(){
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)

        let app = UIApplication.shared.delegate as! AppDelegate
    }

    
    class func logout(){
//        UserDefaults.standard.removeObject(forKey: "oauth_token")
//        UserDefaults.standard.removeObject(forKey: "oauth_secret")
//        UserDefaults.standard.removeObject(forKey: "name")
//        UserDefaults.standard.removeObject(forKey: "id")
//        UserDefaults.standard.removeObject(forKey: "image")
        
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "oauth_token")
        UserDefaults.standard.removeObject(forKey: "oauth_secret")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "image")
        UserDefaults.standard.removeObject(forKey: "timezone")
        UserDefaults.standard.removeObject(forKey: "locale")
        UserDefaults.standard.removeObject(forKey: "alarm")
        UserDefaults.standard.removeObject(forKey: "type")
        UserDefaults.standard.removeObject(forKey: "classes")
        
//        let appDomain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        
        let app = UIApplication.shared.delegate as! AppDelegate
        
    }


    
    
    class func isSelfUser(userID: String) -> Bool{
        
        if (UserDefaults.standard.value(forKey: "id") as? String == userID) {
            
            return true
        }
        
        return false
        

    }
   
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
        
    }
    
    class func isValidEmail(testStr:String) -> Bool
    {
        // println("validate calendar: \(testStr)")
        
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        print(testStr)
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        
        
    }
    
    class func isValidUrl(userURL: String?) -> Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: userURL)
//        let userURL =  userURL
//        
//        do {
//            let checkReg = try NSRegularExpression(pattern: "(http|https)://([A-Z]|[a-z].)|([A-Z]|[a-z]|[0-9]+)*.([a-z]|[A-Z])", options: .caseInsensitive)
//            
//            if checkReg.firstMatch(in: userURL!, options: .reportCompletion, range: NSMakeRange(0, (userURL?.lengthOfBytes(using: String.Encoding.utf8))!)) != nil {
//                
//                if let url = NSURL(string: userURL!) {
//                    if UIApplication.shared.canOpenURL(url as URL) {
//                        
//                        return true
//                    }
//                }
//                return false
//            }
//            
//        }
//            
//        catch
//        {
//            print("Error")
//        }
//        
//        
//        return false
    }
    
    public func getThumbnailFrom(path: URL) -> UIImage? {
        
//        let asset = AVAsset(URL: path)
        let asset = AVAsset(url: path)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        
        var time = asset.duration
        time.value = min(time.value, 2)
        
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            print("error")
            return nil
        }        
    }
    public func showActivityIndicatory(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
//        container.backgroundColor = UIColor.init(netHex: 0xffffff).withAlphaComponent(0.3) //UIColorFromHex(0xffffff, alpha: 0.3)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.white
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,y :loadingView.frame.size.height / 2)
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        uiView.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    
    public func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        uiView.isUserInteractionEnabled = true
        container.removeFromSuperview()
    }
    class func dateFromStringWithFormat(_ stringDate: String, format: String) -> NSDate  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
//        dateFormatter.timeZone = NSTimeZone(name: "CA") as TimeZone!
        let date = dateFormatter.date(from: stringDate)
        if date == nil {
            return Date() as NSDate
        } else {
            return date! as NSDate
        }
        //        print(date!)
        //        return date! as NSDate
    }
    class func stringFromDateWithFormat(_ date: Date, format: String) -> String  {
        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print(format)
        dateFormatter.dateFormat = format
//        dateFormatter.timeZone = NSTimeZone(name: "CAN") as! TimeZone
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    class func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        let dateStr = self.stringFromDateWithFormat(date as Date, format: "MMM dd, yyyy")
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        var components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        components.hour = components.hour!
        if (components.year! >= 2) {
            
            //            return "\(components.year!) years ago"
            return dateStr
        } else if (components.year! >= 1){
            if (numericDates){
                //                return "1 year ago"
                return dateStr
            } else {
                //                return "Last year"
                return dateStr
            }
        } else if (components.month! >= 2) {
            //            return "\(components.month!) months ago"
            return dateStr
        } else if (components.month! >= 1){
            if (numericDates){
                //                return "1 month ago"
                return dateStr
            } else {
                //                return "Last month"
                return dateStr
            }
        } else if (components.weekOfYear! >= 2) {
            //            return "\(components.weekOfYear!) weeks ago"
            return dateStr
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                //                return "1 week ago"
                return dateStr
            } else {
                //                return "Last week"
                return dateStr
            }
        } else if (components.day! > 3) {
            return dateStr
        }  else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "one minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    
    class func getHtmlLabel(text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = stringFromHtml(string: text)
        return label
    }
    
    class func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d,
                                                 options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                                 documentAttributes: nil)
                return str
            }
        } catch {
        }
        return nil
    }
    
   class func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        print(asset.pixelWidth)
        print(asset.pixelHeight)
        manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }

    
    func toolbar(doneFunc: Selector) -> UIToolbar{
        let toolb = UIToolbar(frame: CGRect(x: 0, y: 0, width: ScreenSize.screenWidth, height: 46))
        toolb.sizeToFit()
        let barButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action:doneFunc)
        toolb.setItems([barButton,doneButton], animated: true)
        return toolb
    }
}
