//
//  subCategoryListCollectionCell.swift
//  kaidee
//
//  Created by g5 on 5/1/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage


class subCategoryListCollectionCell: UICollectionReusableView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    let adsList = ["banner1","banner2","banner3"]
    
    let imageList = ["toyota1","bmw1","honda1"]
    
    @IBOutlet var carousel: iCarousel!
    
    @IBOutlet weak var subCategoryListCollection: UICollectionView!
    
    var subCategoryData : JSON!
    
    func getCategoryDate(data:JSON)
    {
        subCategoryData = data
        subCategoryListCollection.delegate = self
        subCategoryListCollection.dataSource = self
    }
    
    override func draw(_ rect: CGRect) {
        

        
    }
    

    //MARK:- Collection View
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : subCategoryCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "subCategoryCollectionCell", for: indexPath) as! subCategoryCollectionCell
        
        cell.categoryImage.sd_setImage(with: URL.init(string: subCategoryData[indexPath.row]["image_path"].stringValue))
        cell.categoryLabel.text = subCategoryData[indexPath.row]["name"].stringValue
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        //120:185
        
        let padding = 5
        let cellPerRow = 3
        let width = ( Int(subCategoryListCollection.frame.width) - padding * (cellPerRow+1) )/cellPerRow
        
        return CGSize.init(width: width, height:width)
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: Notification.Name("SubCategoryToProductList"), object: subCategoryData[indexPath.row])

    }
    
}
