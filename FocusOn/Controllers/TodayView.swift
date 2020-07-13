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
    
    
    
    @State private var allGoals = [Goal]()
    @State private var todayGoal = Goal()

    @State private var task1 = Task()
    @State private var task2 = ""
    @State private var task3 = ""
    
    @State private var goalSet = false
    @State private var taskSet1 = false
    @State private var taskSet2 = false
    @State private var taskSet3 = false
    
    private let timeController = TimeController()
    private var dataController = DataController()
    
    var body: some View {
        NavigationView {
            if allGoals.count != 0 {
                    ForEach(allGoals) { goal in
                        TodayGoalView(todayGoal: goal)
                            .environment(\.managedObjectContext, self.moc)
                } .navigationBarTitle(Text("FocusOn Today"))
            } else {
                TodayEmptyGoalView(todayGoal: self.todayGoal)
                    .environment(\.managedObjectContext, self.moc)
                 .navigationBarTitle(Text("FocusOn Today"))
            }
        } .onAppear() { self.configure() }
    }
    
    
    func configure() {
        if allGoals.count == 0 {
            if todayFetch.count != 0 {
                for goal in todayFetch {
                    allGoals.append(goal)
                }
            }
            if allGoals.count == 0 {
                if yesterdayFetch.count != 0 {
                    for goal in yesterdayFetch {
                        if goal.complete == false {
                            allGoals.append(goal)
                        }
                    }
                }
            }
        }
        if allGoals.count == 1 {
            print("There is only one goal SUCCES!! ")
            todayGoal = allGoals[0]
        } else {
            todayGoal = dataController.createEmptyGoalWithEmptyTasks(moc: moc)
            for goal in allGoals {
                print(goal.title)
            }
            print("Created new empty goal for today !! ")
        }
    }
    
}




