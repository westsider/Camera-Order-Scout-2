//
//  CamerasViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 6/4/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import UIKit

class CamerasViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var makerText: UITextField!
    
    @IBOutlet weak var typeText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addCustomCamAction(_ sender: Any) {
        
        if let newMaker = makerText.text {
            print("Maker: \(newMaker)")
        }
        
        if let newType = typeText.text {
            print("Type: \(newType)")
        }
    }
    

}
