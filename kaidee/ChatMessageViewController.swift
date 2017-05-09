//
//  ChatMessageViewController.swift
//  kaidee
//
//  Created by toktak on 5/2/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//


import UIKit

class ChatMessageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet var chatMessageTableView: UITableView!
    
    struct chat {
        var userType : String!
        var userMessage : String!
        var userName : String!
        var userLocation : String!
        var userLocationEnable : Bool!
        var userImage : String!

    }
    
    
    let chatlog : [chat] = [chat.init(userType: "buyer", userMessage: "ขอยังอยู่ไหม", userName:"John", userLocation: "-", userLocationEnable: false,userImage: "user1"),
                            chat.init(userType: "buyer", userMessage: "อยากดุของครับ", userName:"John", userLocation: "-", userLocationEnable: false,userImage: "user1"),
                            chat.init(userType: "seller", userMessage: "ขอยังอยู่ครับ", userName:"Me", userLocation: "-", userLocationEnable: false,userImage: "user2"),
                            chat.init(userType: "seller", userMessage: "สะดวกที่ไหนครับ", userName:"Me", userLocation: "-", userLocationEnable: false,userImage:"user2"),
                            chat.init(userType: "buyer", userMessage: "สยามครับ", userName:"John", userLocation: "-", userLocationEnable: false,userImage :"user1"),
                            ]
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatlog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("\(chatlog[indexPath.row].userImage)")
        print(chatlog[indexPath.row].userType)
        
        if ("\(chatlog[indexPath.row].userType!)" == "buyer")
        {
            let cell : chatBuyerTableCell = tableView.dequeueReusableCell(withIdentifier: "chatBuyerTableCell", for: indexPath) as! chatBuyerTableCell
            cell.userImage.image =  UIImage.init(named: "\(chatlog[indexPath.row].userImage!)")
            cell.userMessage.text = "\(chatlog[indexPath.row].userMessage!)"
            cell.userName.text = "\(chatlog[indexPath.row].userName!)"
            return cell
        }
        else
        {
            let cell : chatSellerTableCell = tableView.dequeueReusableCell(withIdentifier: "chatSellerTableCell", for: indexPath) as! chatSellerTableCell
            cell.userImage.image = UIImage.init(named: "\(chatlog[indexPath.row].userImage!)")
            cell.userMessage.text = "\(chatlog[indexPath.row].userMessage!)"
            cell.userName.text = "\(chatlog[indexPath.row].userName!)"
            return cell
        
        }
        
    }
    
    
    

}

