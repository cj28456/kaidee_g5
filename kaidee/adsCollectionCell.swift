//
//  adsCollectionCell.swift
//  kaidee
//
//  Created by g5 on 4/30/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//


import UIKit

class adsCollectionCell : UICollectionReusableView,iCarouselDelegate,iCarouselDataSource {
    
    let imageList = ["banner1","banner2","banner3"]
    
    @IBOutlet var carousel: iCarousel!
    
    
    override func draw(_ rect: CGRect) {
        
        
        
        carousel.type = .linear
        carousel.isPagingEnabled = true
        carousel.delegate = self
        carousel.dataSource = self
        
    }
    
    //MARK:- carousel
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return imageList.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        print(carousel)
        var itemView: UIImageView
        
        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
                   } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width*120/375))
            itemView.image = UIImage(named: "\(imageList[index])")

        }
        

        
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        
        switch (option)
        {
        case .wrap:
            return 1
            
        case .spacing:
            return value * 1
            
        default:
            return value
        }
                
    }
}
