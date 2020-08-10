//
//  ProgressView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 04/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData
import SwiftUICharts

struct ProgressView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    
    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [NSSortDescriptor(key: #keyPath(Goal.createdAt),
                                           ascending: true)],
        predicate: NSPredicate(format: "createdAt >= %@",
                               Calendar.current.date(byAdding: .day, value: -7, to: Date())! as NSDate)
    ) var weekGoals: FetchedResults<Goal>
    
    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [NSSortDescriptor(key: #keyPath(Goal.createdAt),
                                           ascending: true)],
        predicate: NSPredicate(format: "createdAt >= %@",
                               Calendar.current.date(byAdding: .day, value: -30, to: Date())! as NSDate)
    ) var monthGoals: FetchedResults<Goal>
    
    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [NSSortDescriptor(key: #keyPath(Goal.createdAt),
                                           ascending: true)],
        predicate: NSPredicate(format: "createdAt >= %@",
                               Calendar.current.date(byAdding: .month, value: -12, to: Date())! as NSDate)
    ) var yearGoals: FetchedResults<Goal>
    
    @State private var pickerSelected = 0
    @State private var dataPoints = [[CountData]]()
    
    let timeController = TimeController()
    
    @State var weekData = [CountData]()
    @State var monthData = [CountData]()
    @State var yearData = [CountData]()
    
    var body: some View {
        NavigationView {
            List {
                Section(header:
                    VStack() {
                        Text("Shown by")
                            .frame(height: 40)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("textColor"))
                        
                        
                        Picker(selection: $pickerSelected, label: Text("")) {
                            Text("week").tag(0)
                            Text("month").tag(1)
                            Text("year").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        
                    })
                {
                    if dataPoints.count >= 2 {
                        ScrollView(.horizontal) {
                            HStack(alignment: .center, spacing: 8) {
                                ForEach(dataPoints[pickerSelected].reversed()) { data in
                                    BarView(value: data.value, date: data.date, goal: data.goal)
                                }.padding(.top, 24)
                            }
                        }.animation(.default).transition(.move(edge: .leading))
                    }
                }
            }.navigationBarTitle("FocusOn Progress")
        }.onAppear() { self.configure() }
    }
    
    func getDataOfCompletedTasksGoals(goals: FetchedResults<Goal>, toPeriod: Int) {
        for goal in goals {
            var count = CountData(goal: goal)
            
            count.date = timeController.formattedDayToStringForChart(date: goal.createdAt)
            
            for task in goal.tasks.allObjects as! [Task] {
                if task.complete == true {
                    count.value += 40
                }
            }
            if goal.complete == true {
                count.value = 160
            }
            if toPeriod == 1 {
                self.weekData.append(count)
            } else if toPeriod == 2 {
                self.monthData.append(count)
            } else if toPeriod == 3 {
                self.yearData.append(count)
            }
            
        }
    }
    
    func configure() {
        resetData()
        
        getDataOfCompletedTasksGoals(goals: weekGoals, toPeriod: 1)
        getDataOfCompletedTasksGoals(goals: monthGoals, toPeriod: 2)
        getDataOfCompletedTasksGoals(goals: yearGoals, toPeriod: 3)
        
        self.dataPoints.append(weekData)
        self.dataPoints.append(monthData)
        self.dataPoints.append(yearData)
    }
    
    func resetData() {
        self.dataPoints.removeAll()
        self.weekData.removeAll()
        self.monthData.removeAll()
        self.yearData.removeAll()
    }
}
