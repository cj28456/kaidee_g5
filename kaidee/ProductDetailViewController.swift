//
//  itemDetailViewController.swift
//  kaidee
//
//  Created by g5 on 5/1/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON
import SVProgressHUD

class ProductDetailViewController: UIViewController {
    
    
    var productId : String!
    var productData : JSON!
    let user = UserDefaults()
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDetail: UILabel!
    @IBOutlet weak var productLocation: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var createAt: UILabel!
    
    @IBOutlet var productShipping: UILabel!
    
    override func viewDidLoad() {
        
        
        SVProgressHUD.show()
        
        Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/get_product/\(productId!)",method:.get, parameters: nil).responseData{ response in
            
            
            if response.result.value != nil {
                
                self.productData = JSON(data: response.result.value!)
                
                
                print(self.productData)
                
                self.productImage.sd_setImage(with:URL.init(string: self.productData["product"][0]["image_path"].stringValue))
                
                self.title = self.productData["product"][0]["name"].stringValue
                self.productPrice.text = "ราคา : \(self.productData["product"][0]["price"].stringValue)"
                self.productDetail.text = "รายละเอียด : \(self.productData["product"][0]["description"].stringValue)"
                self.createAt.text = "ลงประกาศเมื่อ : \(self.productData["product"][0]["created_at"].stringValue)"
                self.productLocation.text = "ตำแหน่ง : \(self.productData["product"][0]["location"].stringValue)"
                self.phoneNumber.text = "โทร : \(self.productData["product"][0]["phone"].stringValue)"
                
                
                let shipping = ["-","Kerry","Thai Post - EMS","Thai Post - Registerd Mail","aCommerce","CJGLs","DHL","FedEx","Line Man","Lalamove","รับด้วยตัวเอง"]
                
                let tmp    = self.productData["product"][0]["shipment"].stringValue.removingWhitespaces()
                let shipping_array = tmp.components(separatedBy: ",")
                
                var shipping_tmp : Array<String> = []
                
                for  iopt in 0 ..< shipping_array.count
                {
                    let i = shipping_array[iopt]
                    let x:Int! = Int(i)   // secondText is UITextField
                    //                    print("\(shipping[x])")
                    shipping_tmp.append(shipping[x])
                }
                //
                self.productShipping.text = "จัดส่ง : \(shipping_tmp.joined(separator:","))"                //shipment
                
            }
            
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    @IBAction func rateItemOnTouch(_ sender: Any) {
        
        performSegue(withIdentifier: "rateItemSegue", sender: nil)
        
    }
    @IBAction func ContactSellerOnTouch(_ sender: Any) {
    
        
        if (user.value(forKey: "id") == nil)
        {
            performSegue(withIdentifier: "userChatLoginSegue", sender: nil)
        }
        else
        {
            performSegue(withIdentifier: "chatViewSegue", sender: nil)

        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        //product ด้านล่าง
        if (segue.identifier == "rateItemSegue") {
            let svc = segue.destination as! RatingViewController
            
            svc.user_id = self.productData["product"][0]["user_id"].stringValue
            svc.product_id = self.productData["product"][0]["id"].stringValue
            
        }
        
        
    }
    
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
