//
//  AddNewViewController.swift
//  kaidee
//
//  Created by toktak on 5/2/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let shipping = ["Kerry","Thai Post - EMS","Thai Post - Registerd Mail","aCommerce","CJGLs","DHL","FedEx","Line Man","Lalamove","รับด้วยตัวเอง"]

    
    @IBOutlet var shippingTableView: UITableView!
    
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
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            
            cell.accessoryType = .none
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("select row \(indexPath.row)")
        
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        
    }
    
    
    @IBAction func addFirstImage(_ sender: Any) {
        
    }
    
}
