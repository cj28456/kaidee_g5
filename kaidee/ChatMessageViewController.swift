//
//  ChatMessageViewController.swift
//  kaidee
//
//  Created by toktak on 5/2/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//


import UIKit
import Firebase

class ChatMessageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    

    

    var ref: FIRDatabaseReference!

    let user = UserDefaults()
    
    @IBOutlet var chatTextField: UITextField!
    
    @IBOutlet var chatMessageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference(withPath: "message")
        
        ref.observe(.value, with: { snapshot in
     
            let snapshotValue = snapshot.value as! [String: AnyObject]


            for item in snapshot.children {
                
    
                
            }

        })
        

        
        self.chatTextField.inputAccessoryView = UIView.init()
        self.chatTextField.keyboardDistanceFromTextField = 8
    }
    
    @IBAction func sendButtonOnTouch(_ sender: Any) {
    
        
        ref.child("message").childByAutoId().setValue([
            "text":chatTextField.text!,
            "sender":user.value(forKey: "first_name"),
            "imageUrl":"-",
            "type":"text"
            ])
        
        chatTextField.text = ""
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {

        self.view.endEditing(true)

    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if ("id" == "buyer")
        {
            let cell : chatBuyerTableCell = tableView.dequeueReusableCell(withIdentifier: "chatBuyerTableCell", for: indexPath) as! chatBuyerTableCell

            return cell
        }
        else
        {
            let cell : chatSellerTableCell = tableView.dequeueReusableCell(withIdentifier: "chatSellerTableCell", for: indexPath) as! chatSellerTableCell

            return cell
        
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.view.endEditing(true)
        
    }
    
    

}

