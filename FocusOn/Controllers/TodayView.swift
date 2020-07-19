//
//  TodayView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 04/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

struct TodayView: View {
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "createdAt = %@",
                               Calendar.current.startOfDay(for: Date()) as NSDate)
    ) var todayFetch: FetchedResults<Goal>
    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "createdAt = %@",
                               Calendar.current.date(
                                byAdding: .day,
                                value: -1,
                                to: Calendar.current.startOfDay(for: Date())
                                )! as NSDate)
    ) var yesterdayFetch: FetchedResults<Goal>
    
    private let dataController = DataController()
    
    var body: some View {
        NavigationView {
            Group {
                if todayFetch.count != 0 {
                    TodayGoalView(todayGoal: todayFetch.first!)
                        .environment(\.managedObjectContext, self.moc)
                } else if yesterdayFetch.count != 0 {
                    TodayGoalView(todayGoal: yesterdayFetch.first!)
                        .environment(\.managedObjectContext, self.moc)
                } else {
                    TodayEmptyGoalView(todayGoal: dataController.createEmptyGoalWithEmptyTasks(moc: moc))
                        .environment(\.managedObjectContext, self.moc)
                }
            }.navigationBarTitle(Text("FocusOn Today"))
        }
    }
    
}




