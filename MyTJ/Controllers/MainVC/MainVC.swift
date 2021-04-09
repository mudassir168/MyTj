//
//  MainVC.swift
//  Tareeq
//
//  Created by Mudassir Abbas on 03/10/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit
let screenWidth = UIScreen.main.nativeBounds.width

class MainVC: UITabBarController,UITabBarControllerDelegate,UINavigationControllerDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    init() {
        // perform some initialization here
        super.init(nibName: nil, bundle: nil)
        //================
        let img = #imageLiteral(resourceName: "videocam")
        let colrImg = img.withRenderingMode(.alwaysTemplate)
        let home = UIStoryboard.storyBoard(withName: .Main).loadViewController(withIdentifier: .videosVC)
        home.tabBarItem = UITabBarItem(title: "VIDEOS", image: colrImg, selectedImage:colrImg )
        home.tabBarItem.tag = 0
//                let homeNav = UINavigationController(rootViewController: home)
        //================
        let profile =  UIStoryboard.storyBoard(withName: .Main).loadViewController(withIdentifier: .signupVC)
        profile.tabBarItem = UITabBarItem(title: "SIGN UP", image: #imageLiteral(resourceName: "add-user"), selectedImage: #imageLiteral(resourceName: "add-user"))
        profile.tabBarItem.tag = 1
        //        let profileNav = UINavigationController(rootViewController: profile)
        //================
        let settings: UIViewController!
       if UserDefaults.standard.value(forKey: "email") != nil && UserDefaults.standard.value(forKey: "password") != nil{
        settings = UIStoryboard.storyBoard(withName: .Main).loadViewController(withIdentifier: .dashboardVC)
       }else{
            settings = UIStoryboard.storyBoard(withName: .Main).loadViewController(withIdentifier: .loginVC)
        }
        settings.tabBarItem = UITabBarItem(title: "APPOINTMENTS", image: nil, selectedImage: nil)
        settings.tabBarItem.tag = 4
        settings.tabBarItem.titlePositionAdjustment  = UIOffset(horizontal: 0, vertical: -10)
        
        
        
        self.tabBar.tintColor = UIColor.white
        self.tabBar.barTintColor = UIColor(hexString: navbarClr)
        self.tabBar.unselectedItemTintColor = UIColor(hexString: "#B4DCE2")
        viewControllers = [home,profile,settings]
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.tabBar.frame = CGRect( x: 0, y: 64, width: UIScreen.main.bounds.width, height: 50)
        
        if screenWidth == 2048 {
            self.tabBar.itemSpacing = CGFloat(UITabBarItemPositioning.automatic.rawValue)
            self.tabBarItem.imageInsets =  UIEdgeInsetsMake(15, 0, -15, 0)
            self.tabBarItem.title = nil
            self.tabBar.itemSpacing = UIScreen.main.bounds.width / 8
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        _ = viewController.tabBarItem.tag
    }
    
    private func findSelectedTagForTabBarController(tabBarController: UITabBarController?) {
        
        if let tabBarController = tabBarController {
            if let viewControllers = tabBarController.viewControllers {
                let selectedIndex = tabBarController.selectedIndex
                let selectedController: UIViewController? = viewControllers.count > selectedIndex ? viewControllers[selectedIndex] : nil
                if let tag = selectedController?.tabBarItem.tag {
                    //here you can use your tag
                    print(tag)
                }
            }
        }
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //findSelectedTagForTabBarController(navigationController.tabBarController)
        print("print \(viewController)")
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
