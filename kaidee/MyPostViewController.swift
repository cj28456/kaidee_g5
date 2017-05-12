//
//  SecondViewController.swift
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

class MyPostViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let user = UserDefaults()

    var selectedItem : String!
    
    var postData:JSON!
    

    
    @IBOutlet weak var myPostTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myPostTableView.delegate = self
        myPostTableView.dataSource = self
        
        print("https://group5-kaidee-resolution.herokuapp.com/get_my_post/\(user.value(forKey: "id")!)")


    
    
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.reloadTable()
        
    }
    
    func reloadTable()
    {
        SVProgressHUD.show()
        //simple request
        Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/get_my_post/\(user.value(forKey: "id")!)",method:.get, parameters: nil).responseData{ response in
            
            print("login \(response)")
            
            if response.result.value != nil {
                
                self.postData = JSON(data: response.result.value!)
                
                print(self.postData)
                
                
                self.myPostTableView.reloadData()
                
            }
            
            SVProgressHUD.dismiss()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : myPostTableCell = tableView.dequeueReusableCell(withIdentifier: "myPostTableCell", for: indexPath) as! myPostTableCell
        
        cell.postDate.text = postData[indexPath.row]["created_at"].stringValue
        cell.postTitle.text = postData[indexPath.row]["name"].stringValue
        cell.postPrice.text = "\(postData[indexPath.row]["price"].stringValue) บาท"
        cell.postImage.sd_setImage(with: URL.init(string: postData[indexPath.row]["image_path"].stringValue))

        if postData[indexPath.row]["boost"].intValue == 0 {
            
            cell.postBoost.isHidden = true
        }
        else
        {
            cell.postBoost.isHidden = false
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            
            let alert = UIAlertController(title:"ต้องการลบสิ้นค้าชิ้นนี้?", message: "", preferredStyle: .alert)
            
            let ActionAgree = UIAlertAction(title: "ตกลง", style: .default, handler:{ (_) in
                
                
                let para : Parameters = [
                    "product_id": self.postData[indexPath.row]["id"].stringValue
                ]
                
                            Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/delete_product",method:.post, parameters: para,encoding: JSONEncoding.default).responseData{ response in
                
                                print("login \(response)")
                
                                if response.result.value != nil {
                
                                    self.postData = JSON(data: response.result.value!)
                                    
                                    let alert = UIAlertController(title:nil, message: self.postData["message"].stringValue, preferredStyle: .alert)
                                    let ActionIdle = UIAlertAction(title:"OK", style: .default, handler:nil)
                                    alert.addAction(ActionIdle)
                                    self.present(alert, animated: true, completion:{
                                        
                                        self.reloadTable()

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        selectedItem = postData[indexPath.row]["id"].stringValue
        
        self.performSegue(withIdentifier: "boostItemSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "boostItemSegue") {
            let svc = segue.destination as! BoostViewController
            svc.itemId = selectedItem
                    
        }
        //send id
        //itemId
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if postData != nil
        {
            return postData.count
        }
        else{
            return 0
        }
        
    }
        
        
    

}

