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
    
    var switchOn = true
    
    var tableViewSwitches = TableViewSwitches()
    
    var pickerEquipment = Equipment()
    
    let cellIdentifier = "primeLensTableViewCell"
    
    var originalArray = [String]()
    
    var thePrimes = [String]()
    
    var displayLensArray = [String]()
    
    var switchPos = [Bool]()
    
    let realm = try! Realm()
    
    var eventUserRealm = EventUserRealm()
    
    var editingLenses = false
    
    var rowPassedIn = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if editingLenses {
//            print("We are editing a lens package")
//            // find which lenns was selected
//            print("here is picker selection \(pickerEquipment.pickerSelection) ")
//            originalArray = thePrimes
//            // populate array and switches
//        } else {
            print("we are adding new lenses")
            originalArray = thePrimes
            print("Here is a list of primes passes in")
            debugPrint(originalArray)
            setUpUI()
            tableViewSwitches.populateArrays(array: originalArray, reversed: switchOn)
//            print("here is picker state \(pickerEquipment.pickerState)")
//            pickerEquipment.setPickerArray(component: pickerEquipment.pickerState[1],
//                                           row: pickerEquipment.pickerState[2],
//                                           lastCatagory: pickerEquipment.pickerState[3])
//            print("here is picker array \(pickerEquipment.pickerArray) ")
            
        //}
        
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
        
        let currentEvent = RealmHelp().getLastEvent()
        
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
        cell.lensSwitch.restorationIdentifier = displayLensArray[indexPath.row]
        cell.lensSwitch.addTarget(self, action: #selector(switchTriggered(sender:)), for: UIControl.Event.valueChanged)
        cell.lensLabel.adjustsFontSizeToFitWidth = true
//cell.lensSwitch.isOn = switchPos[indexPath.row] //   remember swich position durring scroll
        return cell
    }
    
    /// modify a lens kit from swich positions in the tableView
    @objc func switchTriggered(sender: UISwitch) {

        let index = sender.tag
        tableViewSwitches.updateArray(index: index, switchPos: sender.isOn)
        switchPos[sender.tag] = sender.isOn
    }
    
    func setUpUI() {
        // 1 primes
        if pickerEquipment.pickerState[1] <= 3 {
            title = "Select Lenses"
            titleDescription.text = "Switch off lenses not needed"
        }
        
        if editingLenses {
            // find which lenns was selected
            print("here is picker selection \(pickerEquipment.pickerSelection) ")
            //get switch positions from realm
            print("here is event")
            debugPrint(eventUserRealm)
            
            print("here is the row \(rowPassedIn)")
            // match tableview row to tableViewArray[row] to get lenses!!!
            let lenses = eventUserRealm.tableViewArray[rowPassedIn]
            print("Cat: \(lenses.catagory) desc: \(lenses.description) detail: \(lenses.detail) icon: \(lenses.icon) title: \(lenses.title)")
            displayLensArray = DecoupleString().fudgesicle(thisString: lenses.detail)
            debugPrint(displayLensArray)
            
            // get orig prime set
//TableViewArrays().setPrimesKit(compState: <#T##[Int]#>)
            // compare to find off switches
            
        } else {
            // array to persiste switch positions durring deque of cells
            let i = displayLensArray.count
            var c = 0
            while c < i {
                switchPos.append(switchOn) // set switch pos from prior vc - off for aks
                c += 1
            }
        }
    }
}

class DecoupleString {
    func fudgesicle(thisString:String)-> [String] {
        return thisString.components(separatedBy: ",")
    }
}
