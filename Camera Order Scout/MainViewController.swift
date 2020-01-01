//
//  MainViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 11/30/16.
//  12/1/19 1.7 ios 13, dark sky weather
//  Copyright © 2017 Warren Hansen. All rights reserved.

//  [X] crashalitics
//  [ ] add new cameras
//  [ ] add new lenses
//  [ ] main screen editable
//  [ ] make lenses custom

import Foundation
import UIKit
import RealmSwift
import Crashlytics

class MainTableViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var image = [UIImage]()
    
    let cellIdentifier = "ListTableViewCell"
    
    var tableViewArrays = TableViewArrays()
    
    var pickerEquipment = Equipment()
    
    let realm = try! Realm()
    
    var eventUserRealm = EventUserRealm()
    
    let coolGray = UIColor(red: 97/255, green: 108/255, blue: 122/255, alpha: 1.0)
    
    let ltGray = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
    
    //MARK: - Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        fillDefaultTableView()
        myTableView.reloadData()
        print("here is the tableviewEvent")
        debugPrint(eventUserRealm)
        print("here is the tableViewArray")
        for each in eventUserRealm.tableViewArray {
            debugPrint(each)
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "C A M E R A  O R D E R"
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
        
        myTableView.estimatedRowHeight = 300
        myTableView.rowHeight = UITableView.automaticDimension
        
        myTableView.reloadData()
        updatePickerSelection()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = coolGray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : ltGray]
        navigationController?.navigationBar.tintColor = UIColor.white
        overrideUserInterfaceStyle = .light
    
    }
    
    //MARK: - Add Action  5 is now special optics
    @IBAction func addAction(_ sender: Any) {
        
        // custom cameras vc
         if pickerEquipment.pickerState[1] == 0 &&  pickerEquipment.pickerState[2] == 8   {
            
            let myVc = storyboard?.instantiateViewController(withIdentifier: "camerasViewController") as! CamerasViewController
            myVc.icon = pickerEquipment.pickerSelection[1];
            myVc.titles = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1];
            myVc.catagory = pickerEquipment.pickerState[1]
            navigationController?.pushViewController(myVc, animated: true)
        }
        
        //  camera, zoom or finder just add
        if pickerEquipment.pickerState[1] == 0 &&  pickerEquipment.pickerState[2] < 8 ||  pickerEquipment.pickerState[1] == 4 || pickerEquipment.pickerState[1] == 7  {
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
//MARK: - Todo - annimate adding row
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
        segueToPrimes(forEditing: false, row: 0)
        
        // segue to aks 6, filters 8 or support 9 using realm objects
        if pickerEquipment.pickerState[1] == 6 || pickerEquipment.pickerState[1] > 7 {
            print("5 fired")
            tableViewArrays.setPrimesKit(compState: pickerEquipment.pickerState) // populate the next controller?
            let myVc = storyboard?.instantiateViewController(withIdentifier: "aksViewController") as! AksKitViewController
            myVc.pickerEquipment = pickerEquipment
            navigationController?.pushViewController(myVc, animated: true)
        }
    }
    
    //MARK: - Share Camera Order
    @IBAction func shareAction(_ sender: Any) {
        //Crashlytics.sharedInstance().crash()
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
            eventUserRealm = defaultEventUsers
            performSegue(withIdentifier: "mainToInfo", sender: self)
            
        } else {
          
            //Mark: - we have a past user and will get last id used
            let currentEvent = RealmHelp().getLastEvent()
            eventUserRealm = currentEvent   // populate tableview
            RealmHelp().sortRealmEvent() //sortRealmEvent()
        }
    }
    
    func segueToPrimes(forEditing: Bool, row: Int) {
        if pickerEquipment.pickerState[1] > 0 && pickerEquipment.pickerState[1] <= 3  {
            
            tableViewArrays.setPrimesKit(compState: pickerEquipment.pickerState) // populate var for the next controller
            let lensVC = storyboard?.instantiateViewController(withIdentifier: "lensViewController") as! LensesViewController
            lensVC.eventUserRealm = eventUserRealm
            lensVC.editingLenses = forEditing
            lensVC.thePrimes = tableViewArrays.thePrimes
            lensVC.displayLensArray = tableViewArrays.displayLensArray
            lensVC.pickerEquipment = pickerEquipment
            lensVC.rowPassedIn = row
            navigationController?.pushViewController(lensVC, animated: true)
        }
    }
}


//MARK: - Set up tableview
extension MainTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventUserRealm.tableViewArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListTableViewCell
        let iconString = eventUserRealm.tableViewArray[indexPath.row].icon
        cell.imageTableViewCell.image = tableViewArrays.setTableViewIcon(title: iconString)
        cell.titleTableView?.text = eventUserRealm.tableViewArray[indexPath.row].title
        cell.detailTableView?.text = eventUserRealm.tableViewArray[indexPath.row].detail
        return cell
    }
}

extension MainTableViewController: UITableViewDelegate {
    //MARK: - Edit Tableview Rows
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "mainToUser", sender: self)
        } else {
            
            //MARK - Todo allow editing of each cell
            let currentEvent = RealmHelp().getLastEvent()
//            print(indexPath.row)
//            print("catagory: \(currentEvent.tableViewArray[indexPath.row].description)")
//            print("detail: \(currentEvent.tableViewArray[indexPath.row].detail)")
//            print("icon: \(currentEvent.tableViewArray[indexPath.row].icon)")
//            print("title: \(currentEvent.tableViewArray[indexPath.row].title)")
            // parse the icon, for compomnet 1
            let icon = currentEvent.tableViewArray[indexPath.row].icon
            //print("Seeking icon as \(icon)")
            let catagory = EditTableview.findCatagoryFrom(input: icon)
            //print("\(catagory)")
            // slew the picker
            myPicker.selectRow(catagory, inComponent: 1, animated: true)
        }
    }
    
    //MARK: - delete / edit tableview row
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
     
        let currentEvent = RealmHelp().getLastEvent()
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            print("index path of delete: \(indexPath)")
            try! currentEvent.realm!.write {
                let row = currentEvent.tableViewArray[indexPath.row]
                row.realm!.delete(row)
            }
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            completionHandler(true)
        }

        let rename = UIContextualAction(style: .normal, title: "Edit") { (action, sourceView, completionHandler) in
            // get row num for primes then segue to pick primes

            
        
             // if a prime segue to primes using picker equipment objects
            self.segueToPrimes(forEditing: true, row: indexPath.row)
            
            completionHandler(true)
        }
        rename.backgroundColor = .blue
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [rename, delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
}
