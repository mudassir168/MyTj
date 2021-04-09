//
//  DashboardVC.swift
//  Tareeq
//
//  Created by Mudassir Abbas on 08/10/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit
import UserNotifications
import BRCountDownView


class DashboardVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var userNameLbl: UILabel!
    //MARK: - VARIABLES
    var dic = Dictionary<String,AnyObject>()
    var classArr = [ClassModel]()
    var seconds = 0
    var userTypeTag = 0
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
        if let decodedData = UserDefaults.standard.object(forKey: "classes") as? Data{
            if let classAr = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [ClassModel]{
                self.classArr.removeAll()
                self.classArr = classAr
                self.tblView.reloadData()
            }
            
        }
    }
    //MARK: - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
//        self.parent?.navTitle(titel: "Dashboard")
        let logout = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .plain, target: self, action: #selector(self.Logout(_:)))
        let refreh = UIBarButtonItem(image: #imageLiteral(resourceName: "refresh"), style: .plain, target: self, action: #selector(self.HandleRefresh(_:)))
        if self.parent?.parent != nil{
            self.parent?.parent?.navTitle(titel: "Dashboard")
            self.parent?.parent?.navigationItem.rightBarButtonItems = [logout,refreh]
        }
        self.parent?.navigationItem.rightBarButtonItems = [logout,refreh]
    }
    //MARK: - LOGOUT
    @objc func Logout(_ sender: UIBarButtonItem)
    {
        Utilities.logout()
        
        app.isLogin()
    }
    //MARK: - HANDLE REFRESH
    @objc func HandleRefresh(_ sender: UIBarButtonItem)
    {
        if  UserDefaults.standard.value(forKey: "email") as? String != nil  && UserDefaults.standard.value(forKey: "password") as? String != nil
        {
            dic["userName"] = (UserDefaults.standard.value(forKey: "email") as? String) as AnyObject
            dic["passCode"] = (UserDefaults.standard.value(forKey: "password") as? String) as AnyObject
            LoadData()
        }
    }
    //MARK: - CALL BROWSER
    @objc func GoToUrl(_ sender: UIButton)
    {
        let url = URL(string: "https://www.tareequljannah.com/StudentSignIn")
        UIApplication.shared.open(url!, options: ["asd":"asdfaf"], completionHandler: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - TABLE VIEW DELEGATES
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if classArr.count == 0{
            return 1
        }
        return classArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //============EMPTY CELL ==============//
        if classArr.count == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoCell", for: indexPath) as! ClassCell
            cell.goBtn.addTarget(self, action: #selector(self.GoToUrl(_:)), for: .touchUpInside)
            return cell
        }
        var identifier = "ClassCell1"
        if indexPath.row == 0{
            identifier = "ClassCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ClassCell
        //============ GET DATE  WITH FORMATE =========//
        let obj = classArr[indexPath.row]
        let date = obj.classDate
        let total = date?.components(separatedBy: ";")
         let testDat = Utilities.dateFromStringWithFormat(total![0], format: "yyyy-MM-dd hh:mm:ss a")
        let dateStr = Utilities.stringFromDateWithFormat(testDat as Date, format: "EEE, MMM dd")
        cell.dateLbl.text = "\(dateStr)"
        let firstDat = Utilities.dateFromStringWithFormat(total![0], format: "yyyy-MM-dd hh:mm:ss a")
        let lastDat = Utilities.dateFromStringWithFormat(total![1], format: "yyyy-MM-dd hh:mm:ss a")
        let firstTime = Utilities.stringFromDateWithFormat(firstDat as Date, format: "hh:mm a")
        let lastTime = Utilities.stringFromDateWithFormat(lastDat as Date, format: "hh:mm a")
        cell.durationLbl.text = "\(firstTime)-\(lastTime)"
        //=========== SET FIRST ALARM CELL ============ //
        if indexPath.row == 0{
            cell.timer.layer.borderWidth = 4
            cell.timer.layer.borderColor = UIColor.red.cgColor
            let dateFormatter = DateFormatter()
            let timeZone = NSTimeZone(name: "UTC+05:00")
            dateFormatter.timeZone = timeZone as! TimeZone
            dateFormatter.locale = Locale.current
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss a" //Your date format
            let endDate = dateFormatter.date(from: total![0])
            let calendar = NSCalendar.current
            var unitFlags = Set<Calendar.Component>()
            unitFlags.insert(.second)
            unitFlags.insert(.minute)
            unitFlags.insert(.hour)
            unitFlags.insert(.day)
            let startDate = Date()
            let dateComponents = calendar.dateComponents(unitFlags, from: startDate, to: endDate!)
            let seconds = dateComponents.second
            let minutes = dateComponents.minute
            let day = dateComponents.day
            let hour = dateComponents.hour
            let HtoS = hour! * 3600
            let MtoS = minutes! * 60
            let DtoS = day! * 86400
            var finalSeconds = HtoS + MtoS + DtoS
            if userTypeTag == 1{
               finalSeconds = finalSeconds - 900
            }else{
                finalSeconds = finalSeconds - 1800
            }
            cell.seconds = finalSeconds
            cell.contentView.addSubview(cell.countdownView)
            
            cell.countdownView.center = cell.timer.center
            cell.urlLbl.text = "\(obj.classURL!)"
            cell.goBtn.addTarget(self, action: #selector(self.CallUrlIndex(_:)), for: .touchUpInside)
        }
        //==================== END ====================//
        cell.nameLbl.text = obj.name
        if obj.stdName != nil && indexPath.row == 0{
            cell.stdNameLbl.text = obj.stdName ?? ""
        }else { }
        cell.contentView.dropShadow()
        return cell
    }
    //MARK: - FUNCTION FOR NOTIFCATION PLAY SOUND
    @objc func alertation(_ timer: Timer)
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.playSound("tickle")
    }
    
    //MARK: - OPEN URL IN DEFAULT BRWOSER
    @objc func CallUrlIndex(_ sender: UIButton)
    {
        let obj = classArr[sender.tag]
        CallUrl(url: obj.classURL)
    }
    
    func CallUrl(url: String)
    {
        let url = URL(string: url)
        UIApplication.shared.open(url!, options: ["asd":"asdfaf"], completionHandler: nil)
    }
    
    //MARK: - LOAD DATA CLASSES SCHEDULE
    func LoadData()
    {
        var method = "appLoginCheck"
        if userTypeTag == 1{
            method = "appLoginCheckTeacher"
        }
        SetNotification(alarmDate: Date())
        Utilities.sharedInstance.showActivityIndicatory(uiView: self.view)
        ALFWebService.sharedInstance.doGetData(parameters: dic, method: method, success: { (response) in
            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
            self.classArr.removeAll()
            if let name = response.object(forKey: "whologged") as? String{
                self.userNameLbl.text = name
            }
            if response.object(forKey: "allowedDays") as? String == "NOCLASSFOUND"{
                
            }else
            if let classList = response.object(forKey: "appClasses") as? [Dictionary<String,AnyObject>]
            {
                for obj in classList{
                    let model = ClassModel.init(fromDictionary: obj)
                    let todayDat = Date()
                    let startDate = model.classDate.components(separatedBy: ";")
                    let f = DateFormatter()
                    f.dateFormat = "yyyy-MM-dd hh:mm:ss a"
                    let alarmDat: Date! = f.date(from: startDate[0])
//                    if alarmDat > todayDat{
                    self.classArr.append(model)
//                    }
                }
                
            }
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.classArr)
            UserDefaults.standard.set(encodedData, forKey: "classes")
            //MARK: - CLASSES EXIST THEN SET ALARM
            if self.classArr.count > 0{
                let obj = self.classArr[0]
                let currentDat = Date()
                let startDate = obj.classDate.components(separatedBy: ";")
                let start: String = startDate[0]
                let f = DateFormatter()
                f.dateFormat = "yyyy-MM-dd hh:mm:ss a"
                let alarmDat: Date? = f.date(from: start)
                let endDate: Date? = f.date(from: Utilities.stringFromDateWithFormat(currentDat, format: "yyyy-MM-dd hh:mm:ss a"))
                let gregorianCalendar = Calendar(identifier: .gregorian)
                let components = gregorianCalendar.dateComponents([.month,.day,.hour,.minute], from: endDate!, to: alarmDat!)
                let mint = components.minute ?? 0
                if mint > 0{
                    let firstTime = Utilities.stringFromDateWithFormat(alarmDat as! Date, format: "EEE,MMM dd hh:mm a")
                    //======SHOW FIRST TIME ALERT FOR STUDENT ONLY==========//
                    if let userType = UserDefaults.standard.value(forKey: "type") as? String{
                        if userType == "student"{
                            self.ShowAlertFirstTime(firstTime: firstTime,alarmDat: alarmDat!)
                        }else{
                            UserDefaults.standard.set(alarmDat, forKey: "alarm")
                            self.SetNotification(alarmDate: alarmDat ?? Date())
                        }
                    }
                    //======================== END ======================//
                }
                
            }
            self.tblView.reloadData()
        }) { (response) in
            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
        }
    }
    
    //MARK: - SHOW ALERT IF LOAD FIRST TIME
    func ShowAlertFirstTime(firstTime: String,alarmDat: Date)
    {
        
        if UserDefaults.standard.value(forKey: "alarm") == nil{
            let alert = UIAlertController(title: "Alert", message: "Your next appointment is on \(firstTime)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "SET REMINDER", style: .default, handler: { (action) in
                UserDefaults.standard.set(alarmDat, forKey: "alarm")
                self.SetNotification(alarmDate: alarmDat)
            }))
            alert.addAction(UIAlertAction(title: "NO, THANKS", style: .cancel, handler: { (action) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - SET NOTIFICATION ACCORDING TO DATE
    func SetNotification(alarmDate : Date)
    {
        let notification = UNMutableNotificationContent()
        notification.title = "Reminder"
        notification.subtitle = ""
        notification.body = "Your appointment i"
        notification.sound = UNNotificationSound(named: "tickle.mp3")
        UNUserNotificationCenter.current().delegate = self
        // notification after 15 second for testing
//        var dateComponents = DateComponents()
//        dateComponents.weekday = 2
//        dateComponents.hour = 11
//        dateComponents.minute = 0
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        // let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: alarmDate)
//
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: "notification1", content: notification, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    //Notification Delegates
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let app = UIApplication.shared.delegate as! AppDelegate
        app.playSound("tickle")
        notificationMode = true
        UserDefaults.standard.removeObject(forKey: "alarm")
        let alert = UIAlertController(title: "Alert", message: "Your next appointment is on ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "SET REMINDER", style: .default, handler: { (action) in
            
        }))
        alert.addAction(UIAlertAction(title: "NO, THANKS", style: .cancel, handler: { (action) in
            
        }))
        app.window?.inputViewController?.navigationController?.present(alert, animated: true, completion: nil)
        self.present(alert, animated: true, completion: nil)
        //displaying the ios local notification when app is in foreground
        completionHandler([.alert, .badge, .sound])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}
extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
}
