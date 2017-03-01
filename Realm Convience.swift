//
//  Realm Convience.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 3/1/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelp {
 
    let realm = try! Realm()
    
    func saveLastID(ID: String) {
        
        var newID = false
        let id: EventTracking
        if let existingID = realm.objects(EventTracking.self).first {
            id = existingID
        } else {
            newID = true
            id = EventTracking()
        }
        
        try! realm.write {
            if newID {
                realm.add(id)
            }
            id.lastID = ID
        }
    }
    
    func getLastEvent() -> EventUserRealm {
        
        let allIds = realm.objects(EventTracking.self)
        let allIdCount = allIds.count
        var index = allIdCount - 1
        if index < 0 { index = 0 }  // catch edited events causing index -1
        let id = realm.objects(EventTracking.self)[index].lastID
        let currentEvent = realm.objects(EventUserRealm.self).filter("taskID == %@", id).first!
        return currentEvent
    }
    
    /// sort latest realm tableview event by catagory
    func sortRealmEvent() {
        
        let thisEvent = getLastEvent()
        
        let storageArea = thisEvent.tableViewArray
        
        let sorted = Array(storageArea.sorted(byKeyPath: "catagory"))
        
        try? realm.write {
            let sortedEvent = getLastEvent()
            sortedEvent.tableViewArray.removeAll()
            
            for items in sorted {
                sortedEvent.tableViewArray.append(items)
            }
            //  print("\nSorted Event:\n\(sortedEvent)\n")
        }
        //  print("\nOriginal Event:\n\(thisEvent)\n")
    }
    
    func getLastIdUsed() -> String {

        let id = realm.objects(EventTracking.self)
        
        var lastIDvalue = String()
        if id.count > 0 {
            let thelastID = id.last
            lastIDvalue = (thelastID?.lastID)!
        } else {
            lastIDvalue = "\(id)"
        }
        return lastIDvalue
    }
}


