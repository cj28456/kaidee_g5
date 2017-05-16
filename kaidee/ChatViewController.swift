//
//  ChatViewController.swift
//  kaidee
//
//  Created by g5 on 4/27/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController : UIViewController,UITableViewDataSource {
    
    let user = UserDefaults()
    
    struct chat {
        var date : String!
        var message : String!
        var userimg : String!
        var username : String!
        var itemimg : String!
    }
    
    var chatMessage : [chat] = [chat.init(date: "3", message: "ของยังอยู่ไหม", userimg: "user1", username: "Jonh", itemimg: "toyota1"),chat.init(date: "10", message: "ลดได้ไหม", userimg: "user2", username: "Jack", itemimg: "toyota2")]
    
    var ref: FIRDatabaseReference!

    
    @IBOutlet var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = FIRDatabase.database().reference()
    
        ref.observeSingleEvent(of: .childAdded, with: { (snapshot) in
            if let userDict = snapshot.value as? [String:Any] {
                //Do not cast print it directly may be score is Int not string
                print(userDict)
            }
        })
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        

        
        if user.value(forKey: "id") == nil
        {
            chatTableView.isHidden = true
            
            tabBarController?.selectedIndex = 0
        }
        else
        {
            chatTableView.isHidden = false
            
            
        }
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : chatTableCell = tableView.dequeueReusableCell(withIdentifier: "chatTableCell", for: indexPath) as! chatTableCell
        
        cell.chatDate.text = "\(chatMessage[indexPath.row].date!) วันก่อน"
        cell.userMessage.text = "\(chatMessage[indexPath.row].message!)"
        cell.userName.text = "\(chatMessage[indexPath.row].username!)"
        cell.userImage.image = UIImage.init(named: "\(chatMessage[indexPath.row].userimg!)")
        cell.itemImage.image = UIImage.init(named: "\(chatMessage[indexPath.row].itemimg!)")

        return cell
    }
    
    
}
