//
//  EditEntryController.swift
//  Keepwords
//
//  Created by a on 26/02/20.
//  Copyright © 2020 Gaw. All rights reserved.
//

import UIKit

class EditEntryController: UIViewController {

    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var image: UIImageView!
    @IBAction func editPhoto(_ sender: UIButton) {
    }
    @IBOutlet weak var titleTextField: UITextField!
    @IBAction func titleAction(_ sender: UITextField) {
        emailTextField.isUserInteractionEnabled = true
        usernameTextField.isUserInteractionEnabled = true
        passwordTextField.isUserInteractionEnabled = true
        urlTextField.isUserInteractionEnabled = true
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func emailAction(_ sender: UITextField) {
        emailTextField.isUserInteractionEnabled = true
        usernameTextField.isUserInteractionEnabled = true
        passwordTextField.isUserInteractionEnabled = true
        urlTextField.isUserInteractionEnabled = true
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBAction func usernameAction(_ sender: UITextField) {
        emailTextField.isUserInteractionEnabled = true
        usernameTextField.isUserInteractionEnabled = true
        passwordTextField.isUserInteractionEnabled = true
        urlTextField.isUserInteractionEnabled = true
    }
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func passAction(_ sender: UITextField) {
        emailTextField.isUserInteractionEnabled = true
        usernameTextField.isUserInteractionEnabled = true
        passwordTextField.isUserInteractionEnabled = true
        urlTextField.isUserInteractionEnabled = true
    }
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBAction func urlAction(_ sender: UITextField) {
        emailTextField.isUserInteractionEnabled = true
        usernameTextField.isUserInteractionEnabled = true
        passwordTextField.isUserInteractionEnabled = true
        urlTextField.isUserInteractionEnabled = true
    }
    
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        if keyMainTitle != titleTextField.text! {
            myInfo.removeValue(forKey: keyMainTitle)
            userDefaults.set(myInfo, forKey: "note")
            userDefaults.set(titleTextField.text!, forKey: "title")
            userDefaults.synchronize()
        }
        
        myInfo[titleTextField.text!] = ["email": emailTextField.text!, "user": usernameTextField.text!, "pass": passwordTextField.text!, "url": urlTextField.text!, "note": noteTextView.text]
        userDefaults.set(myInfo, forKey: "note")
        userDefaults.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
        
    }
    @IBAction func deleteButton(_ sender: UIButton) {
        showSimpleActionSheet()
    }
    
    func showSimpleActionSheet() {
        let alert = UIAlertController(title: "Are you sure to delete the entry?", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            print("User click Delete button")
            self.myInfo.removeValue(forKey: self.keyMainTitle)
            self.userDefaults.set(self.myInfo, forKey: "note")
            self.userDefaults.set("deleted", forKey: "delete")
            self.userDefaults.synchronize()
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    var keyMainTitle = String()
    
    var mainTitle = [String]()
    
    var myInfo = [String: [String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myInfo = userDefaults.object(forKey: "note") as! [String: [String:String]]
        titleTextField.text = keyMainTitle
        emailTextField.text = myInfo[keyMainTitle]!["email"] ?? ""
        usernameTextField.text = myInfo[keyMainTitle]!["user"] ?? ""
        passwordTextField.text = myInfo[keyMainTitle]!["pass"] ?? ""
        urlTextField.text = myInfo[keyMainTitle]!["url"] ?? ""
        noteTextView.text = myInfo[keyMainTitle]!["note"] ?? ""
        
        emailTextField.isUserInteractionEnabled = false
        usernameTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        urlTextField.isUserInteractionEnabled = false
        
    }
    

}
