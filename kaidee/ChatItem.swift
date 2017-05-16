//
//  ChatItem.swift
//  kaidee
//
//  Created by toktak on 5/16/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import Foundation
import Firebase

struct ChatItem {
    
    let key: String
    
    let sender: String
    let text: String
    var type: String
    var uid: String
    
    let ref: FIRDatabaseReference?
    
//    init(sender: String, text: String, type: String, uid: String,key:String = "")
//    {
//        self.key = key
//        self.sender = sender
//        self.text = text
//        self.type = type
//    }
//    
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        sender = snapshotValue["sender"] as! String
        text = snapshotValue["text"] as! String
        type = snapshotValue["type"] as! String
        uid = snapshotValue["uid"] as! String
        
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": sender,
            "text": text,
            "type": type,
            "uid": uid
        ]
    }
}
