//
//  HistoryView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 04/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [NSSortDescriptor(key: #keyPath(Goal.createdAt),
                                           ascending: false)]
    ) var allGoals: FetchedResults<Goal>
    
    @State private var goals = [Goal]()
    @State var monthsUsed = [Goal]()
    @State var goalsSeparatedByMonth = [monthGoals]()
    
    @State private var currentYear = ""
    private var allMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    private let timeController = TimeController()
    private var dataController = DataController()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(goalsSeparatedByMonth) { monthWithGoals in
                    if monthWithGoals.goals != nil {
                        HistoryMonthView(monthWithGoals: monthWithGoals)
                    }
                }.navigationBarTitle(Text("FocusOn History"))
            }
        }.onAppear() { self.configure() }
    }
    
    func removeGoal(at offsets: IndexSet) {
        for index in offsets {
            let goal = allGoals[index]
            moc.delete(goal)
            do {
                try moc.save()
                print("Deleted Goal")
            } catch {
                print("Failed to save context. \(error)")
            }
        }
    }
    
    func configure() {
        
        self.currentYear = self.timeController.formattedYearToString(date: self.timeController.today)
        self.goalsSeparatedByMonth.removeAll()
        
        for goal in allGoals {
            self.goals.append(goal)
        }
        
        while self.goals.count != 0 {
            
            for month in self.allMonths {
                var object = monthGoals(id: UUID(), month: month, year: self.currentYear)
                object.goals = allGoals.filter ({ $0.month == "\(month) \(self.currentYear)" })
                
                self.goalsSeparatedByMonth.append(object)
                
                if object.goals?.count != 0 {
                    for goal in object.goals! {
                        let index = goals.firstIndex(where: { $0 === goal })
                        self.goals.remove(at: index!)
                    }
                }
            }
            self.currentYear = String((Int(self.currentYear)! - 1 ))
        }
        
        removeEmptyMonths(goalsSeparatedByMonth: self.goalsSeparatedByMonth)
    }
    
    func removeEmptyMonths(goalsSeparatedByMonth: [monthGoals]) {
        for monthWithGoals in goalsSeparatedByMonth {
            if monthWithGoals.goals?.count == 0 {
                self.goalsSeparatedByMonth.removeAll(where: { $0 == monthWithGoals })
            }
        }
    }
    
}



struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

