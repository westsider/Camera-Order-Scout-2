//
//  TableView Array Class.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/5/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import UIKit

/// construct a 2D array to populate main equipment Tableview. Populate and edit Lenses tableView in Lens VC
class TableViewArrays {
    
    var tableViewArray = [[Any]]()  // populates the Main Tableview
    
    var originalArray = [String]()
    
    var editedLensArray = [String]()
    
    var thePrimes = [String]()
    
    var displayLensArray = [String]()
    
    func setTableViewIcon(title: String )-> UIImage {
        
        let image = UIImage(named: "manIcon")!
        
        let catagory = title
        
        if catagory.range(of:"Camera") != nil {
            return UIImage(named: "cameraIcon")!
        }
        
        if catagory.range(of:"Primes") != nil {
            return UIImage(named: "lensIcon")!
        }
        
        if catagory.range(of:"Macros") != nil {
            return UIImage(named: "lensIcon")!
        }
        
        if catagory.range(of:"Probe Lens") != nil {
            return UIImage(named: "lensIcon")!
        }
        
        if catagory.range(of:"Zoom Lens") != nil {
            return UIImage(named: "lensIcon")!
        }
        
        if catagory.range(of:"Specialty") != nil {
            return UIImage(named: "lensIcon")!
        }
        
        if catagory.range(of:"AKS") != nil {
            return UIImage(named: "gearIcon")!
        }
        
        if catagory.range(of:"Finder") != nil {
            return UIImage(named: "finder")!
        }
        
        if catagory.range(of:"Filters") != nil {
            return UIImage(named: "gearIcon")!
        }
        
        if catagory.range(of:"Support") != nil {
            return UIImage(named: "support")!
        }
        if catagory.range(of:"Weather") != nil {
            return UIImage(named: "weather")!
        }
        return image
    }
    
    /// add picker selection to tableview array
    func appendTableViewArray(title: String, detail: String, compState: [Int] ) {   // when Adding to tableview in main VC
        
        var newRow = [Any]()
        newRow.append(title)
        newRow.append(detail)
        newRow.append(setTableViewIcon(title: title))
        tableViewArray.append(newRow)
    }
    
    func removeAll() {
        tableViewArray.removeAll()
    }
    
    /// populate tableview in Lens VC
    func lensTableView() {
        
        let lastElement = tableViewArray.count - 1              // find last element,
        let lenses = tableViewArray[lastElement][1] as? String  // find lens string in tableview array
        originalArray = (lenses?.components(separatedBy: ","))! // split to array for lens tableview
        editedLensArray = originalArray                         // remember original array
    }
    
    /// send edited lens array back to main tableview array
    func editedLensKitReturendToMainTableView(sendString: String) {
        let lastElement = tableViewArray.count - 1
        tableViewArray[lastElement][1] = sendString
    }
    
    func updateUser(title: String, detail: String) {
        tableViewArray[0][0] = title
        tableViewArray[0][1] = detail
        
    }
    
    
    // picker sends 2 arrays to lens selection, lens selection edits both arrays, array is converted to string for tableview and share
    func setPrimesKit(compState: [Int]) {
        // Zeiss Prime Section
        thePrimes = ["I dont know what this is"]
        // primes "Zeiss" "Master Primes"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 0 {
            
            thePrimes   = ["12mm", "14mm", "16mm", "18mm", "21mm", "25mm", "27mm",
                           "32mm", "35mm","40mm", "50mm", "65mm", "75mm", "100mm", "135mm", "150mm"]
            
            displayLensArray   = ["12mm    T 1.3   ^16in",
                                  "14mm    T 1.3   ^14in",
                                  "16mm    T 1.3   ^14in",
                                  "18mm    T 1.3   ^14in",
                                  "21mm    T 1.3   ^14in",
                                  "25mm    T 1.3   ^14in",
                                  "27mm    T 1.3   ^14in",
                                  "32mm    T 1.3   ^14in",
                                  "35mm    T 1.3   ^14in",
                                  "40mm    T 1.3   ^16in",
                                  "50mm    T 1.3   ^20in",
                                  "65mm    T 1.3   ^2ft 3in",
                                  "75mm    T 1.3   ^2ft 9in",
                                  "100mm   T 1.3   ^3ft 6in",
                                  "135mm   T 1.3   ^3ft 3in",
                                  "150mm   T 1.3   ^4ft 11in"]
        }
        
        // primes "Zeiss" "ultra Primes"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 1 {
            thePrimes   = [ "8mm","10mm","12mm","14mm","16mm","20mm","24mm","28mm","32mm",
                            "40mm","50mm","65mm","85mm","100mm","135mm","180mm"]
            
