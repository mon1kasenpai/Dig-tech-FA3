//
//  Weather.swift
//  dig tech FA3
//
//  Created by Lachlan Forbes on 14/6/21.
//

import Foundation

class Weather:Codable, ObservableObject {
    var current: HourlyWeather
    var hours: Weather.hoursList<HourlyWeather>
    var week: Weather.list<DailyWeather>
    
    enum CodingKeys: String, CodingKey {
        case current = "currently"
        case hours = "hourly"
        case week = "daily"
    }
}

extension Weather {
    struct list <T: Codable & Identifiable>: Codable {
        var list: [T]
        
        enum CodingKeys: String, CodingKey {
            case list = "data"
        }
    }
    
    struct hoursList <T: Codable & Identifiable>: Codable {
        var list: [T]
        var summary:String
        enum CodingKeys: String, CodingKey {
            case list = "data"
            case summary = "summary"
        }
    }}
