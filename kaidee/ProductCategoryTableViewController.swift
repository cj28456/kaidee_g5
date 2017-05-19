//
//  ProductCategoryTableViewController.swift
//  kaidee
//
//  Created by g5 on 5/12/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ProductCategoryTableViewController: UITableViewController {
    
    var categoryData : JSON!
    var selectCategory :String!
    var selectCategoryTitle :String!
    
    override func viewDidLoad() {
        
        SVProgressHUD.show()
        //simple request
        Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/get_product_cat",method:.get, parameters: nil).responseData{ response in
            
            if response.result.value != nil {
                
                self.categoryData = JSON(data: response.result.value!)
                self.tableView.reloadData()
            }
            
            SVProgressHUD.dismiss()
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if categoryData != nil
        {
            return categoryData["product_cat"].count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryData["product_cat"][indexPath.row]["name"].stringValue
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectCategory = categoryData["product_cat"][indexPath.row]["id"].stringValue
        selectCategoryTitle = categoryData["product_cat"][indexPath.row]["name"].stringValue
        performSegue(withIdentifier: "selectSubCategorySegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "selectSubCategorySegue") {
            let svc = segue.destination as! SubProductCategoryTableViewController
            svc.categoryId = selectCategory
            svc.categoryTitle = selectCategoryTitle
            
        }
        
    }
    
    
    
}
