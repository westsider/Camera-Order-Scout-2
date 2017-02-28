//
//  TableView Switches.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/28/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation

//MARK:- tableview switches
class TableViewSwitches {
    
    var original = [String]()
    var edited =  [String]()
    var returnedString = String()
    
    func populateArrays(array: [String], reversed: Bool) {
        // if this is a lens kit
        original = array
        edited = original
        // else if switchon = false this is aks, filters, support
        if reversed == false {
            var editedReverse = [String]()
            let i = edited.count
            var counter = 0
            
            while counter < i {
                counter += 1
                editedReverse.append("#")
            }
            print("edited    \(edited.count)")
            print("editedRev \(editedReverse.count)")
            edited = editedReverse
        }
        
    }
    
    /// edit lens list using tableview switches
    func updateArray(index: Int, switchPos: Bool ) {
        
        if index < edited.count {
            
            if switchPos == false {
                edited[index] = "#"
            } else {
                edited[index] = original[index]
            }
            
        } else {
            print("⚡️the index \(index) does not exist you big 🤓")
        }
    }
    
    /// return edited lens string back to pass into main tableview array
    func finalizeLensArray() {   
        var hasHash = true
        while hasHash {
            if let index = edited.index(of: "#") {
                hasHash = true
                edited.remove(at: index)
            } else {
                hasHash = false
            }
        }
        returnedString = edited.joined(separator: ", ")
    }
}
