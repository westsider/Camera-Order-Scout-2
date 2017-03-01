//
//  LensesViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/5/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit
import RealmSwift

class LensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var lensTableView: UITableView!
    
    @IBOutlet weak var titleDescription: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    var switchOn = true
    
    var tableViewSwitches = TableViewSwitches()
    
    var pickerEquipment = Equipment()
    
    let cellIdentifier = "primeLensTableViewCell"
    
    var originalArray = [String]()
    
    var thePrimes = [String]()
    
    var displayLensArray = [String]()
    
    var switchPos = [Bool]()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        originalArray = thePrimes
        setUpUI()
        tableViewSwitches.populateArrays(array: originalArray, reversed: switchOn)
    }
    
    //MARK: - add items not in list
    @IBAction func addItemsAction(_ sender: Any) { }
    
    //MARK: - Update the lens kit and return to main VC
    @IBAction func updateAction(_ sender: Any) {
        
        tableViewSwitches.finalizeLensArray()
        
        let newLensKit = tableViewSwitches.returnedString
    
        let newRow = TableViewRow()
        newRow.icon = pickerEquipment.pickerSelection[1]
        if pickerEquipment.pickerState[1] < 5 {
            //  populate lenses
            newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1]  + " " + pickerEquipment.pickerSelection[2] + " " +  pickerEquipment.pickerSelection[3]
            newRow.detail = newLensKit
            newRow.catagory = pickerEquipment.pickerState[1]
        }
        
        //let id = getLastIdUsed()
        
        let currentEvent = RealmHelp().getLastEvent() //realm.objects(EventUserRealm.self).filter("taskID == %@", id).first!
        
        try! realm.write {
            currentEvent.tableViewArray.append(newRow)
        }
        RealmHelp().sortRealmEvent()    //sortRealmEvent()
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Set up tableview  lensesToMain
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayLensArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! primeLensTableViewCell
        
        cell.lensLabel?.text =   displayLensArray[indexPath.row]
        cell.lensSwitch.tag = indexPath.row
        cell.lensSwitch.restorationIdentifier = displayLensArray[indexPath.row] // lensKitArray[indexPath.row]
        cell.lensSwitch.addTarget(self, action: #selector(switchTriggered(sender:)), for: UIControlEvents.valueChanged)
        cell.lensLabel.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    /// modify a lens kit from swich positions in the tableView
    func switchTriggered(sender: UISwitch) {

        let index = sender.tag
        let content = sender.restorationIdentifier!
        print("Lens Switch Index: \(index) For: \(content) Is On: \(sender.isOn)")
        tableViewSwitches.updateArray(index: index, switchPos: sender.isOn)
        switchPos[sender.tag] = sender.isOn
    }
    
    func setUpUI() {
        
        // 1 primes
        if pickerEquipment.pickerState[1] == 1 {
            print("sent form primes")
            title = "Select Primes"
            titleDescription.text = "Switch off lenses not needed"
            addButton.isHidden = true
        }
        
        // 5 aks
        if pickerEquipment.pickerState[1] == 5 {
            print("sent form AKS")
            title = "Select AKS"
            titleDescription.text = "Switch On items needed"
            switchOn = false

            let realm = try! Realm()
            
            var todoList: Results<AksItem> {
                get {
                    return realm.objects(AksItem.self)
                }
            }
        }
        
        // 7 filters
        if pickerEquipment.pickerState[1] == 7 {
            print("sent form Filters")
            title = "Select Filters"
            titleDescription.text = "Switch On filters needed"
            switchOn = false
            
            let realm = try! Realm()
            
            var todoList: Results<FilterItem> {
                get {
                    return realm.objects(FilterItem.self)
                }
            }
        }
        
        // 8 support
        if pickerEquipment.pickerState[1] == 8 {
            print("sent form Support")
            title = "Select Support"
            titleDescription.text = "Switch On items needed"
            switchOn = false
            
            let realm = try! Realm()
            
            var todoList: Results<SupportItem> {
                get {
                    return realm.objects(SupportItem.self)
                }
            }
        }
    }
}
