//
//  AddNewViewController.swift
//  kaidee
//
//  Created by toktak on 5/2/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let shipping = ["Kerry","Thai Post - EMS","Thai Post - Registerd Mail","aCommerce","CJGLs","DHL","FedEx","Line Man","Lalamove","รับด้วยตัวเอง"]
    let user = UserDefaults()
    let photoAccess = UIImagePickerController()
    
    var uploadImg : UIImage!
    var photoReady : Bool  = false
    var shippingOption : Array<String> = []

    @IBOutlet var shippingTableView: UITableView!
    @IBOutlet var itemName: UITextField!
    @IBOutlet var itemDescription: UITextField!
    @IBOutlet var selectedPhoto: UIImageView!
    @IBOutlet var price: UITextField!
    @IBOutlet var phone: UITextField!
    

    override func viewDidLoad() {
        
        photoAccess.delegate = self
        photoAccess.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //https://group5-kaidee-resolution.herokuapp.com/add_product
        
    }
    
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
    
}
