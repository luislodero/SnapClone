//
//  SnapsViewController.swift
//  SnapClone
//
//  Created by Luis Lopez on 6/23/17.
//  Copyright © 2017 Luis Lopez. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController {
    
    var snaps : [Snap] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded, with: { (snapshot) in print(snapshot)
            
            let snap = Snap()
            
            if let userDictionary = snapshot.value as? NSDictionary{
                
                if case let snap??imageURL = userDictionary["imageURL"] as? String{
            
            snap.imageURL = snapshot.value!["imageURL"] as! String
            snap.from = snapshot.value!["from"] as! String
            snap.descrip = snapshot.value!["description"] as! String
            
            self.snaps.append(snap)
                }
            

            
//            let user = Snap()
//            
//            if let userDictionary = snapshot.value as? NSDictionary{
//                
//                if let email = userDictionary["email"] as? String{
//                    
//                    
//                    user.email = email
//                    user.uid = snapshot.key
//                    
//                    self.users.append(user)
//                    
//                    self.tableView.reloadData()
                })
    }

    

    @IBAction func logOutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
}
