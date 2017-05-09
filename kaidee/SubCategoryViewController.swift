//
//  FirstViewController.swift
//  kaidee
//
//  Created by g5 on 4/27/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON
import SVProgressHUD

class SubCategoryViewController : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {


    var categoryTitle : String!
    var categoryId : String!
    
    var subCategoryData : JSON!
    var topCategory : JSON!

    
    var selectId : String!
    
    
    
    
    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("get_product_cat+\(categoryId!)")
        
        
        //notificaitio receiver to call function selectSubCategory
        //call from top sub category
        
        NotificationCenter.default.addObserver(self, selector:#selector(SubCategoryViewController.selectSubCategory), name: Notification.Name("SubCategoryToProductList"), object: nil)
        
        SVProgressHUD.show()
        
        Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/get_product_sub_cat/\(categoryId!)",method:.get, parameters: nil).responseData{ response in
            
            
            if response.result.value != nil {
                
                self.subCategoryData = JSON(data: response.result.value!)
                self.topCategory = self.subCategoryData
                
                print("subCategoryData \(self.subCategoryData)")
                
                self.subCategoryCollectionView.delegate = self
                self.subCategoryCollectionView.dataSource = self
                
            }
            
            SVProgressHUD.dismiss()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectSubCategory(notification: NSNotification){
    
        let tmp :JSON = notification.object as! JSON
        categoryTitle = tmp["name"].stringValue
        categoryId =  tmp["id"].stringValue
        //categoryId
        print(tmp)
        self.performSegue(withIdentifier: "SubCategoryToProductList", sender: nil)
    
    }
    
    
    //MARK:- Collection View
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //add top sub category collection header
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView : subCategoryListCollectionCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "subCategoryListCollectionCell", for: indexPath) as! subCategoryListCollectionCell
            headerView.getCategoryDate(data:self.topCategory["product_sub_cat"])
            
            
            return headerView
            

            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategoryData["product_in_cat"].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : itemCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCollectionCell", for: indexPath) as! itemCollectionCell

        cell.itemNameLabel.text = subCategoryData["product_in_cat"][indexPath.row]["name"].stringValue
        cell.itemImage.sd_setImage(with: URL.init(string: subCategoryData["product_in_cat"][indexPath.row]["image_path"].stringValue))
        
        cell.itemPriceLabel.text = subCategoryData["product_in_cat"][indexPath.row]["price"].stringValue
        cell.itemRatingLabel.text = "***"
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        //120:185
        

        let padding = 10
        let cellPerRow = 2
        let width = ( Int(subCategoryCollectionView.frame.width) - padding * (cellPerRow+1) )/cellPerRow
        
        return CGSize.init(width: width, height:width+60)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        

        return CGSize(width: subCategoryCollectionView.bounds.width, height: subCategoryCollectionView.bounds.width*120/375)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        selectId =  subCategoryData["product_in_cat"][indexPath.row]["id"].stringValue
        
        self.performSegue(withIdentifier: "subCategorytListToProduct", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //product ด้านล่าง
        if (segue.identifier == "subCategorytListToProduct") {
            let svc = segue.destination as! ProductDetailViewController
            svc.productId = selectId

        }

        // select top sub category
        if (segue.identifier == "SubCategoryToProductList") {
            let svc = segue.destination as! ProductListViewController
            svc.categoryId = categoryId
            svc.title = categoryTitle
            
        }
        
        
        // select filter
        if (segue.identifier == "SubCategoryFilter") {
            let svc = segue.destination as! FilterViewController
            svc.callback = { filter in
                
                print("https://group5-kaidee-resolution.herokuapp.com/get_product_sub_cat/\(self.categoryId!)?min_price=\(filter.min!)&max_price=\(filter.max!)&order_by=\(filter.sort!)&search_text=\(filter.searchText!)")
                SVProgressHUD.show()
                //simple request
                Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/get_product_sub_cat/\(self.categoryId!)?min_price=\(filter.min!)&max_price=\(filter.max!)&order_by=\(filter.sort!)&search_text=\(filter.searchText!)",method:.post, parameters: nil).responseData{ response in
                    
                    
                    
                    if response.result.value != nil {
                        
                        self.subCategoryData = JSON(data: response.result.value!)
                        self.subCategoryCollectionView.reloadData()
                        
                        print(self.subCategoryData)

                        
                    }
                    
                    SVProgressHUD.dismiss()
                }
            }
            
        }
    }

}

