//
//  AddController.swift
//  Keepwords
//
//  Created by a on 18/12/19.
//  Copyright © 2019 Gaw. All rights reserved.
//

import UIKit
import Photos
import AVFoundation


class AddController: UIViewController {
    
    var myInfo = [String: [String:String]]()
    
    let userDefaults = UserDefaults.standard

    @IBOutlet weak var titleTextField: UITextField!
    @IBAction func titleActionTextFIeld(_ sender: UITextField) {
        if titleTextField.text != "" {
            doneOutletButton.isEnabled = true
            doneOutletButton.tintColor = .systemBlue
        } else {
            doneOutletButton.isEnabled = false
            doneOutletButton.tintColor = .gray
        }
    }
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var doneOutletButton: UIBarButtonItem!
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        myInfo[titleTextField.text!] = ["email": emailTextField.text!, "user": usernameTextField.text!, "pass": passwordTextField.text!, "url": urlTextField.text!, "note": notesTextView.text!]
        self.userDefaults.set(myInfo, forKey: "note")
        self.userDefaults.synchronize()
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTextView.layer.borderColor = UIColor.lightGray.cgColor
        notesTextView.layer.borderWidth = 1
        notesTextView.layer.cornerRadius = 5
        
        if self.userDefaults.value(forKey: "note") != nil {
            myInfo = userDefaults.object(forKey: "note") as! [String: [String:String]]
        } else {
            userDefaults.set(myInfo, forKey: "note")
        }
        
        doneOutletButton.isEnabled = false
        doneOutletButton.tintColor = .gray
       
    }

}
