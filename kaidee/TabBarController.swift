//
//  TabBarController.swift
//  kaidee
//
//  Created by toktak on 5/9/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
class TabBarController: UITabBarController ,UITabBarControllerDelegate{
    
    let user = UserDefaults()
    
    override func viewDidLoad() {

        self.delegate = self

    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    
        
        print(item.badgeValue)
        if (user.value(forKey: "id") == nil)
        {
            performSegue(withIdentifier: "userLoginSegue", sender: nil)
        }
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        print("tabBarController shouldSelect")
        
        if tabBarController.selectedIndex == 0
        {
            
            print("=== \(tabBarController.selectedIndex) \(user.value(forKey: "id"))")
            
            if user.value(forKey: "id") == nil
            {
                return false
            }
            else
            {
                return true
            }
        }
        else
        {

                return true
        }
        
    }
    
    
    
}
