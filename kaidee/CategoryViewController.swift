//
//  CategoryViewController.swift
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


class CategoryViewController : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    var categoryData : JSON!
    var selectedCategory : String!
    var selectedTitle : String!
    

    var carousel: iCarousel!
    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let para : Parameters = [
//            "email" : username.text!,
//            "password" : password.text!
//        ]

        SVProgressHUD.show()
        //simple request
        Alamofire.request("https://group5-kaidee-resolution.herokuapp.com/get_product_cat",method:.get, parameters: nil).responseData{ response in
            
            print("login \(response)")
            
            if response.result.value != nil {
                
                self.categoryData = JSON(data: response.result.value!)
                
                
                print("self.categoryData \(self.categoryData)")

                self.categoryCollectionView.delegate = self
                self.categoryCollectionView.dataSource = self
  
            }
            
            SVProgressHUD.dismiss()
        }
        
        
        //flowLayout.headerReferenceSize = CGSize(width: self.collectionView.height, height: 100)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    //MARK:- Collection View
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //add ads collection header
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            
            //adsCollectionCell is in CustomCell header
            let headerView : adsCollectionCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "adsCollectionCell", for: indexPath) as! adsCollectionCell
            
            
            return headerView
            

        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryData["product_cat"].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

            let cell : categoryCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionCell", for: indexPath) as! categoryCollectionCell
            
            cell.categoryLabel.text = "\(categoryData["product_cat"][indexPath.row]["name"])"
            cell.categoryImage.sd_setImage(with: URL.init(string: "\(categoryData["product_cat"][indexPath.row]["image_path"])"))
            
            return cell

        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // custom collection cell size
        
            let padding = 10
            let cellPerRow = 3
            let width = ( Int(categoryCollectionView.frame.width) - padding * (cellPerRow+1) )/cellPerRow
            return CGSize.init(width: width, height:width)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        // custom collection header height
        return CGSize(width: categoryCollectionView.bounds.width, height: categoryCollectionView.bounds.width*120/375)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //pass data to next page (SubCategoryViewController)
        
        selectedTitle = categoryData["product_cat"][indexPath.row]["name"].stringValue
        selectedCategory = categoryData["product_cat"][indexPath.row]["id"].stringValue
        
        
        self.performSegue(withIdentifier: "categoryToSubCategory", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        //prepare to send data
        if (segue.identifier == "categoryToSubCategory") {
            let svc = segue.destination as! SubCategoryViewController
            
            svc.categoryId = selectedCategory
            svc.title = selectedTitle

        }
        
    }
    
}


