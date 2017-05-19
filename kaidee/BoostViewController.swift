//
//  BoostViewController.swift
//  kaidee
//
//  Created by g5 on 5/12/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import SDWebImage

class BoostViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var itemId:String!
    var boostData:JSON!

    struct boost {
        var day : String!
        var price : String!
        var img : String!
    }
    
    
    
    
    @IBOutlet var boostTableView: UITableView!
    
    let boostItem : [boost] = [boost.init(day: "10", price: "100",img :"⚡️"),boost.init(day: "20", price: "180",img :"⚡️⚡️"),boost.init(day: "30", price: "260",img :"⚡️⚡️⚡️")]
    
    override func viewDidLoad() {
        print("boost item \(itemId)")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boostItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : BoostTableCell = tableView.dequeueReusableCell(withIdentifier: "BoostTableCell", for: indexPath) as! BoostTableCell
        
        cell.boostDetail.text =  "จำนวน \(boostItem[indexPath.row].day!) วัน [\(boostItem[indexPath.row].price!) บาท]"
        cell.boostIcon.text =  "\(boostItem[indexPath.row].img!)"

        //cell.boostImage.image = UIImage.init(named:"\(boostItem[indexPath.row].img!)")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title:"ต้องการบูทสิ้นค้าชิ้นนี้?", message: "", preferredStyle: .alert)
        
        let ActionAgree = UIAlertAction(title: "ตกลง", style: .default, handler:{ (_) in

//            print("https://group5-kaidee-resolution.herokuapp.com/set_boost/\(self.itemId!)")
            
            //product_id
            let para : Parameters = [
                "product_id" :self.itemId!
            ]
            
            
                        Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/set_boost",method:.post, parameters: para,encoding: JSONEncoding.default).responseData{ response in
                        
                            if response.result.value != nil {
            
                                self.boostData = JSON(data: response.result.value!)

                                print( self.boostData)
                                
                                let alert = UIAlertController(title:nil, message: self.boostData["message"].stringValue, preferredStyle: .alert)
                                let ActionIdle = UIAlertAction(title:"OK", style: .default, handler:nil)
                                alert.addAction(ActionIdle)
                                self.present(alert, animated: true, completion:{
                                })
                                
            
                            }
            
                            SVProgressHUD.dismiss()
                        }
            
        })
        
        let ActionCancel = UIAlertAction(title: "ยกเลิก", style: .default, handler:nil)
        
        alert.addAction(ActionAgree)
        alert.addAction(ActionCancel)
        
        self.present(alert, animated: true, completion:{})
        
    }
    
    
    
}