            displayLensArray   = [ "8mm     T 2.8   ^14in",
                                   "10mm    T 2.1   ^14in",
                                   "12mm    T 2     ^12in",
                                   "14mm    T 1.9   ^9in",
                                   "16mm    T 1.9   ^10in",
                                   "20mm    T 1.9   ^11in",
                                   "24mm    T 1.9   ^12in",
                                   "28mm    T 1.9   ^11in",
                                   "32mm    T 1.9   ^14in",
                                   "40mm    T 1.9   ^15in",
                                   "50mm    T 1.9   ^2ft",
                                   "65mm    T 1.9   ^2ft 3in",
                                   "85mm    T 1.9   ^3ft",
                                   "100mm   T 1.9   ^3ft 3in",
                                   "135mm   T 1.9   ^5ft",
                                   "180mm   T 1.9   ^8ft 6in" ]
        }
        
        // primes "Zeiss" "super speeds"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 2
        {
            thePrimes   = [ "18mm","25mm","35mm","50mm","65mm","85mm"]
            
            displayLensArray = [ "18mm      T 1.3   ^10in",
                                 "25mm      T 1.3   ^10in",
                                 "35mm      T 1.3   ^1ft 2in",
                                 "50mm      T 1.3   ^2ft 6in",
                                 "65mm      T 1.3   ^2ft 4in",
                                 "85mm      T 1.3   ^3ft"]
        }
        
        // primes "Zeiss" "super speeds uncoated"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 3
        {
            thePrimes   = [ "18mm","25mm","35mm","50mm","65mm","85mm"]
            
            displayLensArray = [ "18mm      T 1.3   ^10in",
                                 "25mm      T 1.3   ^10in",
                                 "35mm      T 1.3   ^1ft 2in",
                                 "50mm      T 1.3   ^2ft 6in",
                                 "65mm      T 1.3   ^2ft 4in",
                                 "85mm      T 1.3   ^3ft"]
        }
        
        // primes "Zeiss" "standard speeds"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 4 {
            thePrimes   = [ "10mm","12mm","14mm","16mm","20mm","24mm","28mm","32mm",
                            "40mm","50mm","85mm","100mm","135mm","180mm"]
            
            displayLensArray   = ["10mm    T 2.1   ^14in",
                                  "12mm    T 2.1   ^10in",
                                  "14mm    T 2.1   ^9in",
                                  "16mm    T 2.1   ^5in",
                                  "20mm    T 2.1   ^8in",
                                  "24mm    T 2.1   ^8in",
                                  "28mm    T 2.1   ^11in",
                                  "32mm    T 2.1   ^1ft 4in",
                                  "40mm    T 2.1   ^1ft 4in",
                                  "50mm    T 2.1   ^1ft 4in",
                                  "85mm    T 2.1   ^3ft",
                                  "100mm   T 2.1   ^3ft 4in",
                                  "135mm   T 2.1   ^5ft",
                                  "180mm   T 3     ^5ft"]
        }
        
        // primes "Zeiss" "Compact S2"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 5 {
            thePrimes   = [ "18mm","21mm","25mm","28mm","35mm",
                            "50mm","85mm", "100mm", "135mm"]
            
            displayLensArray = ["15mm    T 2.9   ^12in",
                                "18mm    T 3.6   ^12in",
                                "21mm   T 2.9   ^10in",
                                "25mm   T 2.1   ^10in",
                                "28mm   T 2.1   ^10in",
                                "35mm   T 2.1   ^12in",
                                "50mm   T 2.1   ^18in",
                                "85mm   T 2.1   ^3ft 3in",
                                "100mm  T 2.1   ^2ft 6in",
                                "135mm  T 2.1   ^3ft 3in"]
        }
        
        // primes "Zeiss" "B Speeds"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 6 {
            thePrimes   = [ "18mm","25mm","35mm","50mm","85mm"]
            
            displayLensArray = ["18mm   T 1.4",
                                "25mm   T 1.4",
                                "35mm   T 1.4",
                                "50mm   T 1.4",
                                "85mm   T 1.4"]
        }
        // Leica Prime Section
        // primes "Leica" "Summilux-C"
        if compState[1] == 1 && compState[2] == 1 && compState[3] == 0 {
            thePrimes = [ "16mm", "18mm","21mm","25mm","29mm","35mm",
                          "40mm","50mm","65mm","75mm","100mm","135mm"]
            
            displayLensArray = ["16mm   T 1.4    ^14in",
                                "18mm   T 1.4    ^14in",
                                "21mm  T 1.4    ^12in",
                                "25mm  T 1.4    ^12in",
                                "29mm  T 1.4    ^18in",
                                "35mm  T 1.4    ^14in",
                                "40mm  T 1.4    ^16in",
                                "50mm  T 1.4    ^20in",
                                "65mm  T 1.4    ^18in",
                                "75mm  T 1.4    ^2ft 3in",
                                "100mm T 1.4    ^2ft 11in",
                                "135mm T 1.4    ^4ft 1in"]
        }
        
        // primes "Leica" "Summicron-C"
        if compState[1] == 1 && compState[2] == 1 && compState[3] == 1 {
            thePrimes = [ "15mm", "18mm","21mm","25mm","29mm","35mm",
                          "40mm","50mm","75mm","100mm","135mm"]
            
            displayLensArray  = [ "15mm  T 2.0    ^12in",
                                  "18mm  T 2.0    ^12in",
                                  "21mm  T 2.0    ^12in",
                                  "25mm  T 2.0    ^12in",
                                  "29mm  T 2.0    ^12in",
                                  "35mm  T 2.0    ^14in",
                                  "40mm  T 2.0    ^18in",
                                  "50mm  T 2.0    ^2ft",
                                  "75mm  T 2.0    ^2ft 7in",
                                  "100mm T 2.0    ^3ft 3in",
                                  "135mm T 2.0    ^5ft"]
        }
        
        // primes "Leica" "Telephoto"
        if compState[1] == 1 && compState[2] == 1 && compState[3] == 2 {
            thePrimes = [ "180mm","280mm"]
            
            displayLensArray   = [ "180mm   T 2  ^5",
                                   "280mm   T 2  ^8"]
        }
        
        // Canon Prime Section
        // primes "canon" "K-35"
        if compState[1] == 1 && compState[2] == 2 && compState[3] == 0 {
            thePrimes  = [ "18mm","24mm", "35mm", "55mm","85mm"]
            
            displayLensArray    = [ "18mm   T 1.5   ^12in",
                                    "24mm   T 1.5   ^12in",
                                    "35mm   T 1.5   ^12in",
                                    "55mm   T 1.5   ^2ft",
                                    "85mm   T 1.5   ^3ft"]
        }
        
        // primes "Canon" "Telephoto"
        if compState[1] == 1 && compState[2] == 2 && compState[3] == 1 {
            thePrimes = [ "200mm T2","200 T2.8", "300mm", "400mm"]
            
            displayLensArray = [ "200mm     T2      ^10ft",
                                 "200mm     T2.8    ^4ft 9in",
                                 "300mm     T2.8    ^10ft",
                                 "400mm     T2.8    ^15ft"]
        }
        
        // Cooke Prime Section
        // primes "Cooke" "i5"
        if compState[1] == 1 && compState[2] == 3 && compState[3] == 0 {
            thePrimes = [ "18mm","25mm","32mm","40mm","50mm","65mm","75mm","100mm","135mm"]
            
            displayLensArray  = [ "18mm   T 1.4   ^5in",
                                  "25mm   T 1.4   ^5in",
                                  "32mm   T 1.4   ^5in",
                                  "40mm   T 1.4   ^7in",
                                  "50mm   T 1.4   ^11in",
                                  "65mm   T 1.4   ^15in",
                                  "75mm   T 1.4   ^17in",
                                  "100mm  T 1.4   ^21in",
                                  "135mm  T 1.4   ^21in"]
        }
        
        // primes "Cooke" "S4"
        if compState[1] == 1 && compState[2] == 3 && compState[3] == 1 {
            thePrimes = ["12mm", "14mm", "16mm", "18mm", "21mm", "25mm", "27mm",
                         "32mm", "35mm","40mm", "50mm", "65mm", "75mm", "100mm", "135mm", "150mm", "180mm"]
            
            displayLensArray = ["12mm   T 2   ^9in",
                                "14mm   T 2   ^9in",
                                "16mm   T 2   ^9in",
                                "18mm   T 2   ^9in",
                                "21mm   T 2   ^9in",
                                "25mm   T 2   ^9in",
                                "27mm   T 2   ^10in",
                                "32mm   T 2   ^12in",
                                "35mm   T 2   ^14in",
                                "40mm   T 2   ^16in",
                                "50mm   T 2   ^20in",
                                "65mm   T 2   ^27in",
                                "75mm   T 2   ^30in",
                                "100mm  T 2   ^36in",
                                "135mm  T 2   ^30in",
                                "150mm  T 2   ^42in",
                                "180mm  T 2   ^51in"]
        }
        
        /// primes "Cooke" "Speed Panchro"
        if compState[1] == 1 && compState[2] == 3 && compState[3] == 2 {
            thePrimes = ["18mm", "25mm", "32mm", "40mm", "50mm", "75mm", "100mm Macro", "152mm Macro"]
            
            displayLensArray  = ["18mm  T 2.2   ^7in",
                                 "25mm  T 2.3   ^11in",
                                 "32mm  T 2.3   ^8in",
                                 "40mm  T 2.3   ^9in",
                                 "50mm  T 2.3   ^12in",
                                 "75mm  T 2.3   ^22in",
                                 "100mm Macro  T 2.8   ^3in",
                                 "152mm Macro  T 3.2   ^3in"]
        }
        
        //MARK: - Primo 70
        if compState[1] == 1 && compState[2] == 4 && compState[3] == 0 {
            
            thePrimes   = ["14mm","24mm","27mm","35mm","40mm","50mm", "65mm","80mm","100mm","125mm","150mm","200mm","250mm"]
            
            displayLensArray   = ["14mm     T 2.0   ^8in",
                                  "24mm     T 2.0   ^12in",
                                  "27mm     T 2.0   ^14in",
                                  "35mm     T 2.0   ^14in",
                                  "40mm     T 2.0   ^14in",
                                  "50mm     T 2.0   ^16in",
                                  "65mm     T 2.0   ^20in",
                                  "80mm     T 2.0   ^24in",
                                  "100mm    T 2.0   ^30in",
                                  "125mm    T 2.0   ^36in",
                                  "150mm    T 2.0   ^48in",
                                  "200mm    T 2.8   ^48in",
                                  "250mm    T 2.8   ^48in"]
        }
        
        /// Primes "Panavision"  "Primo V"  14.5	17.5	21	27	35	40 	50	75	100
        if compState[1] == 1 && compState[2] == 4 && compState[3] == 1 {
            
            thePrimes   = ["14.5mm", "17.5mm", "21mm", "27mm","35mm","40mm", "50mm", "75mm", "100mm"]
            
            displayLensArray   = ["14.5mm   T 1.9   ^2ft",
                                  "17.5mm   T 1.9   ^2ft",
                                  "21mm     T 1.9   ^2ft",
                                  "27mm     T 1.9   ^2ft",
                                  "35mm     T 1.9   ^2ft",
                                  "40mm     T 1.9   ^2ft",
                                  "50mm     T 1.9   ^2ft",
                                  "75mm     T 1.9   ^2ft",
                                  "100mm    T 1.9   ^2ft"]
        }
        
        /// Primes "Panavision"   "P Vintage" 14	17	24	29	35 40	50	75	100
        if compState[1] == 1 && compState[2] == 4 && compState[3] == 2 {
            
            thePrimes   = ["14mm", "17mm", "24mm", "29mm","35mm","40mm", "50mm", "75mm", "100mm"]
            
            displayLensArray   = ["14mm     T 1.9   ^2ft",
                                  "17mm     T 1.9   ^2ft",
                                  "24mm     T 1.2   ^2ft",
                                  "29mm     T 1.2   ^2ft 4in",
                                  "35mm     T 1.6   ^2ft",
                                  "40mm     T 1.3   ^2ft",
                                  "50mm     T 1.0   ^2ft",
                                  "75mm     T 1.6   ^2ft",
                                  "100mm    T 1.6   ^4ft"]
        }
        
        /// Primes "Panavision"  "Primo"
        if compState[1] == 1 && compState[2] == 4 && compState[3] == 3 {
            
            thePrimes   = ["10mm","14.5mm","17.5mm","21mm","27mm","35mm","40mm","50mm","65mm","75mm","85mm","100mm","125mm","150mm"]
            
            displayLensArray   = ["10mm     T 1.9   ^2ft",
                                  "14.5mm   T 1.9   ^2ft",
                                  "17.5mm   T 1.9   ^2ft",
                                  "21mm     T 1.9   ^2ft",
                                  "27mm     T 1.9   ^2ft",
                                  "35mm     T 1.9   ^2ft",
                                  "40mm     T 1.9   ^2ft",
                                  "50mm     T 1.9   ^2ft",
                                  "65mm     T 1.9   ^2ft",
                                  "75mm     T 1.9   ^3ft",
                                  "85mm     T 1.9   ^2ft",
                                  "100mm    T 1.9   ^3ft",
                                  "125mm    T 1.9   ^2ft 2in",
                                  "150mm    T 1.9   ^5ft"
            ]
        }
        
        /// Primes "Panavision"  "Legacy" Series MkII
        if compState[1] == 1 && compState[2] == 4 && compState[3] == 4 {
            
            thePrimes   = ["14mm", "24mm", "29mm", "35mm","50mm","85mm", "100mm", "135mm", "180mm"]
            
            displayLensArray   = ["14mm     T 1.9   ^2ft",
                                  "24mm     T 1.3   ^2ft",
                                  "29mm     T 1.3   ^2ft",
                                  "35mm     T 1.4   ^2ft",
                                  "50mm     T 1.4   ^2ft",
                                  "85mm     T 1.4   ^2ft",
                                  "100mm    T 2.0   ^3ft",
                                  "135mm    T 2.0   ^5ft",
                                  "180mm    T 2.8   ^5ft"]
        }
        
        /// Primes "Panavision"  "Primo Digital"
        if compState[1] == 1 && compState[2] == 4 && compState[3] == 5 {
            
            thePrimes   = ["5mm", "7mm", "10mm", "14mm","20mm","35mm"]
            
            displayLensArray   = ["5mm     T 1.8   ^10.5in",
                                  "7mm     T 1.6   ^12in",
                                  "10mm    T 1.6   ^12in",
                                  "14mm    T 1.6   ^12in",
                                  "20mm    T 1.6   ^13in",
                                  "35mm    T 1.6   ^20in"]
        }
        
        /// Primes "Panavision"  "Portrait"
        if compState[1] == 1 && compState[2] == 4 && compState[3] == 6 {
            
            thePrimes   = ["14mm", "16mm", "20mm", "24mm","35mm","35mm"]
            
            displayLensArray   = ["14mm     T 1.9   ^2ft",
                                  "16mm     T 2.8   ^1ft 8in",
                                  "20mm     T 3     ^2ft 6in",
                                  "24mm     T 2.8   ^2ft 3in",
                                  "35mm     T 1.4   ^2ft",
                                  "35mm     T 2     ^1ft 8in"]
        }
        
        /// Primes "Panavision"  "Flare"
        if compState[1] == 1 && compState[2] == 4 && compState[3] == 7 {
            
            thePrimes   = ["14mm", "17mm", "20mm", "24mm","28mm","28mm", "32mm",	"35mm",	"40mm",	"50mm",	"75mm",	"100mm"]
            
            displayLensArray   = ["14mm     T 1.9   ^2ft",
                                  "17mm     T 1.9   ^2ft",
                                  "20mm     T 3     ^2ft",
                                  "24mm     T 2.8   ^2ft",
                                  "28mm     T 1.9   ^2ft",
                                  "28mm     T 1.9   ^2ft",
                                  "32mm     T 2.8   ^2ft",
                                  "35mm     T 2     ^2ft",
                                  "40mm     T 2     ^2ft",
                                  "50mm     T 2.3   ^2ft",
                                  "75mm     T 2     ^2ft",
                                  "100mm    T 1.6   ^2ft" ]
        }
        
        ///MARK: -  Primes "Perspective"  "Slant"
        if compState[1] == 1 && compState[2] == 4 && compState[3] == 8 {
            
            thePrimes   = ["24mm", "34mm", "45mm","63mm"]
            
            displayLensArray   = ["24mm     T 3.5   ^1ft",
                                  "34mm     T 4.9   ^1ft 1in",
                                  "45mm     T 2.8   ^1ft 4in",
                                  "63mm     T 4     ^1ft 5in"]
        }
        
        /// Primes "Perspective"  "Swing Shift"
        if compState[1] == 1 && compState[2] == 4 && compState[3] == 9 {
            
            thePrimes   = ["14mm", "18mm", "24mm", "28mm","35mm","45mm", "55mm", "75mm", "90mm", "105mm", "135mm", "150mm"]
            
            displayLensArray   = ["14mm     T 2.8",
                                  "18mm     T 2.8",
                                  "24mm     T 4",
                                  "28mm     T 3.5",
                                  "35mm     T 2.8",
                                  "45mm     T 2.8",
                                  "55mm     T 2.8",
                                  "75mm     T 2.8",
                                  "90mm     T 2.8",
                                  "105mm    T 2.4",
                                  "135mm    T 4.5",
                                  "150mm    T 3.5" ]
        }
        
        
        /// Primes + Vantage One
        if compState[1] == 1 && compState[2] == 5 && compState[3] == 0 {
            
            thePrimes   = ["17.5mm", "21mm", "25mm", "32mm","40mm","50mm", "65mm", "90mm", "102mm"]
            
            displayLensArray   = ["17.5mm   T 1.0   ^10in",
                                  "21mm     T 1.0   ^10in",
                                  "25mm     T 1.0   ^10in",
                                  "32mm     T 1.0   ^10in",
                                  "40mm     T 1.0   ^1ft 2in",
                                  "50mm     T 1.0   ^1ft 2in",
                                  "65mm     T 1.0   ^1ft 2in",
                                  "90mm     T 1.0   ^1ft 8in",
                                  "102mm    T 1.0   ^2ft 6in"]
        }
        
        /// Primes + B+L Super Baltar
        if compState[1] == 1 && compState[2] == 6 && compState[3] == 0 {
            
            thePrimes   = ["20mm", "25mm", "35mm","50mm", "75mm", "100mm"]
            
            displayLensArray = ["20mm     T 2.3   ^18in",
                                "25mm     T 2.3   ^18in",
                                "35mm     T 2.3   ^18in",
                                "50mm     T 2.3   ^18in",
                                "75mm     T 2.3   ^22in",
                                "100mm    T 2.3   ^4ft"]
        }
        
        /// Primes + Kowa Cine Prominar
        if compState[1] == 1 && compState[2] == 7 && compState[3] == 0 {
            
            thePrimes   = ["15mm", "20mm", "25mm", "32mm","40mm","50mm", "75mm", "100mm", "200mm"]
            
            displayLensArray = ["15mm     T 4     ^12in",
                                "20mm     T 2.3   ^12in",
                                "25mm     T 2.3   ^12in",
                                "32mm     T 2.3   ^1ft 6in",
                                "40mm     T 2.3   ^2ft 6in",
                                "50mm     T 2.3   ^2ft 6in",
                                "75mm     T 2.3   ^3ft",
                                "100mm    T 2.6   ^5ft",
                                "200mm    T 2.6   ^8ft"]
        }
        
        /// Primes + Kineoptic Apochromat
        if compState[1] == 1 && compState[2] == 8 && compState[3] == 0 {
            
            thePrimes   = ["9.8mm", "18mm", "25mm","28mm", "32mm","35mm", "40mm","50mm", "75mm", "100mm"]
            
            displayLensArray = ["9.8mm    T 2.2   ^9in",
                                "18mm     T 2.8   ^8in",
                                "25mm     T 2.8   ^14in",
                                "28mm     T 2.8   ^16in",
                                "32mm     T 3.2   ^17in",
                                "35mm     T 2.4   ^22in",
                                "40mm     T 2.4   ^2ft 3in",
                                "50mm     T 2.5   ^18in",
                                "75mm     T 2.4   ^3ft",
                                "100mm    T 2.4   ^4ft"]
        }
        
        /// Primes + Nikkor
        if compState[1] == 1 && compState[2] == 9 && compState[3] == 0 {
            
            thePrimes    = ["200mm","300mm T2", "300mm T2.8","400mm"]
            
            displayLensArray = ["200mm     T 2     ^9ft",
                                "300mm     T 2     ^9ft",
                                "300mm     T 2.8   ^7ft",
                                "400mm     T 2.8   ^8ft 6in"]
        }
        
        /// Primes + Red Pro
        if compState[1] == 1 && compState[2] == 10 && compState[3] == 0 {
            
            thePrimes    = [ "18mm","25mm","35mm","50mm","85mm","100mm"]
            
            displayLensArray   = [ "18mm     T 1.8     ^13in",
                                   "25mm     T 1.8     ^4in",
                                   "35mm     T 1.8     ^4in",
                                   "50mm     T 1.8     ^6in",
                                   "85mm     T 1.8     ^18in",
                                   "100mm    T 1.8     ^2ft"]
        }
        
        /// Primes + "CamTec Vintage", 10
        if compState[1] == 1 && compState[2] == 11 && compState[3] == 0 {
            
            thePrimes   = [ "16mm","20mm","24mm","28mm","32mm",
                            "40mm","50mm","65mm","85mm","100mm","135mm"]
            
            displayLensArray  = [ "16mm     T 1.9     ^12in",
                                  "20mm     T 1.9     ^12in",
                                  "24mm     T 1.9     ^12in",
                                  "28mm     T 1.9     ^12in",
                                  "32mm     T 1.9     ^15in",
                                  "40mm     T 1.9     ^15in",
                                  "50mm     T 1.9     ^2ft",
                                  "65mm     T 1.9     ^2ft3in",
                                  "85mm     T 1.9     ^3ft",
                                  "100mm    T 1.9     ^3ft 3in",
                                  "135mm    T 1.9     ^5ft"]
        }
        
        //MARK: -  Primes + "Anamorphic", 11  selected
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 0 {
            
            thePrimes   = [ "25mm","32mm","40mm","50mm","75mm","100mm"]
            
            displayLensArray  = [ "25mm     T 2.3     ^36in",
                                  "32mm     T 2.3     ^22in",
                                  "40mm     T 2.3     ^22in",
                                  "50mm     T 2.3     ^22in",
                                  "75mm     T 2.3     ^31in",
                                  "100mm    T 2.3     ^35in"]
        }
        /// Primes + "Anamorphic Cooke
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 1 {
            
            thePrimes   = [ "25mm","32mm","40mm","50mm","75mm","100mm"]
            
            displayLensArray  = [ "25mm     T 2.3     ^36in",
                                  "32mm     T 2.3     ^22in",
                                  "40mm     T 2.3     ^22in",
                                  "50mm     T 2.3     ^22in",
                                  "75mm     T 2.3     ^31in",
                                  "100mm    T 2.3     ^35in"]
        }
        /// Primes + "Anamorphic Master Primes
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 2 {
            
            thePrimes   = [ "35mm","40mm","50mm","60mm","75mm","100mm", "135mm"]
            
            displayLensArray   = [ "35mm     T 1.9     ^2ft 6in",
                                   "40mm     T 1.9     ^2ft 4in",
                                   "50mm     T 1.9     ^2ft 6in",
                                   "60mm     T 1.9     ^3ft",
                                   "75mm     T 1.9     ^3ft",
                                   "100mm    T 1.9     ^3ft 1in",
                                   "135mm    T 1.9     ^3ft 11in"]
        }
        /// Primes + "Anamorphic Arriscope
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 3 {
            
            thePrimes   = [ "40mm","50mm","75mm","100mm", "135mm"]
            
            displayLensArray   = [ "40mm     T 2.3     ^3ft 3in",
                                   "50mm     T 2.3     ^3ft 3in",
                                   "75mm     T 2.3     ^4ft",
                                   "100mm    T 3       ^",
                                   "135mm    T 3       ^"]
        }
        /// Primes + "Anamorphic Kowa
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 4 {
            
            thePrimes   = [ "32mm","40mm","50mm","75mm","100mm" ]
            
            displayLensArray = [ "32mm     T 2.3     ^3ft",
                                 "40mm     T 2.3     ^3ft",
                                 "50mm     T 2.3     ^3ft",
                                 "75mm     T 2.8     ^3ft",
                                 "100mm    T 3.4     ^5ft"]
        }
        /// Primes + "Anamorphic Hawk VL
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 5 {
            
            thePrimes   = [ "25mm","28mm","35mm","45mm","55mm", "65mm", "80mm", "110mm", "140mm", "180mm" ]
            
            displayLensArray   = [ "25mm     T 2.2     ^3ft 6in",
                                   "28mm     T 2.2     ^2ft 7in",
                                   "35mm     T 2.2     ^3ft 3in",
                                   "45mm     T 2.2     ^3ft 3in",
                                   "55mm     T 2.2     ^3ft 3in",
                                   "65mm     T 2.2     ^3ft 3in",
                                   "80mm     T 2.2     ^3ft 3in",
                                   "110mm    T 3       ^3ft 3in",
                                   "140mm    T 3.5     ^3ft 3in",
                                   "180mm    T 3       ^6ft 6in" ]
        }
        /// Primes + "Anamorphic Hawk V
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 6 {
            
            thePrimes   = [ "25mm","35mm","40mm","50mm","75mm", "100mm", "135mm", "180mm" ]
            
            displayLensArray   = [ "25mm     T 2.2     ^3ft 6in",
                                   "35mm     T 2.2     ^2ft 6in",
                                   "40mm     T 2.2     ^2ft 6in",
                                   "50mm     T 2.2     ^2ft",
                                   "75mm     T 2.2     ^2ft",
                                   "100mm    T 2.2     ^3ft 6in",
                                   "135mm    T 3       ^3ft 6in",
                                   "180mm    T 3       ^6ft 6in"]
        }
        
        /// Primes + "Anamorphic Hawk C
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 7 {
            
            thePrimes   = [ "25mm","35mm","50mm","75mm", "100mm", "135mm"]
            
            displayLensArray   = [ "25mm     T 2.2     ^3ft 6in",
                                   "35mm     T 2.2     ^3ft 6in",
                                   "50mm     T 2.2     ^3ft 6in",
                                   "75mm     T 2.2     ^3ft 6in",
                                   "100mm    T 3       ^3ft 6in",
                                   "135mm    T 3       ^3ft 6in"]
        }
        
        /// Primes + "Anamorphic Hawk Vintage 74
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 8 {
            
            thePrimes   = [ "25mm","28mm","35mm","45mm","55mm", "65mm", "80mm", "110mm", "140mm", "180mm" ]
            
            displayLensArray   = [ "25mm     T 2.2     ^3ft 6in",
                                   "28mm     T 2.2     ^2ft 7in",
                                   "35mm     T 2.2     ^3ft 3in",
                                   "45mm     T 2.2     ^3ft 3in",
                                   "55mm     T 2.2     ^3ft 3in",
                                   "65mm     T 2.2     ^3ft 3in",
                                   "80mm     T 2.2     ^3ft 3in",
                                   "110mm    T 3       ^3ft 3in",
                                   "140mm    T 3.5     ^3ft 3in",
                                   "180mm    T 3       ^6ft 6in" ]
        }
        
        /// Primes + "Anamorphic" "Todd AO"
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 9 {
            
            thePrimes   = [ "35mm HS","38mm","40mm","55mm","55mm HS", "75mm", "85mm HS", "100mm", "200mm Macro"]
            
            displayLensArray   = [ "35mm HS   T 1.4     ^6ft",
                                   "38mm      T 2.3     ^3ft",
                                   "40mm      T 2.3     ^4ft",
                                   "55mm      T 1.3     ^3ft",
                                   "55mm HS   T 1.4     ^2ft 3in",
                                   "75mm      T 2.5     ^3ft",
                                   "85mm HS   T 1.4     ^2ft",
                                   "100mm     T 3       ^3ft",
                                   "200mm M   T 2       ^1:1"]
        }
        
        /// Primes + "Anamorphic  Cineovision
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 10 {
            
            thePrimes   = [ "24mm","35mm","40mm","50mm", "85mm", "100mm"]
            
            displayLensArray  = [ "24mm     T 1.6     ^3ft",
                                  "35mm     T 1.6     ^",
                                  "40mm     T 2.4     ^",
                                  "50mm     T 1.4     ^3ft",
                                  "85mm     T 1.4     ^3ft",
                                  "100mm    T 2.8     ^3ft"]
        }
        
        //MARK: - Primes + "Anamorphic  Panavision T Series
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 11 {
            
            thePrimes   = ["28mm","35mm","40mm","50mm","60mm","75mm","100mm","135mm","150mm","180mm","37-85mm"]
            
            displayLensArray  = [ "28mm     T 2.3     ^2ft",
                                  "35mm     T 2.3     ^2ft",
                                  "40mm     T 2.3     ^1ft 6in",
                                  "50mm     T 2.3     ^2ft",
                                  "60mm     T 2.3     ^1ft 6in",
                                  "75mm     T 2.3     ^2ft",
                                  "100mm    T 2.3     ^2ft",
                                  "135mm    T 2.3     ^2ft 6in",
                                  "150mm    T 3.1     ^3ft 6in",
                                  "180mm    T 2.8     ^3ft 6in",
                                  "37-85mm  T 2.8     ^2ft 9in"]
        }
        
        //MARK: - Primes + "Anamorphic  Panavision G Series
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 12 {
            
            thePrimes   = ["25mm","30mm","35mm","40mm","50mm","60mm","75mm","100mm"]
            
            displayLensArray  = [ "25mm     T 2.6     ^2ft 6in",
                                  "30mm     T 2.6     ^2ft 6in",
                                  "35mm     T 2.6     ^3ft",
                                  "40mm     T 2.6     ^3ft",
                                  "50mm     T 2.6     ^3ft",
                                  "60mm     T 2.6     ^3ft",
                                  "75mm     T 2.6     ^3ft",
                                  "100mm    T 3       ^3ft"]
        }
        
        //MARK: - Primes + "Anamorphic  Panavision Primo
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 13 {
            
            thePrimes   = ["35mm","40mm","50mm","75mm","100mm"]
            
            displayLensArray  = [ "35mm     T 2     ^3ft 6in",
                                  "40mm     T 2     ^3ft 6in",
                                  "50mm     T 2     ^3ft 6in",
                                  "75mm     T 2     ^4ft 6in",
                                  "100mm    T 2     ^4ft 6in"]
        }
        
        //MARK: - Primes + "Anamorphic  Panavision E Series
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 14 {
            
            thePrimes   = ["28mm", "35mm", "40mm", "50mm", "75mm", "85mm", "100mm", "135mm", "180mm"]
            
            displayLensArray  = [ "28mm     T 2.3   ^4ft",
                                  "35mm     T 2     ^3ft 6in",
                                  "40mm     T 2     ^4ft",
                                  "50mm     T 2     ^4ft",
                                  "75mm     T 2     ^4ft",
                                  "85mm     T 2     ^5ft",
                                  "100mm    T 2.3   ^5ft",
                                  "135mm    T 2.8   ^3ft 9in",
                                  "180mm    T 2.8   ^4ft 6in" ]
        }
        
        //MARK: - Primes + "Anamorphic  Panavision C Series
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 15 {
            
            thePrimes   = ["35mm", "40mm", "50mm", "60mm","75mm", "100mm", "150mm","180mm"]
            
            displayLensArray  = [ "35mm     T 3     ^4ft",
                                  "35mm     T 2.3   ^2ft 9in",
                                  "40mm     T 2.8   ^2ft 6in",
                                  "50mm     T 2.3   ^2ft 6in",
                                  
                                  "60mm     T 2.8   ^1ft 6in",
                                  "75mm     T 2.5   ^4ft 6in",
                                  "100mm    T 2.8   ^4ft 6in",
                                  "150mm    T 3.5   ^5ft",
                                  "180mm    T 2.8   ^7ft" ]
        }
        
        //MARK: - Primes + "Anamorphic  Panavision High Speed
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 16 {
            
            thePrimes   = ["35mm","50mm", "55mm","75mm", "100mm"]
            
            displayLensArray  = [ "35mm     T 1.4   ^4ft 6in",
                                  "50mm     T 1.1   ^4ft",
                                  "55mm     T 1.4   ^4ft",
                                  "75mm     T 1.8   ^4ft 6in",
                                  "100mm    T 1.8   ^4ft 6in" ]
        }
        
        //MARK: - Primes + "Anamorphic  Panavision Macro Pantar
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 17 {
            
            thePrimes   = ["90mm","55mm", "150mm","200mm", "250mm"]
            
            displayLensArray  = [ "90mm     T 4.3   ^1ft 5in",
                                  "55mm     T 2.5   ^10in",
                                  "150mm    T 3.2   ^1ft 5in",
                                  "200mm    T 3.2   ^1ft 6in",
                                  "250mm    T 3.2   ^2ft 3in" ]
        }
        
        //MARK: - Primes + "Anamorphic  Panavision Telephoto
        if compState[1] == 1 && compState[2] == 12 && compState[3] == 18 {
            
            thePrimes   = ["300mm","400mm", "400mm","600mm", "600mm","800mm"]
            
            displayLensArray  = [ "300mm    T 3.8   ^6ft 6in",
                                  "400mm    T 3.5   ^9ft",
                                  "400mm    T 3.0   ^8ft",
                                  "600mm    T 4.0   ^13ft",
                                  "600mm    T 4.5   ^27ft",
                                  "800mm    T 5.0   ^15ft" ]
        }
        
        ///MARK: -  Primes "Perspective"  "Slant"
        if compState[1] == 1 && compState[2] == 13 && compState[3] == 0 {
            
            thePrimes   = ["24mm", "34mm", "45mm","63mm"]
            
            displayLensArray   = ["24mm     T 3.5   ^1ft",
                                  "34mm     T 4.9   ^1ft 1in",
                                  "45mm     T 2.8   ^1ft 4in",
                                  "63mm     T 4     ^1ft 5in"]
        }
        
        /// Primes "Perspective"  "Swing Shift"
        if compState[1] == 1 && compState[2] == 13 && compState[3] == 1 {
            
            thePrimes   = ["14mm", "18mm", "24mm", "28mm","35mm","45mm", "55mm", "75mm", "90mm", "105mm", "135mm", "150mm"]
            
            displayLensArray   = ["14mm     T 2.8",
                                  "18mm     T 2.8",
                                  "24mm     T 4",
                                  "28mm     T 3.5",
                                  "35mm     T 2.8",
                                  "45mm     T 2.8",
                                  "55mm     T 2.8",
                                  "75mm     T 2.8",
                                  "90mm     T 2.8",
                                  "105mm    T 2.4",
                                  "135mm    T 4.5",
                                  "150mm    T 3.5" ]
        }
        
        /// arri macro
        if compState[1] == 2 && compState[2] == 0 && compState[3] == 0 {
            thePrimes = ["17.5mm", "21mm", "25mm", "32mm","40mm","50mm", "65mm", "90mm", "102mm"]
            
            displayLensArray   = ["17.5mm   T 1.0   ^10in",
                                  "21mm     T 1.0   ^10in",
                                  "25mm     T 1.0   ^10in",
                                  "32mm     T 1.0   ^10in",
                                  "40mm     T 1.0   ^1ft 2in",
                                  "50mm     T 1.0   ^1ft 2in",
                                  "65mm     T 1.0   ^1ft 2in",
                                  "90mm     T 1.0   ^1ft 8in",
                                  "102mm    T 1.0   ^2ft 6in"]
        }
        
        // master prime macro
        if compState[1] == 2 && compState[2] == 1 && compState[3] == 0 {
            thePrimes = [ "100mm"]
            
            displayLensArray = [ "100mm      T 2   ^13.75in"]
        }
        
        //MARK: - panavision macro
        if compState[1] == 2 && compState[2] == 2 && compState[3] == 0 {
            thePrimes = ["50mm", "90mm", "200mm"]
            
            displayLensArray   = ["50mm     T 1.4",
                                  "90mm     T 2   ^1:1",
                                  "200mm    T 4   "]
        }
        
        // probe lens  innovosion probe II+
        if compState[1] == 3 && compState[2] == 0 && compState[3] == 0 {
            thePrimes = ["9mm", "12mm", "16mm", "20mm", "28mm", "32mm", "40mm" , "55mm"]
            
            displayLensArray = ["9mm    T 6.3", "12mm    T 6.3", "16mm    T 6.3", "20mm    T 6.3", "28mm    T 6.3", "32mm    T 6.3", "40mm    T 6.3" , "55mm    T 6.3"]
        }
        // probe lens  trex probe
        if compState[1] == 3 && compState[2] == 1 && compState[3] == 0 {
            
            thePrimes   = ["5.5-20mm", "8-18mm", "17-35mm", "32-70mm", "55-112mm Macro"]
            displayLensArray = ["5.5-20mm   T 7.1", "8-18mm   T 7.1", "17-35mm   T 7.1", "32-70mm   T 7.1", "55-112mm   T 7.1 Macro"]
        }
        
        // probe lens  revolution probe
        if compState[1] == 3 && compState[2] == 2 && compState[3] == 0 {
            
            thePrimes  = ["9.8mm", "12mm", "16mm", "20mm", "24mm", "32mm", "40mm" , "65mm"]
            displayLensArray  = ["9.8mm T 7.5", "12mm T 7.5", "16mm T 7.5", "20mm T 7.5", "24mm T 7.5", "32mm T 7.5", "40mm T 7.5" , "65mm T 7.5"]
        }
        
        // probe lens  skater scope
        if compState[1] == 3 && compState[2] == 3 && compState[3] == 0 {
            
            thePrimes   = ["PL Mount"]
            displayLensArray = ["PL Mount"]
        }
        
        // probe lens  century periscope
        if compState[1] == 3 && compState[2] == 4 && compState[3] == 0 {
            
            thePrimes   = ["PL Mount"]
            displayLensArray = ["PL Mount"]
        }
        
        // probe lens  optex probe
        if compState[1] == 3 && compState[2] == 5 && compState[3] == 0 {
            
            thePrimes  = ["10mm", "14mm", "20mm", "28mm"]
            displayLensArray = ["10mm   T 5.6", "14mm   T 5.6", "20mm   T 5.6", "28mm   T 5.6"]
        }
        
        //MARK: -  add frasier
        // probe lens  frazier
        if compState[1] == 3 && compState[2] == 6 && compState[3] == 0 {
            
            thePrimes  = ["17mm", "20mm", "24mm", "28mm", "35mm", "45mm", "50mm"]
            displayLensArray =  ["17mm    T 7.1", "20mm    T 7.1", "24mm    T 7.1", "28mm    T 7.1", "35mm    T 7.1", "45mm    T 7.1", "50mm    T 7.1"]          }
        
        /*
         Monitors OLED ----------------
         15" TVLogic Professional OLED Monitor
         17" Sony PVMA170 Professional Trimaster EL OLED Monitor
         17" Sony PVM-1741 Professional OLED Monitor
         25" Sony PVM-2541 Professional OLED Monitor
         25" Sony BVM-E250 Trimaster EL OLED Monitor
         
         Monitors LCD ------------------
         4.8" RUIGE TL-480HD Small On-Camera HD LCD
         5" Transvideo Starlite HD5-Arri Monitor
         5.6" Small HD DP6-SDI Monitor
         5.6" TVLogic Monitor
         6" Astro 3005 Monitor
         6" Astro 3004 & 3014 Monitor with Waveform/Vectorscope
         6" Transvideo HD6-SBL Evolution Monitor
         7" Marshall V-R07P HD/SDI LCD Monitor
         7" TVLogic HD/SD LCD Monitor LVM-07W
         7.7" Small HD Monitor AC7-SDI Monitor
         7.7" Small HD DP7 Pro Monitor
         8" Panasonic LCD Monitor
         12" Transvideo Cine Monitor
         17" TVLogic HD/SD LCD Monitor LVM-173W
         17" Panasonic 1700WP LCD Monitor
         23" Cinetal LCD Full Feature Monitor
         23" eCinema LCD Monitor
         23" Sony BVM-L230 HD LCD Monitor
         24" Cinemage 2000 LCD Monitor
         26" Panasonic 2600WP LCD Monitor
         */
        
        // AKS
        if compState[1] == 6 {
            thePrimes =  [  "Monitors OLED ----------------",
                            "15” TVLogic Professional OLED Monitor",
                            "17” Sony PVMA170 Professional Trimaster",
                            "25” Sony PVM-2541 Professional OLED Monitor",
                            "Monitors LCD ------------------",
                            "4.8” RUIGE TL-480HD Small On-Camera HD LCD",
                            "5” Transvideo Starlite HD5-Arri Monitor",
                            "5.6” TVLogic Monitor",
                            "6” Astro 3005 Monitor",
                            "7” TVLogic HD/SD LCD Monitor LVM-07W",
                            "7.7” Small HD DP7 Pro Monitor",
                            "8” Panasonic LCD Monitor",
                            "17” TVLogic HD/SD LCD Monitor LVM-173W",
                            "23” Cinetal LCD Full Feature Monitor",
                            "24” Cinemage 2000 LCD Monitor",
                            "26” Panasonic 2600WP LCD Monitor",
                            "Hand Held Aks ------------------",
                            "Hand Held Rig",
                            "Spider Hand Held Rig",
                            "Element Technica Mantis Hand Held Rig",
                            "Easy Rig 500",
                            "Easy Rig 600",
                            "Easy Rig 700",
                            "Easy Rig 850",
                            
                            "Focus Aks ------------------",
                            "Arri Follow Focus 4",
                            "Hand Held FF4",
                            "Speed Crank",
                            "Follow Focus Whips (Short + Long)",
                            "Iris Rods",
                            "C-Motion Lens Control System",
                            "Preston FI&Z II System",
                            "Preston FI&Z III System",
                            
                            "Matte Box Aks ---------------",
                            "MB14 Mattebox 4 Stage 2 geared, 2 std)",
                            "MB14 2-Stage Attachment",
                            "MB18 Mattebox 3 Stage 1 geared, 2 std",
                            "MB20 Mattebox 4 Stage 2 geared, 2 std)",
                            "6x6 Sunshade",
                            "4x5 Sunshade",
                            "6x6 Arri Clip-on Hand Held Mattebox",
                            "4x5 Arri Clip-on Hand Held Mattebox",
                            "4.5” Round Clip-on Sun Shade",
                            "138mm Round Clip-on Sun Shade",
                            "Series 9 Clip-on Sun Shade",
                            
                            "Wireless Aks ---------------------",
                            "Wireless Video",
                            "Teradek Wireless Video",
                            "Paralinx Wireless Video",
                            
                            "Misc Aks ---------------------",
                            "Arri 24V Rem Switch w/Ext",
                            "Base Plate Top, Bottom w/Quick Release",
                            "24Volt Splitter Box",
                            "Assistant Lens Light",
                            "Arri Eyepiece Heater Cup",
                            "Hand Held & StudioRain Deflectors",
                            "Weather Protectors & Heater Barnies",
                            "Digi-Clamshell",
                            "Cinetape (Digital Range Finder)",
                            "Cinetape Link 1 (Transmitter & Receiver)",
                            "Film Video Sync Box",
                            "Element Technica “V” Dock & Base Plate",
                            "Element Technica Cheese Stk Handle & Plate",
                            "Element Technica Iso Plate Shock Mount",
                            
                            "Media Cards ----------------",
                            "60 GB CFast 2.0 Cards",
                            "120 GB CFast 2.0 Cards",
                            "128 GB CFast 2.0 Cards",
                            "CFast Card Reader",
                            "32g SxS Pro Card",
                            "64g SxS Pro Card",
                            "128g SxS Pro Card",
                            "RedMag SSD: 128GB",
                            "RedMag SSD: 256GB",
                            "RedMag SSD: 64GB",
                            
                            "Media Drives ----------------",
                            "XR Capture Drive 512gig",
                            "Codex Capture Drive (512 MB)",
                            "Codex Capture Drive (USB-3)",
                            "Codex On-Board Recorder S (CDX-3600)",
                            "Codex Portable Pack",
                            "Batteries Aks ---------------",
                            "Dionic HCX High Capacity Batteries",
                            "Quad Charger",
                            "Anton Bauer Dionic 4c 14.4V 91WH Li-Ion",
                            "IDX E-HL9 14.4V 88WH Li-Ion",
                            "IDX D-150 14.4V 144 WH Li-Ion",
                            "Sony BPFL-75 12.8V 76 WH Li-Ion",
                            "Arri 235/416 24V 2.74 NiMH",
                            "Arri 16SR3 24V 2.74 NiMh",
                            
                            "Anton Bauer Cine VCLX 14.4/28V 560W NiMH",
                            "Cine Power HS 30 14.4/28V 30A NiMH",
                            "CCI 14.4V 30A NiMH",
                            "CCI 14.4V 40A NiMH",
                            "CCI 14.4V 25A BC",
                            "CCI 24V 20A NiMH",
                            "CCI 12V 12A Super Dual Lead-Acid",
                            "CCI 24V 12A Lead-Acid",
                            "CCI 30V 12A Lead-Acid",
                            "CCI 12V/24V 4.7A NiMH Belt",
                            "CCI 13.2V 18A NiMH Backpack",
                            "CCI 14.4V 30A NiMH Backpack",
                            "CCI 24V 10A NiMH Backpack",
                            "Teleprompter ---------------",
                            "QPro Teleprompter",
                            "Proline Teleprompter",
                            "Flex Teleprompter",
                            "Teleprompter Free Stand"
            ]
            
            displayLensArray = thePrimes
        }
        
        // Finder
        if compState[1] == 7 {
            thePrimes =  ["Standard Finder", "Anamorphic Finder"]
            
            displayLensArray = thePrimes
        }
        
        // Filters
        if compState[1] == 8 {
            thePrimes =  ["Diopter +1/2 +1 +2 +3",
                          "Achromatic Diopter +1/2 +1 +2 +3",
                          "Split Diopter +1/2 +1 +2 +3",
                          "Optical Flat",
                          "ND .3 .6 .9 1.2 1.5 1.8 2.1",
                          "ND IR .3 .6 .9 1.2 1.5 1.8 2.1",
                          "Platinum IRND .3 .6 .9 1.2 1.5 1.8 2.1",
                          "True ND IR .3 .6 .9 1.2 1.5 1.8 2.1",
                          "Polarizer",
                          "Polarizer True Circular",
                          "Polarizer Ultra",
                          "Enhancer",
                          
                          "------- Diffusion ------",
                          "Black Diffusion FX",
                          "Black Dot Textured Screen",
                          "Black Frost",
                          "Black Net",
                          "Black Promist",
                          "Black Supa Frost",
                          "Double Fog",
                          "Promist",
                          "Soft Centric",
                          "Soft Contrast",
                          "Soft FX",
                          "Scenic Fog",
                          "Classic Black Soft",
                          "Classic Soft",
                          "Fog",
                          "White Frost",
                          "White Net",
                          "White Supa Frost",
                          
                          "------- EFX ------",
                          "Star 4 Point (2mm, 3mm, 4mm)",
                          "Star 6 Point (2mm, 3mm, 4mm)",
                          "Star 8 Point (2mm, 3mm, 4mm)",
                          "Streak",
                          "Blue Streak Effect (1mm, 2mm, 3mm)",
                          "Blue Vision Medium",
                          "Blue Vision Ultra Fine",
                          
                          "------- Correction ------",
                          "81",
                          "82",
                          "85",
                          "812",
                          "80A",
                          "80B",
                          "80C",
                          "80D",
                          "81A",
                          "81B",
                          "81C",
                          "81D",
                          "81EF",
                          "81EF ND .3 .6 .9",
                          "82A",
                          "82B",
                          "82C",
                          "85 ND .3 .6 .9 1.2",
                          "85 Linear Polarizer",
                          "85 Circular Polarizer",
                          "85B",
                          "85B ND .3 .6 .9 1.2",
                          "85C"
            ]
            
            displayLensArray = thePrimes
            
            /*  saving these filters for possible future editions
             "Antique Suede 1
             "Antique Suede 2
             "Antique Suede 3
             
             ND Blender Horizontal
             ND Blender Vertical
             Blink Filters
             Blue
             Blue Attenuator
             Blue Grad Hard and Soft Edge
             Blue Grey Grad
             
             Chocolate
             Chocolate Grad Hard and Soft Edge
             Clairmont In-camera filter kit
             
             Color Correction Magenta
             Color Correction Green
             Color Correction Yellow
             Cool Blue Grad
             Coral
             Coral Attenuator
             Coral Grad Hard and Soft Edge
             Cranberry
             Cranberry Grad
             Cyan
             Cyan Attenuator
             Cyan Grad
             Day 4 Night
             Day 4 Night Cool
             Day 4 Night Mono
             Diffusion
             
             EK 87
             
             FLB
             FLD
             Flesh Net
             
             Glimmer Glass
             Gold
             Gold Diffusion FX
             Golden Sepia
             Grape
             Grape Grad
             Green
             Green Attenuator
             Green Grad
             Green/Yellow
             Haze 2A
             HD Soft
             HD UV
             Hollywood Black Magic
             Hollywood Star
             Hot Mirror IR
             Hyper Star
             
             LLD
             Low Contrast
             Magenta Attenuator
             Magenta Grad
             NBRA
             
             ND Attenuator Grad
             ND Corona 1" Spot
             ND Corona 2" Spot
             ND Elliptical 1" Spot
             ND Elliptical 2" Spot
             ND Grad Hard and Soft Edge
             North Star
             
             Orange
             Pink Attenuator
             Pink Grad Hard and Soft Edge
             
             Plum Grad
             Red
             Red Attenuator
             Red Grad
             Red Net
             
             Sepia
             Sepia Grad
             Skin Net
             Sky Blue
             Skyfire
             Smoque
             
             Storm Blue
             Storm Blue Grad
             Straw
             Straw Grad Hard and Soft Edge
             
             Sunset
             Supa Frost
             Tangerine
             Tangerine Grad
             Tobacco
             Tobacco Grad
             Tropical Blue Grad
             True Cut 750 IR
             
             True Streak Confetti
             Twilight
             Ultra Contrast
             
             UV 16
             Vector Star
             Warm Black Promist
             Warm Pola
             Warm Promist
             Warm Soft FX
             
             Yellow
             Yellow Grad
             */
        }
        
        // Support
        if compState[1] == 9 {
            thePrimes =  ["Sachtler Cine 30 HD",
                          "Sachtler Studio 9+9 Head",
                          
                          "O’Connor Ultimate 25/75 Head",
                          "O’Connor Ultimate 2060 Head",
                          
                          "Cartoni Sigma Head",
                          "Cartoni Master Head",
                          "Cartoni Gamma Head",
                          "Cartoni C40S Dutch Head",
                          "Cartoni Lambda Head",
                          "Cartoni Lambda 3 axis Head",
                          
                          "Arri Gear Head",
                          "Panaviaion Gear head",
                          
                          "Weaver Steadman Head",
                          "Weaver Steadman 3 axis Head",
                          "Ronford F-7 Head",
                          "Lambda Head",
                          "Lambda Third Axis Kit",
                          
                          "Tango Swing Plate",
                          
                          "Original Slider",
                          "Slider",
                          "P+S Technic Skater Jr",
                          
                          "Standards Sticks",
                          "Baby Sticks",
                          "High Hat",
                          "Low Hat"]
            
            displayLensArray =  thePrimes
        }
    }
    
    //MARK: - format message
    /// format message string
    func messageContent()-> String {
        var message = ""
        var counter = 0
        for line in tableViewArray {
            if counter == 0 {
                message += "\nCamera  Order\n\r"
                message += "\(line[0])\n\r"
                
            } else {
                message += "\(line[0])\n\(line[1])\n\r"
            }
            counter = counter + 1
        }
        return message
    }
}


