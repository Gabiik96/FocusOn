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
    
    @State var taskCelebrate = false
    @State var goalCelebrate = false
    
    private let dataController = DataController()
    
    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    if todayFetch.count != 0 {
                        TodayGoalView(
                            todayGoal: todayFetch.first!,
                            taskCelebrate: self.$taskCelebrate,
                            goalCelebrate: self.$goalCelebrate
                        )
                            .environment(\.managedObjectContext, self.moc)
                    } else if yesterdayFetch.count != 0 {
                        TodayGoalView(
                            todayGoal: yesterdayFetch.first!,
                            taskCelebrate: self.$taskCelebrate,
                            goalCelebrate: self.$goalCelebrate
                        )
                            .environment(\.managedObjectContext, self.moc)
                    } else {
                        TodayEmptyGoalView()
                            .environment(\.managedObjectContext, self.moc)
                    }
                }.navigationBarTitle(Text("FocusOn Today"))
                
                if goalCelebrate == true {
                    GoalCelebrationView(textIsHidden: true)
                        
                }
                if taskCelebrate == true {
                    TaskCelebrationView()
                        .position(x: (UIScreen.screenWidth / 2), y: (UIScreen.screenHeight / 2))
                        .transition(.scale)
                }
            }
        }
    }
    
}




