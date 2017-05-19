//
//  UserLoginViewController.swift
//  kaidee
//
//  Created by g5 on 5/11/2560 BE.
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
        
        SVProgressHUD.show()

        let para : Parameters = [
            "username": username.text!,
            "password" :password.text!
        ]
        Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/login",method:.post, parameters: para,encoding: JSONEncoding.default).responseData{ response in
            
            
            if response.result.value != nil {
                
                self.userData = JSON(data: response.result.value!)

                print("id = > \(self.userData["message"]["id"].stringValue)")
                if self.userData["status"].stringValue == "ok"
                {
                    
                    self.user.setValue(self.userData["message"]["id"].stringValue, forKey:"id")
                    self.user.setValue(self.userData["message"]["first_name"].stringValue, forKey:"first_name")
                    self.user.setValue(self.userData["message"]["last_name"].stringValue, forKey:"last_name")
                    
                    self.dismiss(animated: true, completion: nil)
                    
                }
                else
                {
                
                    let alert = UIAlertController(title:"", message:self.userData["message"].string!, preferredStyle: .alert)
                    let ActionIdle = UIAlertAction(title:"ok", style: .default, handler:nil)
                    alert.addAction(ActionIdle)
                    self.present(alert, animated: true, completion:{
                        self.password.text = ""
                    })
                }
                
            }
            
            SVProgressHUD.dismiss()
        }

        
    }
    
    @IBAction func cancelOnTouch(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
