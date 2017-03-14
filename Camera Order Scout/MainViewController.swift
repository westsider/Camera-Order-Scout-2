//
//  MainViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 11/30/16.
//  Copyright © 2017 Warren Hansen. All rights reserved.

//  task: add panaviaion primos
//  task: add panaviaion anamporphic
//  task: add special lens section
//  fix: Erlich Backman Fix
//  task: added sony, actioCam
//  task: updated items from camtec
//  task: updated asc magazne
//  fix: perspective catagory
//  fix: move portrait and flare to reg pana + Perspective
//  task: monitors
//  task: lamda
//  task: lens baby
//  task: added media cards + drives
//  task:  added pana macros pana zooms
//  fix: no city on weather share
//  fix: Frazie Frazier
//  fix: remove specilty from title
//  task: center logo
//  task: change color scheme
//  task: send html to mail
//  fix: get weather auto saves
//  fix: invalid re declaration of primeLensTableViewCell

//  fix: Could not load the "" image referenced from a nib in the bundle with identifier "TradeStrat.Camera-Order-Scout"
//  task: update how to

//  task: beta testers
//  task: I think being able to generate an email and a PDF would be useful
//  task: pana large format

import Foundation
import UIKit
import RealmSwift

class MainTableViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var image = [UIImage]()
    
    let cellIdentifier = "ListTableViewCell"
    
    var tableViewArrays = TableViewArrays()
    
    var pickerEquipment = Equipment()
    
    let realm = try! Realm()
    
    var tableviewEvent = EventUserRealm()
    
    let coolGray = UIColor(red: 97/255, green: 108/255, blue: 122/255, alpha: 1.0)
    
    let ltGray = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
    
    //MARK: - Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        fillDefaultTableView()
        myTableView.reloadData()
       
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "C A M E R A  O R D E R"
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
        myTableView.reloadData()
        updatePickerSelection()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = coolGray
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : ltGray]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    //MARK: - Add Action  5 is now special optics
    @IBAction func addAction(_ sender: Any) {
        
        //  camera, zoom or finder just add
        if pickerEquipment.pickerState[1] == 0 ||  pickerEquipment.pickerState[1] == 4 || pickerEquipment.pickerState[1] == 7  {
            //  create tableview row realm objects
            let newRow = TableViewRow()
            newRow.icon = pickerEquipment.pickerSelection[1];
            newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1];
            newRow.detail = pickerEquipment.pickerSelection[2] + " " +  pickerEquipment.pickerSelection[3];
            newRow.catagory = pickerEquipment.pickerState[1] // added for sort
            
            let currentEvent = RealmHelp().getLastEvent()   //
            
            try! realm.write {
                currentEvent.tableViewArray.append(newRow)
            }
            RealmHelp().sortRealmEvent()
            myTableView.reloadData()
        }
        
        // if specialty
        if pickerEquipment.pickerState[1] == 5 {
            //  create tableview row realm objects
            let newRow = TableViewRow()
            newRow.icon = pickerEquipment.pickerSelection[1];
            newRow.title = pickerEquipment.pickerSelection[0] + " Special Optics";
            newRow.detail = pickerEquipment.pickerSelection[2] + " " +  pickerEquipment.pickerSelection[3];
            newRow.catagory = pickerEquipment.pickerState[1] // added for sort
            
            let currentEvent = RealmHelp().getLastEvent()   //
            
            try! realm.write {
                currentEvent.tableViewArray.append(newRow)
            }
            RealmHelp().sortRealmEvent()
            myTableView.reloadData()
        }

        // if a prime segue to primes using picker equipment objects
        if pickerEquipment.pickerState[1] > 0 && pickerEquipment.pickerState[1] <= 3  {
            tableViewArrays.setPrimesKit(compState: pickerEquipment.pickerState) // populate var for the next controller
            let myVc = storyboard?.instantiateViewController(withIdentifier: "lensViewController") as! LensesViewController
            myVc.thePrimes = tableViewArrays.thePrimes
            myVc.displayLensArray = tableViewArrays.displayLensArray
            myVc.pickerEquipment = pickerEquipment
            navigationController?.pushViewController(myVc, animated: true)
        }
        
        // segue to aks 6, filters 8 or support 9 using realm objects
        if pickerEquipment.pickerState[1] == 6 || pickerEquipment.pickerState[1] > 7 {
            tableViewArrays.setPrimesKit(compState: pickerEquipment.pickerState) // populate the next controller?
            let myVc = storyboard?.instantiateViewController(withIdentifier: "aksViewController") as! AksKitViewController
            myVc.pickerEquipment = pickerEquipment
            navigationController?.pushViewController(myVc, animated: true)
        }
    }
    
    //MARK: - Share Camera Order
    @IBAction func shareAction(_ sender: Any) {
    
        let myVc = storyboard?.instantiateViewController(withIdentifier: "previewViewController") as! PreviewViewController
        navigationController?.pushViewController(myVc, animated: true)
    }
    
    //MARK: - Set up Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }


    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        let remainingWidth = view.frame.width - 60  // - row one
        
        let bigRow = remainingWidth / 3
        
        if component == 0 {
            return CGFloat(20.0)
        } else {
            return CGFloat(bigRow)
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return   pickerEquipment.pickerArray[component].count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerEquipment.pickerArray[component][row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        dontReloadOnComp0or3(component: component, row: row, lastCatagory: pickerEquipment.prevCatagory)
        reloadComponentsAndText(component: component, row: row)
        zeroThePicker(component: component, row: row)
        // set pickerSelected property with picker array current selection
        pickerEquipment.pickerState = [ myPicker.selectedRow(inComponent: 0), myPicker.selectedRow(inComponent: 1), myPicker.selectedRow(inComponent: 2), myPicker.selectedRow(inComponent: 3) ]
        updatePickerSelection()
    }
    
    //MARK: -  make picker text fill horizontal space allowed
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        //pickerView.backgroundColor = UIColor.darkGray
        pickerLabel.textColor = UIColor.white
        pickerLabel.text = pickerEquipment.pickerArray[component][row]
        pickerLabel.font = UIFont(name: "Helvetica Neue", size: 18)
        pickerLabel.textAlignment = NSTextAlignment.center
        pickerLabel.adjustsFontSizeToFitWidth = true
        return pickerLabel
    }
    
    // MARK: - Picker Convience Functions
    /// reload the text in picker depending on the component switched
    func reloadComponentsAndText(component: Int, row: Int) {
        
        switch component {  // reload only the next picker when prior wheel moves
        case 0:
        break           //  dont reload because quantity changes
        case 1:
            myPicker.reloadComponent(2)
            myPicker.reloadComponent(3)
        case 2:
            myPicker.reloadComponent(3)
        case 3:
        break           //  dont reload becuase only the model changed
        default:
            break
        }
    }
    
    //MARK: -  dont reload localPickerIndex when component 0 or 3 move
    func dontReloadOnComp0or3(component: Int, row: Int, lastCatagory: Int) {
        
        if component == 1 || component == 2 {     //  full update on comp 1 and 2 only
            pickerEquipment.setPickerArray(component: component, row: row, lastCatagory: pickerEquipment.prevCatagory)
        }
    }
    
    //MARK: - zero the picker wheels when Catagory changes
    func zeroThePicker(component: Int, row: Int){
        if component == 1 {  // with new catagory set wheel 2 and 3 safely to index 0
            myPicker.selectRow(0, inComponent: 2, animated: true)
            myPicker.selectRow(0, inComponent: 3, animated: true)
            pickerEquipment.prevCatagory = row    // if wheel 1 moves save the componennt to pass to setPickerArray
        }
    }

    func updatePickerSelection() {
        pickerEquipment.pickerSelection[0] = pickerEquipment.pickerArray[0][pickerEquipment.pickerState[0]]
        pickerEquipment.pickerSelection[1] = pickerEquipment.pickerArray[1][pickerEquipment.pickerState[1]]
        pickerEquipment.pickerSelection[2] = pickerEquipment.pickerArray[2][pickerEquipment.pickerState[2]]
        pickerEquipment.pickerSelection[3] = pickerEquipment.pickerArray[3][pickerEquipment.pickerState[3]]
    }
    
    //MARK: - Set up Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return tableViewArrays.tableViewArray.count
        return tableviewEvent.tableViewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListTableViewCell
        let iconString = tableviewEvent.tableViewArray[indexPath.row].icon
        cell.imageTableViewCell.image = tableViewArrays.setTableViewIcon(title: iconString)
        cell.titleTableView?.text = tableviewEvent.tableViewArray[indexPath.row].title
        cell.detailTableView?.text = tableviewEvent.tableViewArray[indexPath.row].detail
        return cell
    }
    
    //MARK: - delete tableview row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.row != 0 {
            let currentEvent = RealmHelp().getLastEvent()
            
            try! currentEvent.realm!.write {
                let row = currentEvent.tableViewArray[indexPath.row]
                row.realm!.delete(row)
            }
            tableviewEvent = currentEvent   // re - populate tableview
            tableView.reloadData()
        }
    }
    
    //MARK: - Segue to User VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "mainToUser", sender: self)
        }
    }
    
    //MARK: - populate the tableview
    func populateTableviewFromEvent(currentEvent: EventUserRealm ) {
        
        tableViewArrays.removeAll();
            for eachRow in currentEvent.tableViewArray {                
                tableViewArrays.appendTableViewArray(title: eachRow.title, detail: eachRow.detail, compState: pickerEquipment.pickerState)
            }
        myTableView.reloadData()
    }
    
    func fillDefaultTableView() {
        
        //MARK: - on first run populate realm and default user event
        if  UserDefaults.standard.object(forKey: "FirstRun") == nil {
            // check UserDefaults for first run to meet rubrik
            UserDefaults.standard.set(false, forKey: "FirstRun")
            FirstRun().populateRealmKits()
            
            let defaultEventUsers = EventUserRealm()
            defaultEventUsers.eventName = "Empty Project"
            defaultEventUsers.userName = "no user"
            defaultEventUsers.city = "Santa Monica, CA"
            defaultEventUsers.production  = "new production"
            defaultEventUsers.company  = "new company"
            defaultEventUsers.date  = "no date yet"
            
            //  create tableview object
            let rowOne = TableViewRow()
            rowOne.icon = "man" ; rowOne.title = "\(defaultEventUsers.userName) Director of Photography" ; rowOne.detail = "Camera Order \(defaultEventUsers.production) \(defaultEventUsers.date )"
            rowOne.catagory = -1
            defaultEventUsers.tableViewArray.append(rowOne)
            
            try! realm.write {
                realm.add(defaultEventUsers)
            }
            
            RealmHelp().saveLastID(ID: defaultEventUsers.taskID)
            RealmStart().DemoEventsOne()
            RealmStart().DemoEventsTwo()
            RealmStart().DemoEventsThree()

            tableviewEvent = defaultEventUsers
            
            performSegue(withIdentifier: "mainToInfo", sender: self)
            
        } else {
          
            //Mark: - we have a past user and will get last id used
            let currentEvent = RealmHelp().getLastEvent()
            tableviewEvent = currentEvent   // populate tableview
            RealmHelp().sortRealmEvent() //sortRealmEvent()
        }
    }
}
