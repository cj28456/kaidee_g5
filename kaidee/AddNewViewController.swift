//
//  AddNewViewController.swift
//  kaidee
//
//  Created by g5 on 5/2/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage
import SVProgressHUD



class AddNewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    let shipping = ["Kerry","Thai Post - EMS","Thai Post - Registerd Mail","aCommerce","CJGLs","DHL","FedEx","Line Man","Lalamove","รับด้วยตัวเอง"]
    let user = UserDefaults()
    let photoAccess = UIImagePickerController()
    
    var uploadImg : UIImage!
    var photoReady : Bool  = false
    var shippingOption : Array<String> = []
    
    var selectedCategoryID : String!
    var selectedSubCategoryID :  String!
    
    @IBOutlet var shippingTableView: UITableView!
    @IBOutlet var itemName: UITextField!
    @IBOutlet var itemDescription: UITextField!
    @IBOutlet var selectedPhoto: UIImageView!
    @IBOutlet var price: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var location: UITextField!
    
    @IBOutlet var category: UITextField!
    @IBOutlet var subCategory: UITextField!

    override func viewDidLoad() {
        
        photoAccess.delegate = self
        photoAccess.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //https://group5-kaidee-resolution.herokuapp.com/add_product
        //http://162.243.54.156/group5-kaidee-resolution/upload_file.php
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == category
        {
            self.view.endEditing(true)
            performSegue(withIdentifier: "selectCategorySegue", sender: nil)
        }
        
    }
    
    //MARK:- table view

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return shipping.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shippingCell", for: indexPath)
        
        print("\(shipping[indexPath.row])")
        cell.textLabel?.text = "\(shipping[indexPath.row])"
        cell.selectionStyle = .none
        
        if shippingOption.index(of: "\(indexPath.row+1)") != nil {
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            
            cell.accessoryType = .none
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("select row \(indexPath.row)")
        
                
        if let index = shippingOption.index(of: "\(indexPath.row+1)") {
            shippingOption.remove(at: index)
        }
        else
        {
            shippingOption.append("\(indexPath.row+1)")
        }
        
        shippingTableView.reloadData()
        
    }
    
    
    @IBAction func addFirstImage(_ sender: Any) {
        
        self.present(photoAccess, animated: true, completion: nil)

    }
    
    
    //MARK:- uiimagepicker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        photoAccess.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print(info)
        
        // Media is an image
        let uploadImg = info[UIImagePickerControllerOriginalImage] as! UIImage
        selectedPhoto.image = uploadImg
        photoAccess.dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func addItem(_ sender: Any) {
        
        //let image = UIImage(named: "bodrum")!
        
        SVProgressHUD.show()
        
        DispatchQueue.global(qos: .background).async {
            
            let url = NSURL(string: "http://162.243.54.156/group5-kaidee-resolution/upload_file.php")
            
            let request = NSMutableURLRequest(url: url! as URL)
            request.httpMethod = "POST"
            
            let boundary = "Boundary-\(NSUUID().uuidString)"
            //define the multipart request type
            
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            
            let body = NSMutableData()
            
            let fname = "test.png"
            
            let mimetypePhoto = "image/png"

            
            //define the data post parameter
    
                let image_data = UIImageJPEGRepresentation(self.selectedPhoto.image!, 0.1)!
                body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition:form-data; name=\"fileToUpload\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Type: \(mimetypePhoto)\r\n\r\n".data(using: String.Encoding.utf8)!)
                body.append(image_data)
                body.append("\r\n".data(using: String.Encoding.utf8)!)
                body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
       
            
            request.httpBody = body as Data
            
            let session = URLSession.shared
            
            
            let task = session.dataTask(with: request as URLRequest) {
                (
                data, response, error) in
                
                guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                    
                    //error
                    
                    return
                }
                
                
                
                let tmp = JSON.init(data: data!)
                
                print(tmp)
                //image check
                if tmp["status"].stringValue == "ok"
                {
                    
                            let para : Parameters = [
                                "user_id":self.user.value(forKey: "id")!,
                                "product_category_id": self.selectedCategoryID,
                                "product_sub_category_id": self.selectedSubCategoryID,
                                "name": self.itemName.text!,
                                "image_path": tmp["message"].stringValue,
                                "price": self.price.text!,
                                "description": self.itemDescription.text!,
                                "phone": self.phone.text!,
                                "location": self.location.text!,
                                "shipment": self.shippingOption.joined(separator:","),
                                
                            ]
                    
                        print(para)
                    
                    
                    
                            Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/add_product",method:.post, parameters: para,encoding: JSONEncoding.default).responseData{ response in
                    
                                if response.result.value != nil {
                    
                                    let tmp = JSON(data: response.result.value!)
                    
                    

                                    let alert = UIAlertController(title:"", message:"ขอให้ขายได้ไวๆครับ", preferredStyle: .alert)
                                    
                                    let ActionAgree = UIAlertAction(title: "ok", style: .default, handler:{ (_) in
                                        
                                        self.navigationController?.popViewController(animated: true)
                                        
                                    })
                                    
                                    
                                    alert.addAction(ActionAgree)
                                    
                                    self.present(alert, animated: true, completion:{})
                                    
                                }
                                
                            }
                    

                    
                    
                    
                
                }
                else
                {
                    let alert = UIAlertController(title:"Upload error", message:tmp["message"].stringValue, preferredStyle:.alert)
                    let ActionIdle = UIAlertAction(title:"ok", style: .default, handler:nil)
                    alert.addAction(ActionIdle)
                    self.present(alert, animated: true, completion:{})
                    
                }

                SVProgressHUD.dismiss()

                
            }
            
            task.resume(
                
                print(">>>> resume")
                
            )
            
            
            DispatchQueue.main.async {
                
                

                
            }
            
            
            
        }
    
        
    }
    
    @IBAction func unwindToAddView(sender: UIStoryboardSegue) {
        
        
        print("maew")
        
        if let svc = sender.source as? SubProductCategoryTableViewController {
        
            category.text = svc.select.mainCatTitle!
            subCategory.text = svc.select.subCatTitle!
            selectedCategoryID = svc.select.mainCat!
            selectedSubCategoryID = svc.select.subCat!
            
            
         print("select cet \(svc.select.mainCat!) \(svc.select.subCat!)")
        
        }
    }
}
