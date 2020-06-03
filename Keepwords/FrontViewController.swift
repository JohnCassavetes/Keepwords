//
//  FrontViewController.swift
//  Keepwords
//
//  Created by a on 27/05/20.
//  Copyright © 2020 Gaw. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {

    
    @IBOutlet weak var EnterPasswordTextField: UITextField!

    @IBAction func EnterButton(_ sender: UIButton) {
        
        if userDefaults.object(forKey: "front") as? String == EnterPasswordTextField.text {
            //ke ViewController
            performSegue(withIdentifier: "ToView", sender: nil)
        }
        
    }
    
    @IBOutlet weak var TheLabel: UILabel!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EnterPasswordTextField.isHidden = true
        
        TheLabel.isHidden = true
        
        if userDefaults.object(forKey: "front") == nil {
            //To view controller
            performSegue(withIdentifier: "ToView", sender: nil)
        } else {
            //show opening
            EnterPasswordTextField.isHidden = false
            
            TheLabel.isHidden = false
        }
        
    }
    
}
