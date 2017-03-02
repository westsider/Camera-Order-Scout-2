//
//  firstRunProjects.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 3/2/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class RealmStart {
    
    let realm = try! Realm()
    
    let defaultEventUsers = EventUserRealm()
    
    func DemoEventsOne() {
 
        defaultEventUsers.eventName = "Blue Bin Commercial"
        defaultEventUsers.userName = "Jin Yang"
        defaultEventUsers.city = "Palo Alta, CA"
        defaultEventUsers.production  = "Silicon Valley"
        defaultEventUsers.company  = "HBO"
        defaultEventUsers.date = "3/30/2017"
        
        try! realm.write {
            realm.add(defaultEventUsers)
        }
        
        //  create tableview object
        let rowOne = TableViewRow()
        // u
        rowOne.icon = "man" ; rowOne.title = "\(defaultEventUsers.userName) Director of Photography" ; rowOne.detail = "Camera Order \(defaultEventUsers.production) \(defaultEventUsers.date )"
        rowOne.catagory = -1
        // c
        let rowTwo = TableViewRow()
        rowTwo.icon = "Camera" ; rowTwo.title = "2 Cameras" ; rowTwo.detail = "Red Epic Dragon"; rowTwo.catagory = 0
        
        let rowThree = TableViewRow()
        rowThree.icon = "Primes" ; rowThree.title = "2 Primes Zeiss Ultra Primes" ; rowThree.detail = "18mm, 25mm, 32mm, 40mm, 50mm, 75mm, 100mm, 150mm"; rowThree.catagory = 1
        
        let rowFour = TableViewRow()
        rowFour.icon = "AKS" ; rowFour.title = "2 AKS" ; rowFour.detail = "5 inch Assistant Monitor, Extra Black Bags"; rowFour.catagory = 5
        
        try! realm.write {
            defaultEventUsers.tableViewArray.append(rowOne)
            defaultEventUsers.tableViewArray.append(rowTwo)
            defaultEventUsers.tableViewArray.append(rowThree)
            defaultEventUsers.tableViewArray.append(rowFour)
        }
    }
    
    func DemoEventsTwo() {
        
        defaultEventUsers.eventName = "Studio Package"
        defaultEventUsers.userName = "Erich Bachman"
        defaultEventUsers.city = "Santa Clara, CA"
        defaultEventUsers.production  = "Silicon Valley"
        defaultEventUsers.company  = "HBO"
        defaultEventUsers.date = "5/1/2017"
        
        try! realm.write {
            realm.add(defaultEventUsers)
        }
        
        //  create tableview object
        let rowOne = TableViewRow()
        // u
        rowOne.icon = "man" ; rowOne.title = "\(defaultEventUsers.userName) Director of Photography" ; rowOne.detail = "Camera Order \(defaultEventUsers.production) \(defaultEventUsers.date )"
        rowOne.catagory = -1
        // c
        let rowTwo = TableViewRow()
        rowTwo.icon = "Camera" ; rowTwo.title = "1 Camera" ; rowTwo.detail = "Panavision Genesis"; rowTwo.catagory = 0
        
        let rowThree = TableViewRow()
        rowThree.icon = "Primes" ; rowThree.title = "1 Primes Master Primes" ; rowThree.detail = "18mm, 25mm, 32mm, 40mm, 50mm, 75mm, 100mm, 150mm"; rowThree.catagory = 1
        
        let rowFour = TableViewRow()
        rowFour.icon = "AKS" ; rowFour.title = "1 AKS" ; rowFour.detail = "5 inch Assistant Monitor, Capresso Potrable"; rowFour.catagory = 5
        
        try! realm.write {
            defaultEventUsers.tableViewArray.append(rowOne)
            defaultEventUsers.tableViewArray.append(rowTwo)
            defaultEventUsers.tableViewArray.append(rowThree)
            defaultEventUsers.tableViewArray.append(rowFour)
        }
    }
    
    func DemoEventsThree() {
        
        defaultEventUsers.eventName = "Location Package"
        defaultEventUsers.userName = "Richard Hendricks"
        defaultEventUsers.city = "San Jose, CA"
        defaultEventUsers.production  = "Silicon Valley"
        defaultEventUsers.company  = "HBO"
        defaultEventUsers.date = "11/15/2017"
        
        try! realm.write {
            realm.add(defaultEventUsers)
        }
        
        //  create tableview object
        let rowOne = TableViewRow()
        // u
        rowOne.icon = "man" ; rowOne.title = "\(defaultEventUsers.userName) Director of Photography" ; rowOne.detail = "Camera Order \(defaultEventUsers.production) \(defaultEventUsers.date )"
        rowOne.catagory = -1
        // c
        let rowTwo = TableViewRow()
        rowTwo.icon = "Camera" ; rowTwo.title = "1 Camera" ; rowTwo.detail = "Arri Alexa"; rowTwo.catagory = 0
        
        let rowThree = TableViewRow()
        rowThree.icon = "Primes" ; rowThree.title = "1 Primes Camtec Ultra Primes" ; rowThree.detail = "16mm, 24mm, 32mm, 40mm, 50mm, 85mm, 100mm, 150mm"; rowThree.catagory = 1
        
        let rowFour = TableViewRow()
        rowFour.icon = "AKS" ; rowFour.title = "1 AKS" ; rowFour.detail = "7 inch Assistant Monitor, Vim vs.Emacs notes"; rowFour.catagory = 5
        
        try! realm.write {
            defaultEventUsers.tableViewArray.append(rowOne)
            defaultEventUsers.tableViewArray.append(rowTwo)
            defaultEventUsers.tableViewArray.append(rowThree)
            defaultEventUsers.tableViewArray.append(rowFour)
        }
        RealmHelp().saveLastID(ID: defaultEventUsers.taskID)
    }
}
