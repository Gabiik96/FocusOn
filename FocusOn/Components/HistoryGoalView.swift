//
//  GoalView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 26/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData

struct monthGoals: Identifiable, Equatable {
    var id: UUID
    
    var month: String
    var year: String
    var goals: [Goal]?
}

struct HistoryGoalWithTasksView: View {
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    
    let timeController = TimeController()
    let dateFormatter = DateFormatter()
    
    @State var goal: Goal
    var tasks: [Task] {
        goal.tasks.allObjects as! [Task]
    }
    
    
    
    var body: some View {
        VStack{
            if goal.createdAt == timeController.today {
                LabelledDivider(label: "Today")
            } else if goal.createdAt == timeController.yesterday {
                LabelledDivider(label: "Yesterday")
            } else {
                LabelledDivider(label: timeController.formattedDayToString(date: goal.createdAt))
            }
            
            HistoryGoalPartView(goal: goal)
            
            ForEach(tasks) { task in
                HStack {
                    if task.title != "" {
                        Text(task.title)
                            .font(.system(size: 20))
                            .fontWeight(.regular)
                            .minimumScaleFactor(0.01)
                            .frame(height: 30.0)
                        Spacer()
                        Image(systemName: (task.complete ? "checkmark.circle.fill" : "multiply.circle"))
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(task.complete ? .green : .red)
                    }
                }
            }
        }
    }
}

struct HistoryGoalPartView: View {
    
    @State var goal: Goal
    
    var body: some View {
        HStack() {
            Text(goal.title)
                .font(.system(size: 30))
                .fontWeight(.medium)
                .frame(height: 30.0)
            Spacer()
            Image(systemName: (goal.complete ? "checkmark.circle.fill" : "multiply.circle"))
                .resizable()
                .frame(width: 40.0, height: 40.0)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(goal.complete ? .green : .red)
        }
    }
}

struct HistoryMonthView: View {
    
    @State var monthWithGoals: monthGoals
    @State var completedGoalsCount = [Goal]()
    @State var allGoalsCount = 0
    
    var body: some View {
        
        Section(header: VStack() {
            Text(monthWithGoals.month + " " + monthWithGoals.year)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color("textColor"))
                .frame(maxWidth: .infinity,alignment: .center)
            if allGoalsCount == 1 {
                Text("\(completedGoalsCount.count) out of \(allGoalsCount) goal completed")
                    .font(.system(size: 15, weight: .medium))
                
            } else {
                Text("\(completedGoalsCount.count) out of \(allGoalsCount) goals completed")
                    .font(.system(size: 15, weight: .medium))
            }
        }
        .frame(height: 50))
        {
            ForEach(monthWithGoals.goals!, id: \.id) { goal in
                HistoryGoalWithTasksView(goal: goal)
            }
        } .onAppear() { self.configure() }
    }
    
    
    func configure() {
        if monthWithGoals.goals != nil {
            for goal in monthWithGoals.goals! {
                if goal.title == "" {
                    monthWithGoals.goals!.removeAll(where: { $0 == goal })
                }
            }
            
            completedGoalsCount = monthWithGoals.goals!.filter ({ $0.complete == true })
            allGoalsCount = monthWithGoals.goals!.count
        }
    }
    
}


