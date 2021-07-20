//
//  WeekDay.swift
//  dig tech FA3
//
//  Created by Lachlan Forbes on 17/6/21.
//

import Foundation

func weekday(from date:Date,index:Int) -> String{
    let internalIndex = index-1 
    var weekday = ""
    var dayComponent = DateComponents()
    dayComponent.day = 1 * internalIndex
    let theCalendar = Calendar.current
    if let nextDate = theCalendar.date(byAdding: dayComponent, to: date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        weekday = dateFormatter.string(from: nextDate)
    }
    return weekday
}
