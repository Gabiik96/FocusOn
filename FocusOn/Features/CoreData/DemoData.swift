//
//  DemoData.swift
//  FocusOn
//
//  Created by Gabriel Balta on 27/07/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData

class DemoData {
    var moc: NSManagedObjectContext
    
    private var timeController = TimeController()
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func populateDemoData() {
        
        
        // Goal 1  (Yesterday)
        let goal1 = Goal(context: moc)
        goal1.createdAt = timeController.yesterday
        goal1.title = "Prepare car"
        goal1.complete = false
        goal1.month = self.timeController.formattedMonthToString(date: Date())
        
        let task1goal1 = Task(context: moc)
        task1goal1.title = "Vaccum interior"
        task1goal1.complete = true
        task1goal1.goal = goal1
        
        let task2goal1 = Task(context: moc)
        task2goal1.title = "Clean the wheels"
        task2goal1.complete = true
        task2goal1.goal = goal1
        
        let task3goal1 = Task(context: moc)
        task3goal1.title = "Wash it !"
        task3goal1.complete = false
        task3goal1.goal = goal1
        
        // Goal 2,3 (This week)
        let goal2 = Goal(context: moc)
        goal2.createdAt = timeController.getDay(date: Calendar.current.date(byAdding: .day, value: -3, to: timeController.today)!)
        goal2.title = "Cook soup"
        goal2.complete = false
        goal2.month = self.timeController.formattedMonthToString(date: timeController.getDay(date: Calendar.current.date(byAdding: .day, value: -3, to: timeController.today)!))
        
        let task1goal2 = Task(context: moc)
        task1goal2.title = "Look for receipt"
        task1goal2.complete = true
        task1goal2.goal = goal2
        
        let task2goal2 = Task(context: moc)
        task2goal2.title = "Buy ingredients"
        task2goal2.complete = true
        task2goal2.goal = goal2
        
        let task3goal2 = Task(context: moc)
        task3goal2.title = "Cook it !"
        task3goal2.complete = false
        task3goal2.goal = goal2
        
        let goal3 = Goal(context: moc)
        goal3.createdAt = timeController.getDay(date: Calendar.current.date(byAdding: .day, value: -5, to: timeController.today)!)
        goal3.title = "Plan holiday"
        goal3.complete = false
        goal3.month = self.timeController.formattedMonthToString(date: timeController.getDay(date: Calendar.current.date(byAdding: .day, value: -5, to: timeController.today)!))
        
        
        let task1goal3 = Task(context: moc)
        task1goal3.title = "Pick a date"
        task1goal3.complete = true
        task1goal3.goal = goal3
        
        let task2goal3 = Task(context: moc)
        task2goal3.title = "Book holiday"
        task2goal3.complete = false
        task2goal3.goal = goal3
        
        let task3goal3 = Task(context: moc)
        task3goal3.title = "Find a deal"
        task3goal3.complete = true
        task3goal3.goal = goal3
        
        // Goal 4,5,6 (This month)
        let goal4 = Goal(context: moc)
        goal4.createdAt = timeController.getDay(date: Calendar.current.date(byAdding: .day, value: -10, to: timeController.today)!)
        goal4.title = "Clean house"
        goal4.complete = true
        goal4.month = self.timeController.formattedMonthToString(date: timeController.getDay(date: Calendar.current.date(byAdding: .day, value: -10, to: timeController.today)!))
        
        let task1goal4 = Task(context: moc)
        task1goal4.title = "Living room"
        task1goal4.complete = true
        task1goal4.goal = goal4
        
        let task2goal4 = Task(context: moc)
        task2goal4.title = "Bathroom"
        task2goal4.complete = true
        task2goal4.goal = goal4
        
        let task3goal4 = Task(context: moc)
        task3goal4.title = "Kitchen"
        task3goal4.complete = true
        task3goal4.goal = goal4
        
        let goal5 = Goal(context: moc)
        goal5.createdAt = timeController.getDay(date: Calendar.current.date(byAdding: .day, value: -15, to: timeController.today)!)
        goal5.title = "Paint"
        goal5.complete = false
        goal5.month = self.timeController.formattedMonthToString(date: timeController.getDay(date: Calendar.current.date(byAdding: .day, value: -15, to: timeController.today)!))
        
        let task1goal5 = Task(context: moc)
        task1goal5.title = "Buy paint"
        task1goal5.complete = true
        task1goal5.goal = goal5
        
        let task2goal5 = Task(context: moc)
        task2goal5.title = "Buy brushes"
        task2goal5.complete = true
        task2goal5.goal = goal5
        
        let task3goal5 = Task(context: moc)
        task3goal5.title = "Cover furniture"
        task3goal5.complete = true
        task3goal5.goal = goal5
        
        let goal6 = Goal(context: moc)
        goal6.createdAt = timeController.getDay(date: Calendar.current.date(byAdding: .day, value: -27, to: timeController.today)!)
        goal6.title = "Do project"
        goal6.complete = false
        goal6.month = self.timeController.formattedMonthToString(date: timeController.getDay(date: Calendar.current.date(byAdding: .day, value: -27, to: timeController.today)!))
        
        let task1goal6 = Task(context: moc)
        task1goal6.title = "Finish TodayView"
        task1goal6.complete = true
        task1goal6.goal = goal6
        
        let task2goal6 = Task(context: moc)
        task2goal6.title = "Finish HistoryView"
        task2goal6.complete = true
        task2goal6.goal = goal6
        
        let task3goal6 = Task(context: moc)
        task3goal6.title = "Finish ProgressView"
        task3goal6.complete = false
        task3goal6.goal = goal6
        
        do {
            try moc.save()
        } catch {
            print("Failed to save managed context. \(error)")
            moc.rollback()
        }
        
    }
    
}

