//
//  Dark Sky Weather.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 11/30/19.
//  Copyright © 2019 Warren Hansen. All rights reserved.
//  https://medium.com/lunabee-studio/building-a-weather-app-with-swiftui-4ec2743ff615


import Foundation
import CoreLocation
import Combine

class CityCoverter {
    
    func getLocation(forPlaceCalled name: String,
                     completion: @escaping(CLLocation?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                Alert.showBasic(title: "Bad Location", message: error!.localizedDescription)
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                Alert.showBasic(title: "Bad Location", message: error!.localizedDescription)
                completion(nil)
                return
            }
            
            guard let location = placemark.location else {
                print("*** Error in \(#function): placemark is nil")
                Alert.showBasic(title: "Bad Location", message: error!.localizedDescription)
                completion(nil)
                return
            }

            print("\n\ngot this latitude \(location.coordinate.latitude) got this longitude \(location.coordinate.longitude)")
            debugPrint()
            completion(location)
        }
    }
}

class WeatherManager {
    
    static let key: String = "6bb243710117c03f9098c3b5e249c929"
    static let baseURL: String = "https://api.darksky.net/forecast/\(key)/"
    
}

class DarkSky {

    class func callWeather(location: CLLocation, completion: @escaping (_ result: URL) -> Void) {
        let lat:String = "\(location.coordinate.latitude)"
        let lon:String = "\(location.coordinate.longitude)"
        
        guard let url = URL(string: WeatherManager.baseURL   + lat + "," + lon) else {
            return
        }
        completion(url)
    }
    
    class func getForecast(url:URL, completion: @escaping (_ result: String) -> Void) {
        
        print("inside getForecast() with url \n")
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15 // seconds
        configuration.timeoutIntervalForResource = 15
        let session = URLSession(configuration: configuration)
        
        
        let task = session.dataTask(with: url as URL) {(data, response, error) in
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let weatherObject = try decoder.decode(Weather.self, from: data)
                
                DispatchQueue.main.async {
                    var theWeather:String = ""
                    for day in weatherObject.week.list {
                        let date = DatePickerUtility().convertShortDate(date: day.time)
                        let min:String = String("\(day.minTemperature)".dropLast(3))
                        let max:String = String("\(day.maxTemperature)".dropLast(3))
                       
                        var dayTemp = ("\(date)\t\(min)°-\(max)°")
                        print(dayTemp.count)
                        if dayTemp.count <= 14 {
                            dayTemp += "  "
                        }
                        let condition = Weather.convertCondition(cond: "\(day.icon)")
                        theWeather = theWeather + dayTemp + "\t" + condition + "\n"
                    }
                    completion(theWeather)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async(execute: {
                    // create text block for error
                    let errorString = "\n⚠️\n\nYour city was not found on \nDarkSky Weather"
                    
                    completion(errorString)
                })
            }

            
        }
        task.resume()
    }
}
