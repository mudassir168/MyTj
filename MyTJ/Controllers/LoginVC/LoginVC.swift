//
//  LoginVC.swift
//  Tareeq
//
//  Created by Mudassir Abbas on 05/10/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit
import FontAwesome_swift

class LoginVC: UIViewController {
    @IBOutlet weak var nameTxt : UITextField!
    @IBOutlet weak var passwordTxt : UITextField!
    @IBOutlet weak var loginBtn : UIButton!
    @IBOutlet weak var checkboxBtn : UIButton!
    @IBOutlet weak var policyBtn : UIButton!
    @IBOutlet weak var teacherBtn: UIButton!
    @IBOutlet weak var studentBtn : UIButton!
    //-------VARIABLE-------//
    var classArr = [ClassModel]()
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        loginBtn.layer.masksToBounds = false
        self.loginBtn.layer.shadowColor = UIColor.lightGray.cgColor
        self.loginBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.loginBtn.layer.shadowOpacity = 1
        self.loginBtn.layer.shadowRadius = 4
        //----------INITIALIZE TERMS CHECKBOX ----------//
        checkboxBtn.tag = 1
        checkboxBtn.tintColor = UIColor(hexString: navbarClr)
        checkboxBtn.setImage(UIImage.fontAwesomeIcon(name: .checkSquare, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 40, height: 40)), for: .normal)
        //---------INITIALIZE RADIO BUTTONS------------//
        studentBtn.tag = 1
        teacherBtn.tag = 0
        teacherBtn.tintColor = UIColor(hexString: navbarClr)
        studentBtn.tintColor = UIColor(hexString: navbarClr)
        studentBtn.setImage(UIImage.fontAwesomeIcon(name: .circle, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
        teacherBtn.setImage(UIImage.fontAwesomeIcon(name: .circleThin, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
        //----------------------------------------------//
        policyBtn.underline()
        // Do any additional setup after loading the view.
    }
    // Mark: - view will appear
    override func viewWillAppear(_ animated: Bool) {
         self.parent?.navTitle(titel: "Login")
    }
    // MARK: - HANDLE TERMS RADIO BUTTON
    @IBAction func HandleCheckBox(_ sender: UIButton)
    {
        if sender.tag == 1{
            checkboxBtn.tag = 0
            checkboxBtn.setImage(UIImage.fontAwesomeIcon(name: .squareO, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
        }else{
            checkboxBtn.tag = 1

            checkboxBtn.setImage(UIImage.fontAwesomeIcon(name: .checkSquare, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
        }
    }
    
    // MARK: - HANDLE RADIO BUTTON
    @IBAction func HandleRadioBtn(_ sender: UIButton)
    {
        if sender == studentBtn{
        studentBtn.tag = 1
        teacherBtn.tag = 0
        studentBtn.setImage(UIImage.fontAwesomeIcon(name: .circle, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
        teacherBtn.setImage(UIImage.fontAwesomeIcon(name: .circleThin, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
        }else{
            studentBtn.tag = 0
            teacherBtn.tag = 1
            teacherBtn.setImage(UIImage.fontAwesomeIcon(name: .circle, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
            studentBtn.setImage(UIImage.fontAwesomeIcon(name: .circleThin, textColor: UIColor(hexString: navbarClr), size: CGSize(width: 30, height: 30)), for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - PRESSED SIGNIN BUTTON
    @IBAction func SigninPressed(_ sender: UIButton)
    {
        //----VALIDATION------//
        if nameTxt.text!.isEmpty{
            Utilities.showAlertWithTitle(title: "", withMessage: "Please enter username", withNavigation: self)
            return
        }
        if checkboxBtn.tag == 0{
            Utilities.showAlertWithTitle(title: "", withMessage: "Please agree with policy", withNavigation: self)
            return
        }
        if passwordTxt.text!.isEmpty{
            Utilities.showAlertWithTitle(title: "", withMessage: "Please enter password", withNavigation: self)
            return
        }
        //----VALIDATION------//
        var method = "appLoginCheck"
        if teacherBtn.tag == 1{
            method = "appLoginCheckTeacher"
        }
        var dic = Dictionary<String,AnyObject>()
        dic["userName"] = nameTxt.text as AnyObject
        dic["passCode"] = passwordTxt.text as AnyObject
        //=============CALL API===========//
        Utilities.sharedInstance.showActivityIndicatory(uiView: self.view)
        ALFWebService.sharedInstance.doGetData(parameters: dic, method: method, success: { (response) in
            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
            if let classList = response.object(forKey: "appClasses") as? [Dictionary<String,AnyObject>]
            {
                UserDefaults.standard.set(self.nameTxt.text!, forKey: "email")
                UserDefaults.standard.set(self.passwordTxt.text, forKey: "password")
                if self.studentBtn.tag == 1{
                    UserDefaults.standard.set("student", forKey: "type")
                }else{
                    UserDefaults.standard.set("teacher", forKey: "type")
                }
                let controller = UIStoryboard.storyBoard(withName: .Main).loadViewController(withIdentifier: .dashboardVC) as! DashboardVC
                if self.teacherBtn.tag == 1{
                    controller.userTypeTag = 1
                }
                self.addChildViewController(controller)
                controller.view.frame = self.view.frame // or better, turn off
                self.view.addSubview(controller.view)
                controller.didMove(toParentViewController: self)
            }
        }) { (response) in
            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
        }
    }
    
    @IBAction func PolicyPressed(_ sender: UIButton)
    {
        let url = URL(string: "https://www.tareequljannah.com/STC")
        UIApplication.shared.open(url!, options: ["asd":"asdfaf"], completionHandler: nil)
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

