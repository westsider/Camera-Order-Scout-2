//
//  TableViewArrayRealm.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/11/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift

// class to add tableview rows to each event
class TableViewRow: Object {
    @objc dynamic var icon = ""
    @objc dynamic var title = ""
    @objc dynamic var detail =  ""
    @objc dynamic var catagory = 0
    
    override var description: String { return "TableViewRow {\(icon), \(title), \(detail)}" }
}

//  class to track past events
class EventTracking: Object {
    @objc dynamic var lastID = ""
}
