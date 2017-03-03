//
//  AksKitViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/25/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//


import UIKit
import RealmSwift

class AksKitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleDescription: UILabel!
    
    var pickerEquipment = Equipment()
    
    let cellIdentifier = "aksTableViewCell"
    
    var pickerRow = 5
    
    var returnedString = ""
    
    let realm = try! Realm()
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pickerRow = pickerEquipment.pickerState[1]
        setUpUI()
    }
    
    //MARK: - Update main tableview
    @IBAction func updateAction(_ sender: Any) {
        
        returnedString = UniqueKits().finalizeKitArray(pickerRow: pickerRow) //finalizeKitArray()
        let newRow = TableViewRow()
        newRow.icon = pickerEquipment.pickerSelection[1]
        newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1]
        newRow.detail = returnedString
        newRow.catagory = pickerEquipment.pickerState[1] // added for sort
        let currentEvent = RealmHelp().getLastEvent()
        
        try! realm.write {
            currentEvent.tableViewArray.append(newRow)
        }
        
        RealmHelp().sortRealmEvent()
        _ = navigationController?.popToRootViewController(animated: true)
    }
    

    //MARK: - Add new items to kit
    @IBAction func addNewItemsAction(_ sender: Any) {
        
        let alertController : UIAlertController = UIAlertController(title: "New Item", message: "What would you like to add?", preferredStyle: .alert)
        
        alertController.addTextField { (UITextField) in }
        
        let action_cancel = UIAlertAction.init(title: "Cancel", style: .cancel) { (UIAlertAction) -> Void in }
        
        alertController.addAction(action_cancel)
        
        let action_add = UIAlertAction.init(title: "Add", style: .default) { (UIAlertAction) -> Void in
            let textField_todo = (alertController.textFields?.first)! as UITextField
            print("You entered \(textField_todo.text)")
            
            var textInput = ""
            if  textField_todo.text! != "" {
                textInput = textField_todo.text!
            }
            
        self.updateRealm(state: self.pickerRow, item: textInput, onOff: true)
            
        }
        alertController.addAction(action_add)
        
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Set up tableview  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UniqueKits().getAksLabelText(state: pickerRow, row: 0).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AKSTableViewCell
        cell.aksLabel?.text = UniqueKits().getAksLabelText(state: pickerRow, row: indexPath.row).detail
        cell.aksSwitch.isOn = UniqueKits().getAksLabelText(state: pickerRow, row: indexPath.row).onOff
        // Send switch state and indexpath ro to this func?
        cell.aksSwitch.tag = indexPath.row
        cell.aksSwitch.restorationIdentifier = UniqueKits().getAksLabelText(state: pickerRow, row: indexPath.row).detail
        cell.aksSwitch.addTarget(self, action: #selector(switchTriggered(sender:)), for: UIControlEvents.valueChanged)
        cell.aksLabel.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    /// logic to modify swich positions in realm
    func switchTriggered(sender: UISwitch) {
        
        let index = sender.tag
        let content = sender.restorationIdentifier!
        
        if pickerRow == 5 {  // if aks
            
            var todoList: Results<AksItem> {
                get {
                    return realm.objects(AksItem.self)
                }
            }
            
            try! realm.write {
                todoList[index].status = sender.isOn
            }
        }
        
        if pickerRow == 7 {  // if FilterItem
            
            var todoList: Results<FilterItem> {
                get {
                    return realm.objects(FilterItem.self)
                }
            }
            
            try! realm.write {
                todoList[index].status = sender.isOn
            }
        }
        
        if pickerRow == 8 {  // if SupportItem
            
            var todoList: Results<SupportItem> {
                get {
                    return realm.objects(SupportItem.self)
                }
            }
            
            try! realm.write {
                todoList[index].status = sender.isOn
            }
        }
    }
 
    // modify realm object called @objc @objc by picker state
    func updateRealm(state: Int, item: String, onOff: Bool)  {
        
        if state == 5 { // if aks
            let todoItem = AksItem()
            todoItem.detail = item
            todoItem.status = onOff
            
            try! realm.write({
                realm.add(todoItem)
                self.tableView.insertRows(at: [IndexPath.init(row: UniqueKits().getAksLabelText(state: self.pickerRow, row: 0).count-1, section: 0)], with: .automatic)
            })
        }
        
        if state == 7 { // if FilterItem
            let todoItem = FilterItem()
            todoItem.detail = item
            todoItem.status = onOff
            
            try! realm.write({
                realm.add(todoItem)
                self.tableView.insertRows(at: [IndexPath.init(row: UniqueKits().getAksLabelText(state: self.pickerRow, row: 0).count-1, section: 0)], with: .automatic)
            })
        }
        
        if state == 8 { // if SupportItem
            let todoItem = SupportItem()
            todoItem.detail = item
            todoItem.status = onOff
            
            try! realm.write({
                realm.add(todoItem)
                self.tableView.insertRows(at: [IndexPath.init(row: UniqueKits().getAksLabelText(state: self.pickerRow, row: 0).count-1, section: 0)], with: .automatic)
            })
        }
    }
    
    // modify view info by picker state
    func setUpUI() {
        // 5 aks
        if pickerEquipment.pickerState[1] == 5 {
            titleDescription.text = "Switch on AKS items needed"
            title = "Accessories"
        }
        // 7 filters
        if pickerEquipment.pickerState[1] == 7 {
            titleDescription.text = "Switch on filters needed"
            title = "Filters"
        }
        // 8 support
        if pickerEquipment.pickerState[1] == 8 {
            titleDescription.text = "Switch on support needed"
            title = "Support"
        }
    }
}
