//
//  ProfileViewController.swift
//  kaidee
//
//  Created by g5 on 4/27/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import SVProgressHUD

class ProfileViewController : UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let user = UserDefaults()
    let settingList = ["ประวัติโปรโมท","รายการโปรด","ประกาศที่ดูล่าสุด"]
    let settingIcon = ["wave_flag","star","vision"]
    
    var userData : JSON!
    
    struct setting {
        var title: String!
        var image: String!
    }
    
    
    @IBOutlet weak var profileTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        print("req url https://group5-kaidee-resolution.herokuapp.com/get_user/\(user.value(forKey: "id")!)")
        SVProgressHUD.show()

        Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/get_user/\(user.value(forKey: "id")!)",method:.get).responseData{ response in
            
            
            if response.result.value != nil {
                
                self.userData = JSON(data: response.result.value!)
                self.profileTableView.delegate = self
                self.profileTableView.dataSource = self

                self.profileTableView.reloadData()
                
            }
            
            SVProgressHUD.dismiss()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1

        }
        else if section == 1
        {
            return 3
        }
        else
        {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell:profileInfoTableCell = tableView.dequeueReusableCell(withIdentifier: "profileInfoTableCell", for: indexPath) as! profileInfoTableCell
            cell.profileId.text = "id : \(userData[indexPath.row]["id"].stringValue)"
            cell.profileName.text = userData[indexPath.row]["first_name"].stringValue
            
            return cell
            
        }else if indexPath.section == 1
        {
            let cell :settingTableCell  = tableView.dequeueReusableCell(withIdentifier: "settingTableCell", for: indexPath) as! settingTableCell
            cell.settingTitle.text = "\(settingList[indexPath.row])"
            cell.settingImage.image = UIImage.init(named: "\(settingIcon[indexPath.row])")
            
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "logout", for: indexPath)
            
            return cell
        
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        
        if indexPath.section == 0
        {
            return 100
            
        }else if indexPath.section == 1
        {

            
            return 50
        }
        else
        {
            
            return 50
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
            
            if indexPath.section == 0
            {

            }
            else if indexPath.section == 1
            {
                
                
     
            }
            else
            {
                
                let alert = UIAlertController(title:"ต้องการออกจากระบบ?", message: "", preferredStyle: .alert)
                
                let ActionAgree = UIAlertAction(title: "ตกลง", style: .default, handler:{ (_) in
                    
                    self.user.setValue(nil, forKey:"id")
                    self.user.setValue(nil, forKey:"first_name")
                    self.user.setValue(nil, forKey:"last_name")
                    self.tabBarController?.selectedIndex = 0
                })
                
                let ActionCancel = UIAlertAction(title: "ยกเลิก", style: .default, handler:nil)
                
                alert.addAction(ActionAgree)
                alert.addAction(ActionCancel)
                
                self.present(alert, animated: true, completion:{})
                
            }
            

        
    }
    
}
