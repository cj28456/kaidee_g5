//
//  UserLoginViewController.swift
//  kaidee
//
//  Created by toktak on 5/11/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class UserLoginViewController: UIViewController{
    
    let user = UserDefaults()
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    var userData : JSON!
    
    override func viewDidLoad() {
        

        
    }
    
    @IBAction func loginOnTouch(_ sender: Any) {
        
        
        let para : Parameters = [
            "username": username.text!,
            "password" :password.text!
        ]
        
        Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/login",method:.post, parameters: para,encoding: JSONEncoding.default).responseData{ response in
            
            
            if response.result.value != nil {
                
                self.userData = JSON(data: response.result.value!)

                if self.userData["status"].stringValue == "ok"
                {
//                    self.user.setValue(self.userData["user_info"]["id"].stringValue, forKey:"user_id")
//                    self.user.setValue(self.userData["user_info"]["firstname"].stringValue, forKey:"first_name")
//                    self.user.setValue(self.userData["user_info"]["lastname"].stringValue, forKey:"last_name")
//                    self.user.setValue(self.userData["user_info"]["imgURL"].stringValue, forKey: "profile_image")

                }
                else
                {
                
                    let alert = UIAlertController(title:self.userData["title"].string!, message:self.userData["message"].string!, preferredStyle: .alert)
                    let ActionIdle = UIAlertAction(title:"SORRY", style: .default, handler:nil)
                    alert.addAction(ActionIdle)
                    self.present(alert, animated: true, completion:{
                        self.password.text = ""
                    })
                }
                
            }
            
            SVProgressHUD.dismiss()
        }
        
        //https://group5-kaidee-resolution.herokuapp.com/login
        //post
        //username, password
        
    }
    
    @IBAction func cancelOnTouch(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
