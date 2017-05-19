//
//  ChatMessageViewController.swift
//  kaidee
//
//  Created by g5 on 5/2/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//


import UIKit
import Firebase
import SVProgressHUD
import SDWebImage
import CoreLocation

class ChatMessageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    
    struct messageStrc {
        var id :String!
        var name : String!
        var text : String!
        var type : String!
        var lat : String!
        var long : String!
    }
    
    var messageArray : [messageStrc] = []
    let user = UserDefaults()
    var selectLat : String!
    var selectLong :String!
    
    private let messageQueryLimit: UInt = 25
    private lazy  var messageRef: FIRDatabaseReference! = FIRDatabase.database().reference().child("messages")
    private var newMessageRefHandle: FIRDatabaseHandle?

    
    @IBOutlet var chatTextField: UITextField!
    
    @IBOutlet var chatMessageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTextField.inputAccessoryView = UIView.init()
        chatTextField.keyboardDistanceFromTextField = 8
        chatTextField.delegate = self
        observeMessages()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.chatMessageTableView.tableViewScrollToBottom(animated: true)

    }
    
    private func observeAddNewMessage(with messageQuery: FIRDatabaseQuery) {
        // TODO: - observe childAdded
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
            let messageData = snapshot.value as! Dictionary<String, String>
            
                let _id = messageData["id"] as String!
                let _name = messageData["name"] as String!
                let _text = messageData["text"] as String!
                let _type = messageData["type"] as String!
                let _lat = messageData["lat"] as String!
                let _long = messageData["long"] as String!
            
            print(messageStrc.init(id: _id!, name: _name!, text: _text!, type: _type!, lat: _lat!, long: _long!))
            self.messageArray.append(messageStrc.init(id: _id!, name: _name!, text: _text!, type: _type!, lat: _lat!, long: _long!))
            
            
            self.chatMessageTableView.reloadData()
            

            self.chatMessageTableView.tableViewScrollToBottom(animated: true)
            
//            self.chatMessageTableView.scrollToRow(at: indexPath as IndexPath, at:.bottom, animated: true)
            
//                self.addMessage(withId: id, name: displayName, text: text)
//                self.downloadCircleAvatar(with: avatar, avatarImage: self.prepareAvatarImage(with: id))
//                self.finishReceivingMessage()
            })
    }
    
    private func observeMessages() {
        let messageQuery = messageRef.queryLimited(toLast: messageQueryLimit)
        observeAddNewMessage(with: messageQuery)
    }
    
    @IBAction func sendButtonOnTouch(_ sender: Any) {
    
        
        messageRef.childByAutoId().setValue([
            "id":user.value(forKey: "id")!,
            "name":user.value(forKey: "first_name"),
            "text":chatTextField.text!,
            "type":"text",
             "lat":"-",
            "long":"-"
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
    
    
        return messageArray.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmp = messageArray[indexPath.row].id
        
        if (tmp != "\(user.value(forKey: "id")!)")
        {
            let cell : chatBuyerTableCell = tableView.dequeueReusableCell(withIdentifier: "chatBuyerTableCell", for: indexPath) as! chatBuyerTableCell
      
            cell.userName.text = messageArray[indexPath.row].name
            cell.userMessage.text = messageArray[indexPath.row].text
            
            if messageArray[indexPath.row].type == "location"
            {
                

                cell.userLocation.isHidden = false
                cell.userLocation.sd_setImage(with: URL.init(string: "http://maps.google.com/maps/api/staticmap?size=320x200&scale=2&maptype=roadmap&format=jpg&language=th&sensor=false&zoom=15&markers=\(messageArray[indexPath.row].lat!),\(messageArray[indexPath.row].long!)"))
                let tapLocation = UITapGestureRecognizer(target: self, action: #selector(locationOnTouch(gesture:)))
                cell.userLocation.addGestureRecognizer(tapLocation)
                
            }
            else
            {
                cell.userLocation.isHidden = true
                
            }
            
            return cell
        }
        else
        {
            let cell : chatSellerTableCell = tableView.dequeueReusableCell(withIdentifier: "chatSellerTableCell", for: indexPath) as! chatSellerTableCell

            cell.userName.text = messageArray[indexPath.row].name
            cell.userMessage.text = messageArray[indexPath.row].text

            
            if messageArray[indexPath.row].type == "location"
            {

                cell.userLocation.isHidden = false
                cell.userLocation.sd_setImage(with: URL.init(string: "http://maps.google.com/maps/api/staticmap?size=320x200&scale=2&maptype=roadmap&format=jpg&language=th&sensor=false&zoom=15&markers=\(messageArray[indexPath.row].lat!),\(messageArray[indexPath.row].long!)"))
                let tapLocation = UITapGestureRecognizer(target: self, action: #selector(locationOnTouch(gesture:)))
                cell.userLocation.addGestureRecognizer(tapLocation)
                
            }
            else
            {
                cell.userLocation.isHidden = true
            
            }
            
            return cell
        
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if messageArray[indexPath.row].type == "location"
        {
            return 140
        }
        
        return 70
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        print("tap tap")
        self.view.endEditing(true)
        
        if messageArray[indexPath.row].type == "location"
        {
            
            selectLat =   messageArray[indexPath.row].lat!
            selectLong =   messageArray[indexPath.row].long!
            performSegue(withIdentifier: "openMapSegue", sender: nil)

        }
        
    }
    
    func locationOnTouch(gesture: UITapGestureRecognizer)
    {
        
        print(gesture)
        
    }
    
    @IBAction func shareMap(_ sender: Any) {
        
        performSegue(withIdentifier: "shareMapSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    
        if (segue.identifier == "shareMapSegue") {
            let svc = segue.destination as! ChatMapViewController
            svc.callback = { filter in
                
                self.messageRef.childByAutoId().setValue([
                    "id":self.user.value(forKey: "id")!,
                    "name":self.user.value(forKey: "first_name"),
                    "text":"-",
                    "type":"location",
                    "lat":filter.lat,
                    "long":filter.long
                    ])
                
            }
            
        }
        
        if (segue.identifier == "openMapSegue") {
            let svc = segue.destination as! ChaTOpenMap
            svc.lat = selectLat
            svc.long = selectLong
            
        }
        
        
        
    }
    
    

}
extension UITableView {
    
    func tableViewScrollToBottom(animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                self.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: animated)
            }
        }
    }
}
