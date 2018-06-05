//
//  CamerasViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 6/4/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import UIKit
import RealmSwift
import IQKeyboardManagerSwift

class CamerasViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var makerText: UITextField!
    
    @IBOutlet weak var typeText: UITextField!
    
    @IBOutlet weak var picker: UIPickerView!
    
    let realm = try! Realm()
    
    var tasks: Results<CustomCamera>!
    
    var icon = ""
    
    var titles = ""
    
    var catagory = 0
    
    var rowSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom Cameras"
        tasks = CustomCamera().sortCamerasForPicker()
        picker.delegate = self
        picker.dataSource = self
        IQKeyboardManager.shared.enable = true
    }

    @IBAction func addCustomCamAction(_ sender: Any) {
        getNewCamera()
    }
    
    @IBAction func addCamFromPicker(_ sender: Any) {
        createNewTableviewRow(maker: tasks[rowSelected].maker, type: tasks[rowSelected].type)
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func deleteCameraSelected(_ sender: Any) {
        if tasks.count == 1 {
            Alert.showBasic(title: "Warning", message: "Can't delete last custom camera.", vc: self)
        } else {
            let thisCam = tasks[rowSelected].taskID
            CustomCamera().deleteCamera(taskID: thisCam)
            rowSelected = rowSelected - 1
            picker.reloadAllComponents()
        }
    }
    
    func getNewCamera() {
        
        guard let newMaker = makerText.text else {
            return
        }
        
        guard let newType = typeText.text else {
            return
        }
        
        if newType.isEmpty {
            Alert.showBasic(title: "Missing Info", message: "Please add a Camera Type.", vc: self)
        }
        
        if newMaker.isEmpty {
            Alert.showBasic(title: "Missing Info", message: "Please add a Camera Maker.", vc: self)
        }

        CustomCamera().saveCameraToRealm(type: newType, maker: newMaker)
        _ = navigationController?.popViewController(animated: true)
        createNewTableviewRow(maker: newMaker, type: newType)
    }
    
    func createNewTableviewRow(maker:String, type:String) {
        let newRow = TableViewRow()
        newRow.icon = icon
        newRow.title = titles
        newRow.detail = "\(maker ) \(type)"
        newRow.catagory = catagory
        
        let currentEvent = RealmHelp().getLastEvent()   //
        
        try! realm.write {
            currentEvent.tableViewArray.append(newRow)
        }
        RealmHelp().sortRealmEvent()
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowSelected = row
    }

}
