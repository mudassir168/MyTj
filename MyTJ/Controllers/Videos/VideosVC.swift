//
//  VideosVC.swift
//  Tareeq
//
//  Created by Mudassir Abbas on 04/10/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit
import AVKit

class VideosVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //MARK: - IBOUTLETS
    @IBOutlet weak var clView: UICollectionView!
    @IBOutlet weak var clViewWidth: NSLayoutConstraint!
    @IBOutlet weak var topCons: NSLayoutConstraint!
    @IBOutlet weak var pager: UIPageControl!
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    var videosArr = [VideoModel]()
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        clView.delegate = self
        clView.dataSource = self
        clViewWidth.constant = width - (width / 3)
        clView.showsHorizontalScrollIndicator = false
        let flow = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = .horizontal
        self.clView.collectionViewLayout = flow
        topCons.constant = 50
        // Do any additional setup after loading the view.
         let name = UserDefaults.standard.value(forKey: "email") as? String
         let udid = UIDevice.current.identifierForVendor!.uuidString
        let dic = Dictionary<String,AnyObject>()
        if !Utilities.isLoggedIn(){
            let url = "appReg?fcmtoken=\(udid)&studentId=0&teacherId=0"
            RegisterApp(url: url, dic: dic)
        }else{
            if let type = UserDefaults.standard.value(forKey: "type") as? String{
                if type == "student"{
                    let url = "appReg?fcmtoken=\(udid)&studentId=\(name!)&teacherId=0"
                    RegisterApp(url: url, dic: dic)
                }else{
                    let url = "appReg?fcmtoken=\(udid)&studentId=0&teacherId=\(name!)"
                    RegisterApp(url: url, dic: dic)
                }
            }
        }
        LoadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        topCons.constant = 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //================************************************========================
    //MARK: - ======================COLLECTION VIEW DELEGATES=====================
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = videosArr.count
        pager.numberOfPages = count
        pager.isHidden = !(count > 1)
        return count
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pager.currentPage = indexPath.item
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        let obj = videosArr[indexPath.row]
        cell.descLbl.text = obj.desc
        let urlRequest = URLRequest(url: URL(string: obj.videoURL)!)
        cell.webView.loadRequest(urlRequest)
        cell.webView.contentMode = .scaleAspectFit
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: self.clView.frame.height)
    }
    //================************************************========================
    //MARK: - LOAD DATA
    func LoadData()
    {
        let method = "listAppComponentsData"
        let dic = Dictionary<String,AnyObject>()
        Utilities.sharedInstance.showActivityIndicatory(uiView: self.view)
        ALFWebService.sharedInstance.doGetData(parameters: dic, method: method, success: { (response) in
            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
            if let videoList = response.object(forKey: "appVideo") as? [Dictionary<String,AnyObject>]{
                for video in videoList{
                    let model = VideoModel.init(fromDictionary: video)
                    self.videosArr.append(model)            }
            }
            
            self.clView.reloadData()

        }) { (response) in
            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
        }
    }
    //MARK: - REGISTER APP FOR TOKEN
    func RegisterApp(url: String,dic: Dictionary<String,AnyObject>){
        ALFWebService.sharedInstance.doPostData(parameters: dic, method: url, success: { (response) in
            print(response)
        }) { (response) in
            print(response)
        }
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
extension VideosVC {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Change the current page
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        pager?.currentPage = Int(roundedIndex)
        //
    }
    
}
