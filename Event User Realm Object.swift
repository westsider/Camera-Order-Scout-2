//
//  Event User Realm Object.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/16/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift

// class to hold each event, user and tableview list of equipment
class EventUserRealm: Object {
    
    @objc dynamic var eventName = "Default"
    @objc dynamic var taskID = NSUUID().uuidString    
    @objc dynamic var userName = "Default"
    @objc dynamic var production = ""
    @objc dynamic var company = ""
    @objc dynamic var city = ""
    @objc dynamic var date = ""
    @objc dynamic var weather = ""
    
    var tableViewArray = List<TableViewRow>()
}

