//
//  DarkSky Objects.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 11/30/19.
//  Copyright © 2019 Warren Hansen. All rights reserved.
//

import Foundation


struct DailyWeather: Codable, Identifiable {
    
    var id: Date {
        return time
    }
    
    var time: Date
    var maxTemperature: Double
    var minTemperature: Double
    var icon: Weather.Icon
    
    enum CodingKeys: String, CodingKey {
        
        case time = "time"
        case maxTemperature = "temperatureHigh"
        case minTemperature = "temperatureLow"
        case icon = "icon"
        
    }
    
}

struct HourlyWeather: Codable, Identifiable {
    
    var id: Date {
        return time
    }
    
    var time: Date
    var temperature: Double
    var icon: Weather.Icon
    
}

struct Weather: Codable {
    
    var current: HourlyWeather
    var hours: Weather.List<HourlyWeather>
    var week: Weather.List<DailyWeather>
    
    enum CodingKeys: String, CodingKey {
        
        case current = "currently"
        case hours = "hourly"
        case week = "daily"
        
    }
    
}

extension Weather {
    
    struct List<T: Codable & Identifiable>: Codable {
        
        var list: [T]
        
        enum CodingKeys: String, CodingKey {
            case list = "data"
        }
    }
}


extension Weather {
    
    enum Icon: String, Codable {
        
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case rain = "rain"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        case partyCloudyDay = "partly-cloudy-day"
        case partyCloudyNight = "partly-cloudy-night"
    }
    
    static func convertCondition(cond:String)-> String {
        switch cond {
        case "clearNight":
            return "clear night"
        case "rain":
            return "rain"
        case "snow":
            return "snow"
        case "sleet":
            return "sleet"
        case "wind":
            return "wind"
        case "fog":
            return "fog"
        case "cloudy":
           return "cloudy"
       case "partyCloudyDay":
           return "party cloudy day"
       case "partyCloudyNight":
           return "party cloudy night"
            
        default:
            return "clear"
        }
    }
    
}

