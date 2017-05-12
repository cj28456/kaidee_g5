//
//  NotificationViewController.swift
//  kaidee
//
//  Created by g5 on 5/2/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit

class NotificationViewController : UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let user = UserDefaults()
    
    @IBOutlet var notiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : notiTableCell = tableView.dequeueReusableCell(withIdentifier: "notiTableCell", for: indexPath) as! notiTableCell
        
        return cell
        
    }
    
    
}
