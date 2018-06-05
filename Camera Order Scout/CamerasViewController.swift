//
//  CamerasViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 6/4/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//




import UIKit
import RealmSwift

class CamerasViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var makerText: UITextField!
    
    @IBOutlet weak var typeText: UITextField!
    
    @IBOutlet weak var picker: UIPickerView!
    
    let realm = try! Realm()
    
    var tasks: Results<CustomCamera>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom Cameras"
        tasks = CustomCamera().sortCamerasForPicker()
        
        print("\nShowing realm custom cameras:")
        for each in tasks {
            print("Maker: \(each.maker)  Type: \(each.type)")
        }
        
        picker.delegate = self
        picker.dataSource = self
    }

    @IBAction func addCustomCamAction(_ sender: Any) {
        getNewCamera()
    }
    
    // set up picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tasks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(tasks[row].maker ) - \(tasks[row].type)"
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
        // [X] populate picker from array of realm objects
        CustomCamera().saveCameraToRealm(type: newType, maker: newMaker)
        // [ ] return custom camera to main view
        _ = navigationController?.popViewController(animated: true)
        // pass the camera in
    }

}
