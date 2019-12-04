////
////  Weather API.swift
////  Camera Order Scout
////
////  Created by Warren Hansen on 2/6/17.
////  Copyright © 2017 Warren Hansen. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//struct ForecastDetail {
//    let high: String
//    let low: String
//    let conditions: String
//    let icon: String
//    let pop: Float
//    let humidity: Float
//}
//
//struct ForecastDate {
//    let yday: Int
//    let weekdayShort: String
//    let weekday: String
//    let month: Int
//    let dayte: Int
//}
//
//func setIcon(input:String)-> UIImage {
//    
//    var thisImage:UIImage
//    
//    switch input {
//    case "Chance of Rain":
//        thisImage = UIImage(named: "chancerain")!
//        //print("\nSwitch: \(input)")
//    case "Chance of Storms":
//        thisImage =  UIImage(named: "chancetstorms")!
//        //print("\nSwitch: \(input)")
//    case "Clear":
//        thisImage = UIImage(named: "clear")!
//        //print("\nSwitch: \(input)")
//    case "nt_clear":
//        thisImage = UIImage(named: "nt_clear")!
//    case "Partly Cloudy":
//        thisImage = UIImage(named: "partlycloudy")!
//    case "Overcast":
//        thisImage = UIImage(named: "overcast")!
//    case "Cloudy":
//        thisImage = UIImage(named: "overcast")!
//    case "Mostly Cloudy":
//        thisImage = UIImage(named: "overcast")!
//    case "Rain":
//        thisImage = UIImage(named: "chancerain")!
//        //print("\nSwitch: \(input)")
//    case "nt_partlycloudy":
//        thisImage = UIImage(named: "partlycloudy")!
//    case "Snow":
//        thisImage = UIImage(named: "snow")!
//    case "Fog":
//        thisImage = UIImage(named: "snow")!
//    default:
//        thisImage = UIImage(named: "clear")!
//    }
//    
//    return thisImage
//}
//
//extension ForecastDate {
//    
//    /// Initialize ForecastDate model from JSON data.
//    init?(json: [String: Any]) {
//        
//        // extract dictionary from json data
//        guard let date = json["date"] as? [String: Any] else { return nil }
//        
//        // extract values from dictionary
//        guard let yd = date["yday"] as? Int else { return nil }
//        guard let dayshort = date["weekday_short"] as? String else { return nil }
//        guard let day = date["weekday"] as? String else { return nil }
//        guard let month = date["month"] as? Int else { return nil }
//        guard let dayte = date["day"] as? Int else { return nil }
//        
//        // set struct properties
//        self.yday = yd
//        self.weekdayShort = dayshort
//        self.weekday = day
//        self.month = month
//        self.dayte = dayte
//    }
//    
//    static func forecastDateArray(json: [String: Any]) -> [ForecastDate]? {
//        guard let forecast = json["forecast"] as? [String: Any] else { return nil }
//        guard let simpleforecast = forecast["simpleforecast"] as? [String: Any] else { return nil }
//        guard let forecastArray = simpleforecast["forecastday"] as? [[String: Any]] else { return nil }
//        // this line was changed when updating to swift 4
//        //let forecasts = forecastArray.flatMap{ ForecastDate(json: $0) }
//        let forecasts = forecastArray.compactMap { ForecastDate(json: $0) }
//        return forecasts.count > 0 ? forecasts : nil    // if array has no elements return nil
//    }
//}
//
//extension ForecastDetail {
//    
//    /// Initialize ForecastDetail model from JSON data.
//    init?(json: [String: Any]) {
//        
//        // extract dictionaries from json data
//        guard let high = json["high"] as? [String: Any] else { return nil }
//        guard let low = json["low"] as? [String: Any] else { return nil }
//        
//        // extract values from dictionaries
//        guard let hi = high["fahrenheit"] as? String else { return nil }
//        guard let lo = low["fahrenheit"] as? String else { return nil }
//        guard let co = json["conditions"] as? String else { return nil }
//        guard let ic = json["icon"] as? String else { return nil }
//        guard let po = json["pop"] as? Float else { return nil }
//        guard let hu = json["avehumidity"] as? Float else { return nil }
//        
//        // set struct properties
//        self.high = hi
//        self.low = lo
//        self.conditions = co
//        self.icon = ic
//        self.pop = po
//        self.humidity = hu
//    }
//    
//    static func forecastDetialArray(json: [String: Any]) -> [ForecastDetail]? {
//        guard let forecast = json["forecast"] as? [String: Any] else { return nil }
//        guard let simpleforecast = forecast["simpleforecast"] as? [String: Any] else { return nil }
//        guard let forecastArray = simpleforecast["forecastday"] as? [[String: Any]] else { return nil }
//        //let forecasts = forecastArray.flatMap{ ForecastDetail(json: $0) }
//        let forecasts = forecastArray.compactMap { ForecastDetail(json: $0) }
//        return forecasts.count > 0 ? forecasts : nil    // if array has no elements return nil
//    }
//}
//
//class GetWeather {
//    // MARK: - Forecast
//    func getForecast(completion: @escaping (_ result: String) -> Void) {
//        
//        print("inside getForecast() with url \(CurrentLocation.sharedInstance.forcastURL! )\n")
//        var theWeather: String = ""
//        
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 15 // seconds
//        configuration.timeoutIntervalForResource = 15
//        let session = URLSession(configuration: configuration)
//        
//        
//        let task = session.dataTask(with: CurrentLocation.sharedInstance.forcastURL! as URL) {(data, response, error) in
//            
//            // Parse the data error
//            guard error == nil else {
//                
//                DispatchQueue.main.async(execute: {
//                    // create text block for error
//                    let errorString = "\n⚠️\n\nWe had a problem contacting\n weather at wunderground. \n\n" + "\(error!.localizedDescription) "
//                    
//                    completion(errorString)
//                })
//                return
//            }
//            
//            let json: [String: Any]?
//            
//            do {
//                json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
//                
//            } catch {
//                json = nil
//                print("json = nil")
//                return
//            }
//            // weather detail object
//            if  let forecastDetail = ForecastDetail.forecastDetialArray(json: json!) {
//                
//                var dateDetailArray:[String] = [" "]
//                
//                var i = 0
//                
//                dateDetailArray.removeAll()
//                
//                for element in forecastDetail {
//                    
//                    // date object array
//                    let forecastDate = ForecastDate.forecastDateArray(json: json!)
//                    var thisDate = "17"
//                    // parse month / day
//                    if forecastDate?[i].month != nil && forecastDate?[i].dayte != nil
//                    {
//                        thisDate = String(forecastDate![i].month) + "/" + String(forecastDate![i].dayte)
//                    }
//                    // setting one line fore each day
//                    let newLine = thisDate + "\t" + element.low + "°-" + element.high + "°\t" + element.conditions + "\n"
//                    dateDetailArray.append(newLine)
//                    
//                    i = i + 1
//                }
//                
//                DispatchQueue.main.async(execute: {
//                    // create text block for weather forecast array
//                    for element in dateDetailArray {
//                        let newElement = element
//                        theWeather = theWeather + newElement
//                    }
//                    
//                    completion("\(theWeather)")
//                    
//                })
//            } else {
//                //print("\n⚠️\n\nYour city was not found on \nWunderground Weather")
//                DispatchQueue.main.async(execute: {
//                    // create text block for error
//                    let errorString = "\n⚠️\n\nYour city was not found on \nWunderground Weather"
//                    
//                    completion(errorString)
//                })
//            }
//        }
//        task.resume()
//    }
//}
