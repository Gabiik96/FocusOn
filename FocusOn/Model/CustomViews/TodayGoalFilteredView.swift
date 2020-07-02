//
//  TodayGoalFilteredView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 30/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import CoreData
import SwiftUI

struct TodayGoalFilteredView: View {
    
    var fetchRequest: FetchRequest<Goal>
    var allGoals: FetchedResults<Goal> {
        fetchRequest.wrappedValue
    }
    var filteredGoals: [Goal]?
    var todayGoal: Goal?x
    @State var goalTitle = " "
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("Goal for the day to focus on:")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("textColor"))
                    .frame(height: 45.0))
                {
                    HStack {
                        TextField("Set your goal..", text: self.$goalTitle)
                        Button(action: {
                            self.todayGoal?.complete = (self.todayGoal!.complete ? false : true)
                        })
                        {
                            Image(systemName: (todayGoal!.complete ? "checkmark.circle.fill" : "multiply.circle"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(todayGoal!.complete ? .green : .red)
                        }.buttonStyle(GoalCompletionBtn())

                    }
                    
                }
            }
        }
    }
    
    init(_ timeController :TimeController, _ dataController: DataController) {
        fetchRequest = FetchRequest<Goal>(entity: Goal.entity(), sortDescriptors: [], predicate: NSPredicate(format: "createdAt = %@",timeController.getDay(date: timeController.today) as NSDate))
        
        configure(dataController)
        
    }
    
    mutating func configure(_ dataController: DataController) {
        self.filteredGoals = dataController.filterTodayGoal(allGoals: self.allGoals) ?? nil

        if self.filteredGoals != nil {
            todayGoal = filteredGoals!.first
            goalTitle = todayGoal!.title
        }
    }
}
