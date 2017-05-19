//
//  RatingViewController.swift
//  kaidee
//
//  Created by g5 on 5/15/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import HCSStarRatingView
import Alamofire
import SVProgressHUD
import SwiftyJSON

class RatingViewController: UIViewController {
    
    
    
    @IBOutlet var ratingView: HCSStarRatingView!
    
    let user = UserDefaults()
    var user_id : String!
    var product_id : String!
    var rate : String!
    var who_is : String!
    
    override func viewDidLoad() {
        
        
        
    }
    
    @IBAction func didChangeValue(_ sender: HCSStarRatingView) {
        
        rate = "\(Int(sender.value))"

        print(rate)
    }
    
    @IBAction func sendButtonOnTouch(_ sender: Any) {
        
        SVProgressHUD.show()
        
        let para : Parameters = [
            "user_id": user_id!,
            "product_id" :product_id,
            "rate" :rate,
            "who_is" :user.value(forKey: "id")!
        ]
        
        print(para)
        
        Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/rate",method:.post, parameters: para,encoding: JSONEncoding.default).responseData{ response in
            
            
            if response.result.value != nil {
     
                let tmp = JSON(data: response.result.value!)
                
                
                let alert = UIAlertController(title:"", message:tmp["message"].stringValue, preferredStyle: .alert)
                
                let ActionAgree = UIAlertAction(title: "ok", style: .default, handler:{ (_) in
                    
                    self.dismiss(animated: true, completion: nil)
                    
                })
                
                
                alert.addAction(ActionAgree)
                
                self.present(alert, animated: true, completion:{})

                
                
            }
            
            SVProgressHUD.dismiss()
        }

        

    }
}
