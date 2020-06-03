//
//  SettingViewController.swift
//  Keepwords
//
//  Created by a on 27/05/20.
//  Copyright © 2020 Gaw. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var RepasswordTextField: UITextField!
    
    @IBAction func Save(_ sender: UIButton) {
        if PasswordTextField.text == RepasswordTextField.text {
            self.userDefaults.set(PasswordTextField.text, forKey: "front")
            self.userDefaults.synchronize()
        } else {
            print("The password is not equal")
        }
        
    }
    
    @IBAction func Switch(_ sender: UISwitch) {
        if SwitchOutlet.isOn == false {
            self.userDefaults.removeObject(forKey: "front")
        } else {
            self.userDefaults.set("", forKey: "front")
        }
    }
    
    @IBOutlet weak var SwitchOutlet: UISwitch!
    
    let userDefaults = UserDefaults.standard
 
    override func viewDidLoad() {
        super.viewDidLoad()
        if userDefaults.object(forKey: "front") == nil {
            SwitchOutlet.isOn = false
        } else {
             SwitchOutlet.isOn = true
        }
       
    }
    

}
