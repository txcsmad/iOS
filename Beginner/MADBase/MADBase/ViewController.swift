//
//  ViewController.swift
//  MADBase
//
//  Created by Michael Brennan on 10/14/14.
//  Copyright (c) 2014 MADBase. All rights reserved.
//

import UIKit

var rootRef = Firebase(url:"https://blinding-inferno-4206.firebaseio.com")

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet var tableView: UITableView!
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        rootRef.observeEventType(FEventType.ChildAdded) {
            (snapshot: FDataSnapshot!) in
            if let snapshot = snapshot {
                let message = Message(snapshot: snapshot)
                self.messages.insert(message, atIndex: 0)
                self.tableView.reloadData()
            }
        }
        
//        writeMessage(rootRef, Message(user: "Michael", body: "UI Stuff"))
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("message") as UITableViewCell
        
        cell.detailTextLabel?.text = message.user
        cell.textLabel?.text = message.body
        
        return cell
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

struct Message {
    
    let user: String
    let body: String
    let timestamp: NSDate
    
    init (user: String, body: String) {
        self.user = user
        self.body = body
        self.timestamp = NSDate()
    }
    
    init (snapshot: FDataSnapshot) {
        self.user = snapshot.value["user"] as String
        self.body = snapshot.value["body"] as String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-mm-dd HH:mm:ss +0000"
        self.timestamp = formatter.dateFromString(snapshot.name)!
    }
    
    var firebaseData: [NSObject : AnyObject] {
        return [timestamp.description : ["user" : user, "body" : body]]
    }
}

func writeMessage(firebase: Firebase, message: Message) {
    firebase.updateChildValues(message.firebaseData)
}