//
//  TodayView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 04/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData
import UserNotifications

struct AppView: View {
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    
    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "createdAt = %@",
                               Calendar.current.startOfDay(for: Date()) as NSDate)
    ) var todayFetch: FetchedResults<Goal>
    
    private let timeController = TimeController()
    
    let demo = DemoData(moc: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext )
    
    var body: some View {
        TabView {
            ProgressView()
                .tabItem {
                    Image(systemName: "checkmark.rectangle")
                    Text("Progress")
                    
            }
            
            TodayView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Today")
            }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "calendar.circle")
                    Text("History")
            }
            
        }
        .onAppear() {
            self.requestNotificationsAuth()
//            self.demo.populateDemoData()
        }
            .accentColor(.textColor)
    }
    
    /// Ask user for permission to show notifications, if granted notifications will be created
    func requestNotificationsAuth() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.createNotification()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Create notification with specified content inside this func, notifications are dependent on coreData fetch with today date
    func createNotification() {
        // remove all existing notifications
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let goal = self.todayFetch.first
        
        if goal != nil && goal?.complete == false {
            
            var uncompleteTasks = [Task]()
            
            for task in goal?.tasks.allObjects as! [Task] {
                if task.complete == false {
                    uncompleteTasks.append(task)
                }
            }
            
            var body: String
            if uncompleteTasks.count == 1 {
                body = "\(uncompleteTasks.count) task to go"
            } else {
                body = "\(uncompleteTasks.count) tasks to go"
            }
            notificationBase(title: "Keep going !", subtitle: "\(goal!.title)", body: body, once: false)
            
        } else {
            notificationBase(title: "Good morning !", body: "It's time to set your goal for today.", once: true)
        }
    }
    
    /// Use input to create notification by date interval  if once is true, otherwise by time interval
    func notificationBase(title: String, subtitle: String? = "", body: String, once: Bool) {
        // make notification content
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle ?? " "
        content.body = body
        content.sound = UNNotificationSound.default
        
        var trigger: UNNotificationTrigger
        
        if once == true {
            // show this notification at corresponding date
            trigger = UNCalendarNotificationTrigger(dateMatching: self.timeController.notificationDate(), repeats: true)
            print("Notification created for date")
        } else {
            // show this notification in timeInterval from now
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            print("Notification created for time")
        }
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
}





