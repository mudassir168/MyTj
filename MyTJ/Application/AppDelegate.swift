//
//  AppDelegate.swift
//  LiveCricketMatch
//
//  Created by Mudassir Abbas on 23/09/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit
import Foundation
import AudioToolbox
import AVFoundation
import UserNotifications

var navbarClr = "#048B9D"
var labelColor = "#005A71"
var baseUrlImg = "http://globalsportsonthego.com"
var notificationMode = false
let app = UIApplication.shared.delegate as! AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,AVAudioPlayerDelegate {

    var window: UIWindow?
     var audioPlayer: AVAudioPlayer?
//    var alarmModel: Alarms = Alarms()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (accepted, _) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12)], for: .selected)

        UITabBar.appearance().barTintColor = UIColor(hexString: "#28A2F1")

        let bar = UINavigationBar.appearance()
        
        bar.barTintColor = UIColor(hexString: navbarClr)
        bar.tintColor = UIColor.white
        bar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        var error: NSError?
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch let error1 as NSError{
            error = error1
            print("could not set session. err:\(error!.localizedDescription)")
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error1 as NSError{
            error = error1
            print("could not active session. err:\(error!.localizedDescription)")
        }
        window?.tintColor = UIColor.red
        isLogin()
        return true
    }
    
    func isLogin()
    {
        if UserDefaults.standard.value(forKey: "email") != nil && UserDefaults.standard.value(forKey: "password") != nil{
            let vc = MainVC()
            vc.view.contentMode = .scaleToFill
//            vc.selectedIndex = 2
            let nac = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = nac
        }else{
            let vc = MainVC()
            vc.view.contentMode = .scaleToFill
            
            let nac = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = nac
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
//        playSound("tickle")
        audioPlayer?.pause()
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//        if audioPlayer?.isPlaying ?? false{
            audioPlayer?.pause()
//        }
        if notificationMode{
            let alert = UIAlertController(title: "Alert", message: "Your next appointment is on ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "SET REMINDER", style: .default, handler: { (action) in
                
            }))
            alert.addAction(UIAlertAction(title: "NO, THANKS", style: .cancel, handler: { (action) in
                
            }))
            window?.inputViewController?.navigationController?.present(alert, animated: true, completion: nil)
            //            self.present(alert, animated: true, completion: nil)
            notificationMode = false
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        if audioPlayer?.isPlaying ?? false{
//            audioPlayer?.play()
//        }
        if notificationMode{
            let alert = UIAlertController(title: "Alert", message: "Your next appointment is on ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "SET REMINDER", style: .default, handler: { (action) in
            }))
            alert.addAction(UIAlertAction(title: "NO, THANKS", style: .cancel, handler: { (action) in
            }))
            window?.inputViewController?.navigationController?.present(alert, animated: true, completion: nil)
            notificationMode = false
        }
        audioPlayer?.pause()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
    //AlarmApplicationDelegate protocol
    func playSound(_ soundName: String) {
        
        //vibrate phone first
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        //set vibrate callback
        AudioServicesAddSystemSoundCompletion(SystemSoundID(kSystemSoundID_Vibrate),nil,
                                              nil,
                                              { (_:SystemSoundID, _:UnsafeMutableRawPointer?) -> Void in
                                                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        },
                                              nil)
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "mp3")!)
        
        var error: NSError?
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
        
        if let err = error {
            print("audioPlayer error \(err.localizedDescription)")
            return
        } else {
            audioPlayer!.delegate = self
            audioPlayer!.prepareToPlay()
        }
        
        //negative number means loop infinity
        audioPlayer!.numberOfLoops = -1
        audioPlayer!.play()
    }
    


}
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "textNotification" {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            guard let rootVc = appDelegate.window?.rootViewController else { return }
            let alert = UIAlertController(title: "Notification", message: "It's my notification", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            rootVc.present(alert, animated: true, completion: nil)
        }
    }
}

