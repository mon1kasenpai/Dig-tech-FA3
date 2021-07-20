//
//  DailyWeather.swift
//  dig tech FA3
//
//  Created by Lachlan Forbes on 14/6/21.
//

import Foundation

class DailyWeather: Codable, Identifiable, ObservableObject {
    
    var id:Date {
        return time
    }
    
    var time: Date
    var minTemperature:Double
    var maxTemperature:Double
    var icon: Weather.Icon
    var summary:String
    var humidity:Double
    var dewPoint:Double
    var pressure:Double
    var windSpeed:Double
    var precipProbability:Double
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case minTemperature = "temperatureLow"
        case maxTemperature = "temperatureHigh"
        case icon = "icon"
        case summary = "summary"
        case humidity = "humidity"
        case dewPoint = "dewPoint"
        case pressure = "pressure"
        case windSpeed = "windSpeed"
        case precipProbability = "precipProbability"
    }
}
