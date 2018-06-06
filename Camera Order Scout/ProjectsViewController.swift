//
//  PastOrdersViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 12/13/16.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit
import RealmSwift
import QuartzCore

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    @IBOutlet weak var eventNameInput: UITextField!
    
    let realm = try! Realm()
    
    var tasks: Results<EventUserRealm>!
    
    var tableViewTitleArray = [String]()

    //MARK: - Lifecycle Events
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Projects"
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        tasks = realm.objects(EventUserRealm.self)  // for tableview
        //eventNameInput.layer.borderColor = UIColor.white.cgColor
        //eventNameInput.layer.cornerRadius = 8.0
        eventNameInput.layer.masksToBounds = true
        eventNameInput.layer.borderColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        eventNameInput.layer.borderWidth = 1.0
    }
    
    //MARK: - Save Event
    @IBAction func saveEvent(_ sender: Any) {

        // make sure textInput contains a new name
        if eventNameInput.text != "" && eventNameInput.text !=  "Please enter a name for this order" {
            
            if let textInput = eventNameInput.text {
                let newEvntUser = EventUserRealm()
                
                // get the current event to poplate new event tableview
                let currentEvent = RealmHelp().getLastEvent()
                
                // populate tableview equipment from current order
                for oldRow in currentEvent.tableViewArray {
                    let newRow = TableViewRow()
                    newRow.detail = oldRow.detail
                    newRow.title = oldRow.title
                    newRow.icon = oldRow.icon
                    newRow.catagory = oldRow.catagory
                    newEvntUser.tableViewArray.append(newRow)
                }
                // update all details
                newEvntUser.eventName = textInput
                newEvntUser.userName = currentEvent.userName
                newEvntUser.production = currentEvent.production
                newEvntUser.company = currentEvent.company
                newEvntUser.city = currentEvent.city
                newEvntUser.date = currentEvent.date
        
                try! realm.write {
                    realm.add(newEvntUser)
                }
                RealmHelp().saveLastID(ID: newEvntUser.taskID)
                
                _ = navigationController?.popToRootViewController(animated: true)
            }
        } else {
            eventNameInput.text = "Please enter a name for this order"
        }
        
       
      
    }

    //MARK:- Set up Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task =  "\(tasks[indexPath.row].eventName)"
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text =  task
        
        cell.textLabel?.textColor = UIColor.darkGray
        
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // only delete projects if we have more that 1
            if tasks.count > 1 {
                try! tasks.realm!.write {
                    let task = self.tasks[indexPath.row]
                    self.tasks.realm!.delete(task)
                    
                    // if after deleting current project
                    if RealmHelp().getLastIdUsed() == "" {
                        // load first id in list
                        let tasktwo = self.tasks[0]
                        RealmHelp().saveLastID(ID: tasktwo.taskID)
                    }
                }
            }
            
        }
        let allEvents = realm.objects(EventUserRealm.self)
        // get last id in events to save new last id
        let numItems = allEvents.count
        var index = numItems - 1
        if index < 0 {  index = 0   } // catch -1 index if events edited to 1 event
        let thisID = tasks[index].taskID
        RealmHelp().saveLastID(ID: thisID)
        eventsTableView.reloadData()
    }

    //MARK: - Tap on Table View row returns the Event to main tableview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let theRow = indexPath.row
        let id = EventTracking()
        
        try! realm.write {
            id.lastID = tasks[theRow].taskID
            realm.add(id)
        }
        RealmHelp().saveLastID(ID: id.lastID)
        _ = navigationController?.popToRootViewController(animated: true)
        
    }
}
