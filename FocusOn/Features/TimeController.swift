//
//  TimeController.swift
//  FocusOn
//
//  Created by Gabriel Balta on 17/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import Foundation

struct TimeController {
    
    let calendar = Calendar.current
    
    // Computed properties for specific period of time
    var today: Date {
        return getDay(date: Date())
    }
    
    var yesterday: Date {
        return getDay(date: Calendar.current.date(byAdding: .day, value: -1, to: today)!)
    }
    
    var lastWeek: Date {
        return getDay(date: Calendar.current.date(byAdding: .day, value: -7, to: today)!)
    }
    
    var lastMonth: Date {
        return getDay(date: Calendar.current.date(byAdding: .day, value: -30, to: today)!)
    }
    
    var twoMonthsAgo: Date {
        return getDay(date: Calendar.current.date(byAdding: .day, value: -60, to: today)!)
    }
    
    func startOfWeek(date: Date) -> Date {

        return self.calendar.date(from: calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date()))!
    }
    
    func startOfMonth(for date: Date) -> Date {
        
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!

        return startOfMonth
    }
    
    // Functions to formate
    func getDay(date: Date) -> Date {
        return self.calendar.startOfDay(for: date)
    }
    
    
    func formattedDayToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d yyyy"
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
    
    func formattedDayToStringForChart(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
    
    func formattedMonthToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL yyyy"
        let nameOfMonth = dateFormatter.string(from: date)
        
        return nameOfMonth
    }
    
    func formattedYearToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let nameOfMonth = dateFormatter.string(from: date)
        
        return nameOfMonth
    }
    
    func notificationDate() -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.hour = 7
        dateComponents.minute = 59
        
        return dateComponents
    }
    
}
