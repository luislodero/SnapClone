//
//  SelectUserViewController.swift
//  SnapClone
//
//  Created by Luis Lopez on 6/30/17.
//  Copyright © 2017 Luis Lopez. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    var imageURL = ""
    
    var descrip = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: { (snapshot) in print(snapshot)
            
            let user = User()
            
            if let userDictionary = snapshot.value as? NSDictionary{
                
                if let email = userDictionary["email"] as? String{
            
                    
                    user.email = email
                    user.uid = snapshot.key
                    
                    self.users.append(user)
                    
                    self.tableView.reloadData()
                    }
                }
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        let snap = ["from": user.email, "description": descrip, "imageURL": imageURL]
        
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
    }
   
}
