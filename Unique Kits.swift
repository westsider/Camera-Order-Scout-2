//
//  Unique Kits.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/25/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class AksItem: Object {
    @objc dynamic var detail = ""
    @objc dynamic var status = false
}

class FilterItem: Object {
    @objc dynamic var detail = ""
    @objc dynamic var status = false
}

class SupportItem: Object {
    @objc dynamic var detail = ""
    @objc dynamic var status = false
}


class FirstRun { // aks filters support
    
    let realm = try! Realm()
    
    func populateRealmKits() {
        
        // load stock aks items
        let tableviewArrays = TableViewArrays()
        
        tableviewArrays.setPrimesKit(compState: [0,6,0,0])
        
        for  item in tableviewArrays.thePrimes {
            
            let aksItem = AksItem()
            aksItem.detail = item
            aksItem.status = false
            
            try! self.realm.write({
                self.realm.add(aksItem)
            })
        }
        
        // load stock filters
        tableviewArrays.setPrimesKit(compState: [0,8,0,0])
        
        for  item in tableviewArrays.thePrimes {
            
            let filterItem = FilterItem()
            filterItem.detail = item
            filterItem.status = false
            
            try! self.realm.write({
                self.realm.add(filterItem)
            })
        }
        
        // load stock support
        tableviewArrays.setPrimesKit(compState: [0,9,0,0])
        
        for  item in tableviewArrays.thePrimes {
            
            let supportItem = SupportItem()
            supportItem.detail = item
            supportItem.status = false
            
            try! self.realm.write({
                self.realm.add(supportItem)
            })
        }
    }
}

/// return an edited kit string to aks vc
class UniqueKits {
    
    let realm = try! Realm()
    
    func finalizeKitArray(pickerRow: Int)-> String {   // in segue back to main VC
        
        var returnedString = String()
        
        if pickerRow == 6 {  // if aks
            
            var todoList: Results<AksItem> {
                get {
                    return realm.objects(AksItem.self)
                }
            }
            for items in todoList {
                
                if items.status == true {
                    returnedString += items.detail + ", "
                }
            }
        }
        
        if pickerRow == 8 {  // if FilterItem
            
            var todoList: Results<FilterItem> {
                get {
                    return realm.objects(FilterItem.self)
                }
            }
            for items in todoList {
                if items.status == true {
                    returnedString += items.detail + ", "
                }
            }
        }
        
        if pickerRow == 9 {  // if SupportItem
            
            var todoList: Results<SupportItem> {
                get {
                    return realm.objects(SupportItem.self)
                }
            }
            for items in todoList {
                if items.status == true {
                    returnedString += items.detail + ", "
                }
            }
        }
        // if list isnt empty remove last comma
        if returnedString != "" {
            let endIndex = returnedString.index(returnedString.endIndex, offsetBy: -2)
            //  This line was changed for swift 4
            //let truncated = returnedString.substring(to: endIndex)
            let truncated = returnedString[..<endIndex]
            returnedString = String(truncated)
        }
        
        return returnedString
    }
    
    // modify realm object called by picker state
    func getAksLabelText(state: Int, row: Int) -> (detail: String, onOff: Bool, count: Int) {
        var labelString = ""
        var size = 1
        var isSwitchOn = false
        
        if state == 6 { // if aks
            
            var todoList: Results<AksItem> {
                get {
                    return realm.objects(AksItem.self)
                }
            }
            
            size = todoList.count
            labelString =  todoList[row].detail
            isSwitchOn = todoList[row].status
        }
        
        if state == 8 { // if FilterItem
            
            var todoList: Results<FilterItem> {
                get {
                    return realm.objects(FilterItem.self)
                }
            }
            
            size = todoList.count
            labelString =  todoList[row].detail
            isSwitchOn = todoList[row].status
        }
        
        if state == 9 { // if SupportItem
            
            var todoList: Results<SupportItem> {
                get {
                    return realm.objects(SupportItem.self)
                }
            }
            
            size = todoList.count
            labelString =  todoList[row].detail
            isSwitchOn = todoList[row].status
        }
        
        return (labelString, isSwitchOn, size)
    }
    
    /// logic to modify swich positions in realm but selector not exposed to objective c
    func switchTriggered(sender: UISwitch, pickerRow: Int) {
        
        let index = sender.tag
        let content = sender.restorationIdentifier!
        
        if pickerRow == 6 {  // if aks
            
            var todoList: Results<AksItem> {
                get {
                    return realm.objects(AksItem.self)
                }
            }
            
            try! realm.write {
                todoList[index].status = sender.isOn
            }
        }
        
        if pickerRow == 8 {  // if FilterItem
            
            var todoList: Results<FilterItem> {
                get {
                    return realm.objects(FilterItem.self)
                }
            }
            
            try! realm.write {
                todoList[index].status = sender.isOn
            }
        }
        
        if pickerRow == 9 {  // if SupportItem
            
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

}
