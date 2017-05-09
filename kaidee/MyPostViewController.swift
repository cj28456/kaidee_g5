//
//  SecondViewController.swift
//  kaidee
//
//  Created by g5 on 4/27/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit

class MyPostViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let user = UserDefaults()

    
    struct post {
        var postdata : String!
        var postimg : String!
        var posttitle : String!
        var postprice : String!
    }
    
    let mypost : [post]  = [ post.init(postdata: "5", postimg: "toyota1", posttitle: "Toyota 2014", postprice: "310,000"),post.init(postdata: "10", postimg: "toyota2", posttitle: "Toyota 2002", postprice: "200,000"),post.init(postdata: "10", postimg: "bmw1", posttitle: "BMW 2014", postprice: "950,000")]
    
    @IBOutlet weak var myPostTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if user.value(forKey: "id") == nil
        {
            myPostTableView.isHidden = true
            
            tabBarController?.selectedIndex = 0
        }
        else
        {
            myPostTableView.isHidden = false
            
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : myPostTableCell = tableView.dequeueReusableCell(withIdentifier: "myPostTableCell", for: indexPath) as! myPostTableCell
        
        cell.postDate.text = "เหลือ \(mypost[indexPath.row].postdata!) วัน"
        cell.postImage.image = UIImage.init(named: mypost[indexPath.row].postimg!)
        cell.postTitle.text = mypost[indexPath.row].posttitle!
        cell.postPrice.text = "\(mypost[indexPath.row].postprice!) บาท"
        
            return cell
            

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mypost.count
    }
    

}

