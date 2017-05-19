//
//  SubProductCategoryTableViewController.swift
//  kaidee
//
//  Created by g5 on 5/12/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class SubProductCategoryTableViewController: UITableViewController {
    
    struct categoryStrc {
        
        var mainCat : String!
        var subCat : String!
        var mainCatTitle : String!
        var subCatTitle : String!
        
    }
    
    var categoryId : String!
    var categoryTitle : String!

    var subCategoryData : JSON!
    var select : categoryStrc!
    
    override func viewDidLoad() {
        
        print("categoryId \(categoryId)")
        SVProgressHUD.show()
        //simple request
        Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/get_product_sub_cat/\(categoryId!)",method:.get, parameters: nil).responseData{ response in
            
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
        
        if subCategoryData != nil
        {
            return subCategoryData["product_sub_cat"].count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subProductCategoryCell", for: indexPath)
        cell.textLabel?.text = subCategoryData["product_sub_cat"][indexPath.row]["name"].stringValue
        
        //productCategoryCell
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("selected id")
        
        print(subCategoryData["product_sub_cat"][indexPath.row]["parent_category_id"].stringValue)
        print(subCategoryData["product_sub_cat"][indexPath.row]["id"].stringValue)
        
        //select = categoryStrc.init(mainCat: subCategoryData["product_sub_cat"][indexPath.row]["parent_category_id"].stringValue, subCat: subCategoryData["product_sub_cat"][indexPath.row]["id"].stringValue)
        
        select = categoryStrc.init(mainCat: subCategoryData["product_sub_cat"][indexPath.row]["parent_category_id"].stringValue, subCat: subCategoryData["product_sub_cat"][indexPath.row]["id"].stringValue, mainCatTitle: categoryTitle, subCatTitle: subCategoryData["product_sub_cat"][indexPath.row]["name"].stringValue)
        
        performSegue(withIdentifier: "backToAddView", sender: "hello")
        
        
    }
    
    
}
