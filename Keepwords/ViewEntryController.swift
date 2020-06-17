//
//  ViewEntryController.swift
//  Keepwords
//
//  Created by a on 19/02/20.
//  Copyright © 2020 Gaw. All rights reserved.
//

import UIKit

class ViewEntryController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
    }
    
    var keyMainTitle = String()
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toEdit"{
            let detailViewController = segue.destination as! EditEntryController
            detailViewController.keyMainTitle = keyMainTitle
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (userDefaults.object(forKey: "delete") != nil) {
            userDefaults.removeObject(forKey: "delete")
            userDefaults.synchronize()
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        } else {
        let myInfo = userDefaults.object(forKey: "note") as! [String: [String:String]]
        let title = userDefaults.object(forKey: "title") as? String ?? ""
        print("isinya \(myInfo)")
        if title != "" {
          keyMainTitle = title
        } else {
          userDefaults.removeObject(forKey: "title")
          userDefaults.synchronize()
        }
        userDefaults.removeObject(forKey: "title")
        userDefaults.synchronize()
        print("kunci: \(myInfo.keys)")
        print("key : \(title)")
        titleLabel.text = keyMainTitle
        emailLabel.text = myInfo[keyMainTitle]!["email"]
        userLabel.text = myInfo[keyMainTitle]!["user"]
        passwordLabel.text = myInfo[keyMainTitle]!["pass"]
        urlLabel.text = myInfo[keyMainTitle]!["url"]
            notesTextView.text = myInfo[keyMainTitle]!["note"] }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(keyMainTitle)
        userDefaults.removeObject(forKey: "title")
        userDefaults.synchronize()
        //var mainTitle = [String]()
        let myInfo = userDefaults.object(forKey: "note") as! [String: [String:String]]
        
        print("isinya \(myInfo)")
        
        print("kunci: \(myInfo.keys)")  
        
        titleLabel.text = keyMainTitle
        emailLabel.text = myInfo[keyMainTitle]?["email"]
        userLabel.text = myInfo[keyMainTitle]?["user"]
        passwordLabel.text = myInfo[keyMainTitle]?["pass"]
        urlLabel.text = myInfo[keyMainTitle]?["url"]
        notesTextView.text = myInfo[keyMainTitle]?["note"]
        
    }
}
