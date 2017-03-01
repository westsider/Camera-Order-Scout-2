//
//  MainViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 11/30/16.
//  Copyright © 2017 Warren Hansen. All rights reserved.
/*  feat: a new feature
 fix: a bug fix
 docs: changes to documentation
 style: formatting, missing semi colons, etc; no code change
 refactor: refactoring production code
 test: adding tests, refactoring test; no production code change
 chore: updating build tasks, package manager configs, etc; no production code change   */

//  style: remove un needed comments
//  style: rename model aks
//  task: userdefaults used for rubrik
//  task: network fail
//  task: Helvetica for ui
//  task: remove delete from row 0

//  task: new event save = return to main with that event loaded to save confusion
//  task: push up user when keyboard apperas

//  task: write read me - add from xcode
//  task: how-to images
//  task: add images to app walk through

//  later
//  task: add swipe effect to how-to
//  task: add panavision lenses, check ASC magazine for others




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
    
    //MARK: - Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        fillDefaultTableView()
        myTableView.reloadData()
        ///let presntingViewSnap = MainTableViewController.view.snapshot(afterscreenupdates: false)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "C A M E R A  O R D E R"
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
        myTableView.reloadData()
        updatePickerSelection()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }

    //MARK: - Add Action
    @IBAction func addAction(_ sender: Any) {
        
        //  camera, zoom or finder just add
        if pickerEquipment.pickerState[1] == 0 ||  pickerEquipment.pickerState[1] == 4 ||  pickerEquipment.pickerState[1] == 6  {
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

        // if a prime segue to primes using picker equipment objects
        if pickerEquipment.pickerState[1] > 0 && pickerEquipment.pickerState[1] <= 3  {
            tableViewArrays.setPrimesKit(compState: pickerEquipment.pickerState) // populate var for the next controller
            let myVc = storyboard?.instantiateViewController(withIdentifier: "lensViewController") as! LensesViewController
            myVc.thePrimes = tableViewArrays.thePrimes
            myVc.displayLensArray = tableViewArrays.displayLensArray
            myVc.pickerEquipment = pickerEquipment
            navigationController?.pushViewController(myVc, animated: true)
        }
        
        // segue to aks, filters or support using realm objects
        if pickerEquipment.pickerState[1] == 5 || pickerEquipment.pickerState[1] > 6 {
            tableViewArrays.setPrimesKit(compState: pickerEquipment.pickerState) // populate the next controller?
            let myVc = storyboard?.instantiateViewController(withIdentifier: "aksViewController") as! AksKitViewController
            myVc.pickerEquipment = pickerEquipment
            navigationController?.pushViewController(myVc, animated: true)
        }
    }
    
    //MARK: - Share Camera Order
    @IBAction func shareAction(_ sender: Any) {
        
        let thisEvent = RealmHelp().getLastEvent()
        
        var messageArray = [String]()
        
        for rows in thisEvent.tableViewArray {

            let mixedCase = rows.title.uppercased()
            messageArray.append(mixedCase)
            messageArray.append("\n")
            messageArray.append(rows.detail)
            messageArray.append("\n\n")
        }
        messageArray.append("\nWeather forecast for \(thisEvent.city)\n\(thisEvent.weather)")
        messageArray.append("  ")
        // write over user to add company
        messageArray[0] = "\(thisEvent.userName.uppercased()) Director of Photography\n"
        messageArray[1] = "Camera Order “\(thisEvent.production)” \(thisEvent.date) \(thisEvent.company)\n"
        messageArray[2] = ""
        let title = messageArray[1]
        let content = messageArray.joined(separator: "")
        let objectsToShare = [content]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.setValue(title, forKey: "Subject")
        self.present(activityVC, animated: true, completion: nil)
    }
    
    //MARK: - Set up Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
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
        pickerLabel.textColor = UIColor.black
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
            defaultEventUsers.eventName = "first event"
            defaultEventUsers.userName = "first user"
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
            
            //saveLastID(ID: defaultEventUsers.taskID)
            RealmHelp().saveLastID(ID: defaultEventUsers.taskID)
            
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
