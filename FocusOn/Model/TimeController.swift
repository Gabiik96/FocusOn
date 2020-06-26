//
//  TimeController.swift
//  FocusOn
//
//  Created by Gabriel Balta on 17/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import Foundation

class TimeController {
    
    // Computed properties for specific period of time
    var today: Date {
        return getDay(date: Date())
    }
    
    var yesterday: Date {
        return getDay(date: Calendar.current.date(byAdding: .day, value: -1, to: today)!)
    }
    
    
    // Functions to formate
    func getDay(date: Date) -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return calendar.startOfDay(for: date)
    }
    
}
