//
//  SignupVC.swift
//  Tareeq
//
//  Created by Mudassir Abbas on 05/10/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
class SignupVC: UIViewController {
    @IBOutlet weak var zoneBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var maleBackBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var femaleBackBtn: UIButton!
    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var emailLbl: UITextField!
    @IBOutlet weak var numberLbl: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    
    var zoneArr = [String]()
    var eventArr = [String]()
    var dic = Dictionary<String,AnyObject>()
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        //-----------
        maleBtn.tintColor = UIColor(hexString: navbarClr)
        femaleBtn.tintColor = UIColor(hexString: navbarClr)
        dic["gender"] = "Male" as AnyObject
        maleBtn.setImage(UIImage.fontAwesomeIcon(name: .circle, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
        femaleBtn.setImage(UIImage.fontAwesomeIcon(name: .circleThin, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
        //-------
        self.signupBtn.layer.shadowColor = UIColor.lightGray.cgColor
        self.signupBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.signupBtn.layer.shadowOpacity = 1
        self.signupBtn.layer.shadowRadius = 4
        self.hideKeyboardWhenTappedAround()
        LoadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.navTitle(titel: "MyTJ Free Demo Registration")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - HANDLE RADIO BUTTON
    @IBAction func HandleRadioBtn(_ sender: UIButton)
    {
        if sender == maleBackBtn{
            dic["gender"] = "Male" as AnyObject
            maleBtn.setImage(UIImage.fontAwesomeIcon(name: .circle, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
            femaleBtn.setImage(UIImage.fontAwesomeIcon(name: .circleThin, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
            
        }else{
            dic["gender"] = "Female" as AnyObject
            maleBtn.setImage(UIImage.fontAwesomeIcon(name: .circleThin, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
                femaleBtn.setImage(UIImage.fontAwesomeIcon(name: .circle, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
        }
    }
    // MARK: - DATE PICKER HANDLE
    @IBAction func TimezonePressed(_ sender: UIButton)
    {
        var title = ""
        var arr = [String]()
        if sender == zoneBtn{
            title = "Choose your nearby timezone"
            arr = zoneArr
        }else{
            title = "How did you hear about us?"
            arr = eventArr
        }
        
        ActionSheetStringPicker.show(withTitle: title, rows: arr , initialSelection: 0, doneBlock: {picker, values, indexes in
            sender.titleLabel?.textColor = UIColor.black
            var val = ""
            if sender == self.zoneBtn{
            val = self.zoneArr[values]
            self.dic["stuTimeZone"] = val as AnyObject
            self.zoneBtn.setTitleColor(UIColor.black, for: .normal)
            }else{
                val = self.eventArr[values]
                self.dic["tjMarketing"] = val as AnyObject
                self.eventBtn.setTitleColor(UIColor.black, for: .normal)
            }
            if val != ""{
            sender.setTitle(val, for: .normal)
            }
            }, cancel: {ActionMultipleStringCancelBlock in return}, origin: sender)
    }
    //MARK: - LOAD DATA
    func LoadData()
    {
        let method = "listAppComponentsData"
        let dic = Dictionary<String,AnyObject>()
        Utilities.sharedInstance.showActivityIndicatory(uiView: self.view)
        ALFWebService.sharedInstance.doGetData(parameters: dic, method: method, success: { (response) in
            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
             if let timeList = response["appTZ"] as? [Dictionary<String,AnyObject>]{
                for time in timeList{
                    let val = (time["tzName"] as? String) ?? ""
                    self.zoneArr.append(val)
                }
            }
            if let eventList = response["listOfEvents"] as? [String]{
                self.eventArr = eventList
            }
        }) { (response) in
            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
        }
    }
    //MARK: - REGISTER USER
    @IBAction func RegisterUser(_ sender: UIButton)
    {
        if nameLbl.text!.isEmpty{
            Utilities.showAlertWithTitle(title: "", withMessage: "Please enter name", withNavigation: self)
            return
        }
        if emailLbl.text!.isEmpty{
            Utilities.showAlertWithTitle(title: "", withMessage: "Please enter email", withNavigation: self)
            return
        }
        if !isValidEmail(testStr: emailLbl.text!){
            Utilities.showAlertWithTitle(title: "", withMessage: "Please enter valid email", withNavigation: self)
            return
        }
        if numberLbl.text!.isEmpty{
            Utilities.showAlertWithTitle(title: "", withMessage: "Please enter phone", withNavigation: self)
            return
        }
        if zoneBtn.titleLabel?.text == "Choose your nearby timezone."{
            Utilities.showAlertWithTitle(title: "", withMessage: "Please select timezone", withNavigation: self)
            return
        }
        if eventBtn.titleLabel?.text == "How did you hear about us?"{
            Utilities.showAlertWithTitle(title: "", withMessage: "Please select about us", withNavigation: self)
            return
        }
        let method = "appSaveRegForm"
        dic["studentName"] = nameLbl.text as AnyObject
        dic["emailId"] = emailLbl.text as AnyObject
        dic["cellphone"] = numberLbl.text as AnyObject
        print(dic)
        Utilities.sharedInstance.showActivityIndicatory(uiView: self.view)
        ALFWebService.sharedInstance.doPostData(parameters: dic, method: method, success: { (response) in
            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
            print(response)
            if let msg = response.object(forKey: "msg") as? String{
                Utilities.showAlertWithTitle(title: "Registration Successful", withMessage: "Our support team will get in touch with you!, \nYour registeration number:\(msg)", withNavigation: self)
                
            }
        }) { (response) in
            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
        }
        
    }
    
    //MARK: - EMAIL VERIFICATION
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
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
