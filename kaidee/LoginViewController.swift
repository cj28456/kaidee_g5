//
//  LoginViewController.swift
//  kaidee
//
//  Created by toktak on 5/9/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    
    let user = UserDefaults()
    
    override func viewDidLoad() {
        
        //https://group5-kaidee-resolution.herokuapp.com/login
        //post
        //username, password
    
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if (user.value(forKey: "id") == nil)
        {

        }else
        {
            self.dismiss(animated: true, completion: nil)

        }
        
        
    }

    @IBAction func cancelOnTouch(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
