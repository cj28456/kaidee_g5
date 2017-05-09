//
//  ProfileViewController.swift
//  kaidee
//
//  Created by g5 on 4/27/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit

class ProfileViewController : UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let user = UserDefaults()
    
    struct setting {
        var title: String!
        var image: String!
    }
    
    let settingList = ["ประวัติโปรโมท","รายการโปรด","ประกาศที่ดูล่าสุด"]
    let settingIcon = ["wave_flag","star","vision"]
    
    @IBOutlet weak var profileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if user.value(forKey: "id") == nil
        {
            profileTableView.isHidden = true

            tabBarController?.selectedIndex = 0
        }
        else
        {
            profileTableView.isHidden = false

        
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
            
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
}
