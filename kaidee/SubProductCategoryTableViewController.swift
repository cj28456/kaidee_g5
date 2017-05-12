//
//  SubProductCategoryTableViewController.swift
//  kaidee
//
//  Created by Toktak on 5/12/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class SubProductCategoryTableViewController: UITableViewController {
    
    var categoryId : String!
    var subCategoryData : JSON!
    
    
    override func viewDidLoad() {
        
        SVProgressHUD.show()
        //simple request
        Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/get_product_sub_cat/\(categoryId)",method:.get, parameters: nil).responseData{ response in
            
            if response.result.value != nil {
                
                self.subCategoryData = JSON(data: response.result.value!)
                self.tableView.reloadData()
            }
            
            SVProgressHUD.dismiss()
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if subCategoryData.count > 0
        {
            return subCategoryData.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subProductCategoryCell", for: indexPath)
        cell.textLabel?.text = subCategoryData["product_cat"][indexPath.row]["name"].stringValue
        
        //productCategoryCell
        return cell

    }
    
    
}
