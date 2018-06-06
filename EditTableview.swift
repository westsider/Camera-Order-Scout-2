//
//  EditTableview.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 6/5/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import Foundation

class EditTableview {
    
    class func findCatagoryFrom(input:String) -> Int{
        
        var answer = 0
        
        switch input {
        case "Camera":
            answer = 0
        case "Primes":
            answer = 1
        case "Macros":
            answer = 2
        case "Probe Lens":
            answer = 3
        case "Zoom Lens":
            answer = 4
        case "Specialty":
            answer = 5
        case "AKS":
            answer = 6
        case "Finder":
            answer = 7
        case "Filters":
            answer = 8
        case "Support":
            answer = 9
        default:
            answer = 0
        }
        return  answer
    }
}
