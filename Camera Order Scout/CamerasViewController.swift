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
        getNewCamera()
    }
    
    func getNewCamera() {
        
        guard let newMaker = makerText.text else {
            print("Maker text missing")
            return
        }
        print("Maker: \(newMaker)")
        
        guard let newType = typeText.text else {
            print("Maker text missing")
            return
        }
        print("Type: \(newType)")
        
        if newType.isEmpty {
            Alert.showBasic(title: "Missing Info", message: "Please add a Camera Type.", vc: self)
        }
        
        if newMaker.isEmpty {
            Alert.showBasic(title: "Missing Info", message: "Please add a Camera Maker.", vc: self)
        }
        
        // [X] make realm object to save custom camera
        CustomCamera().saveCameraToRealm(type: newType, maker: newMaker)
        // [ ] populate picker
        // [ ] return custom camera to main view
    }

}
