//
//  CustomCamera.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 6/4/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import UIKit
import RealmSwift

class CustomCamera: Object {
    
    @objc dynamic var maker   = ""
    @objc dynamic var type    = ""
    @objc dynamic var taskID  = ""
    
    func saveCameraToRealm(type: String, maker: String) {
        let realm = try! Realm()
        let customCamera = CustomCamera()
        customCamera.maker = maker
        customCamera.type = type
        customCamera.taskID = NSUUID().uuidString

        try! realm.write({
            realm.add(customCamera)
        })
    }
    
    func sortCamerasForPicker()-> Results<CustomCamera> {
        let realm = try! Realm()
        let allEntries = realm.objects(CustomCamera.self)
        let sortDate = allEntries.sorted(byKeyPath: "maker", ascending: false)
        return sortDate
    }
}
