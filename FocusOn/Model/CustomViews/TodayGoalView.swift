//
//  TodayGoalFilteredView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 30/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import CoreData
import SwiftUI

struct TodayGoalView: View {
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @State var refreshing = false
    var didSave =  NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)

    let dataController = DataController()
    
    @ObservedObject var todayGoal: Goal
    
    var body: some View {
        List {
            Section(header: Text("Goal for the day to focus on:")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color("textColor"))
                .frame(height: 45.0))
            {
                HStack {
                    TextField("Set your goal..", text: self.$todayGoal.title)
                    Button(action: {
                        self.todayGoal.complete = (self.todayGoal.complete ? false : true)
                        self.dataController.updateDeleteGoal(
                            goalID: self.todayGoal.goalID,
                            newTitle: self.todayGoal.title,
                            moc: self.moc
                        )
                    })
                    {
                        Image(systemName: (todayGoal.complete ? "checkmark.circle.fill" : "multiply.circle"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(todayGoal.complete ? .green : .red)
                    }.buttonStyle(CompletionBtn())
                    .onReceive(self.didSave) { _ in self.refreshing.toggle() }
                }
            }
            Section(header: Text("3 tasks to achieve your goal"))
            {
                ForEach(todayGoal.tasks.allObjects as! [Task]) { task in
                    TodayTaskView(task: task, goalID: self.todayGoal.goalID)
                    
                    
                }
            }
        }
    }
}

struct TodayEmptyGoalView: View {
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @State var refreshing = false
    var didSave =  NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)

    let dataController = DataController()
    let timeController = TimeController()
    
    @ObservedObject var todayGoal: Goal
    @State private var title = ""
    @State private var goalSet = false
    
    var body: some View {
        List {
            Section(header: Text("Goal for the day to focus on:")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color("textColor"))
                .frame(height: 45.0))
            {
                HStack {
                    if goalSet == false {
                        TextField("Set your goal..", text: self.$title)
                        Button(action: {
                            self.dataController.updateDeleteGoal(
                                goalID: self.todayGoal.goalID,
                                newTitle: self.title,
                                newDate: self.timeController.today,
                                complete: false,
                                moc: self.moc
                            )
                            
                            self.goalSet.toggle()
                        })
                        {
                            Image(systemName: "plus.circle.fill")
                        }.buttonStyle(AddButton())
                        // here is the listener for published context event
                        .onReceive(self.didSave) { _ in self.refreshing.toggle() }
                    } else {
                        TextField("Set your goal..", text: self.$title)
                        Button(action: {
                            self.dataController.updateDeleteGoal(
                                goalID: self.todayGoal.goalID,
                                newTitle: self.title,
                                newDate: self.timeController.today,
                                complete: false,
                                moc: self.moc
                            )
                            self.todayGoal.complete = (self.todayGoal.complete ? false : true)
                            self.dataController.updateDeleteGoal(
                                goalID: self.todayGoal.goalID,
                                newTitle: self.todayGoal.title,
                                moc: self.moc
                            )
                        })
                        {
                            Image(systemName: (todayGoal.complete ? "checkmark.circle.fill" : "multiply.circle"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(todayGoal.complete ? .green : .red)
                        }.buttonStyle(CompletionBtn())
                        .onReceive(self.didSave) { _ in self.refreshing.toggle() }
                    }
                }
            }
                Section(header: Text("3 tasks to achieve your goal"))
                {
                    VStack {
                if goalSet == false {
                    Text("To access tasks, please set up your goal.")
                } else {
                        ForEach(todayGoal.tasks.allObjects as! [Task]) { task in
                            TodayTaskView(task: task, goalID: self.todayGoal.goalID)
                            
                        }
                    }
                
                }
            }
        }
    }
}


struct TodayTaskView: View {
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    
    let dataController = DataController()
    
    @State var task: Task
    let goalID: UUID
    
    var body: some View {
        HStack {
            Image(systemName: "1.circle.fill")
                .imageScale(.large)
            TextField("Define task", text: self.$task.title)
            Button(action: {
                if self.task.complete == false {
                    self.dataController.updateOrDeleteTask(taskID: self.task.taskID, goalID: self.goalID, completed: true)
                    self.task.complete.toggle()
                } else {
                    self.dataController.updateOrDeleteTask(taskID: self.task.taskID, goalID: self.goalID, completed: false)
                    self.task.complete.toggle()
                }
            })
            {
                Image(systemName: "plus.circle.fill")
            }.buttonStyle(AddButton())
        }
    }
    
    
}

