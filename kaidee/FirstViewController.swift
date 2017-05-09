//
//  FirstViewController.swift
//  kaidee
//
//  Created by toktak on 5/9/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit

class FirstViewController : UIViewController {
    
    @IBOutlet var sellButton: UIButton!
    @IBOutlet var buyButton: UIButton!
    
    let user = UserDefaults()
    
    override func viewDidLoad() {
        
        sellButton.layer.cornerRadius =  sellButton.frame.width/2
        buyButton.layer.cornerRadius =  buyButton.frame.width/2
        
    }
    
    @IBAction func newProductOnTouch(_ sender: Any) {
        
        
        if user.value(forKey:"id") == nil
        {
            self.performSegue(withIdentifier: "sellProductLoginSegue", sender: nil)
            
        }
        else
        {
            self.performSegue(withIdentifier: "addProductSegue", sender: nil)
            
        }
        
    }
    
    
    
}


