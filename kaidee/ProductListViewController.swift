//
//  itemListViewController.swift
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

class ProductListViewController : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let rating = ["","⭐️","⭐️⭐️","⭐️⭐️⭐️","⭐️⭐️⭐️⭐️","⭐️⭐️⭐️⭐️⭐️"]

    var categoryTitle : String!
    var categoryId : String!
    var subCategoryData : JSON!

    var selectedTitle : String!
    var selectId : String!
    
    
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("https://group5-kaidee-resolution.herokuapp.com/get_product/\(categoryId!)")
        

        SVProgressHUD.show()
        
        Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/get_product_in_subcat/\(categoryId!)",method:.get, parameters: nil).responseData{ response in
            
            
            if response.result.value != nil {
                
                self.subCategoryData = JSON(data: response.result.value!)
                
                print("subCategoryData \(self.subCategoryData)")
                
                self.productListCollectionView.delegate = self
                self.productListCollectionView.dataSource = self
                
            }
            
            SVProgressHUD.dismiss()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //MARK:- Collection View
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategoryData["product_in_subcat"].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : itemListCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemListCollectionCell", for: indexPath) as! itemListCollectionCell
        
        cell.itemNameLabel.text = subCategoryData["product_in_subcat"][indexPath.row]["name"].stringValue
        cell.itemImage.sd_setImage(with: URL.init(string: subCategoryData["product_in_subcat"][indexPath.row]["image_path"].stringValue))
        cell.itemPriceLabel.text = subCategoryData["product_in_subcat"][indexPath.row]["price"].stringValue
        cell.itemRatingLabel.text = rating[subCategoryData["product_in_subcat"][indexPath.row]["rating"].intValue]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let padding = 10
        let cellPerRow = 2
        let width = ( Int(productListCollectionView.frame.width) - padding * (cellPerRow+1) )/cellPerRow
        
        return CGSize.init(width: width, height:width+60)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        selectId = subCategoryData["product_in_subcat"][indexPath.row]["id"].stringValue
        
        self.performSegue(withIdentifier: "productListToProduct", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //get data from select
        if (segue.identifier == "productListToProduct") {
            let svc = segue.destination as! ProductDetailViewController
                        svc.productId = selectId

        }
        
        
        // select filter
        if (segue.identifier == "ProductFilter") {
            let svc = segue.destination as! FilterViewController
            svc.callback = { filter in
                
                
                
                print("https://group5-kaidee-resolution.herokuapp.com/get_product_in_subcat/\(self.categoryId!)?min_price=\(filter.min!)&max_price=\(filter.max!)&order_by=\(filter.sort!)&search_text=\(filter.searchText!)&main_filter=\(filter.main_filter!)&shipping=\(filter.shipping!)")
                
                
//                let para : Parameters = [
//                    "search_text": filter.searchText,
//                    "min_price" : filter.min,
//                    "max_price" : filter.max,
//                    "order_by": filter.sort
//                ]
                
                SVProgressHUD.show()
                //simple request
                Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/get_product_in_subcat/\(self.categoryId!)?min_price=\(filter.min!)&max_price=\(filter.max!)&order_by=\(filter.sort!)&search_text=\(filter.searchText!)&main_filter=\(filter.main_filter!)&shipping=\(filter.shipping!)",method:.post, parameters: nil).responseData{ response in
                    
                    print("login \(response)")
                    
                    if response.result.value != nil {
                        
                        self.subCategoryData = JSON(data: response.result.value!)
                        self.productListCollectionView.reloadData()
                        
                    }
                    
                    SVProgressHUD.dismiss()
                }
            }
        
        }
    }
    
}
