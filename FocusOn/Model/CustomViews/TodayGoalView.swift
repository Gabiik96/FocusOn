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
    @ObservedObject var todayGoal: Goal
    
    let dataController = DataController()
    var numberImages = ["1.circle.fill", "2.circle.fill", "3.circle.fill"]
    
    var body: some View {
        List {
            Section(header: Text("Goal for the day to focus on:")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color("textColor"))
                .frame(height: 45.0))
            {
                HStack {
                    TextField("Set your goal..", text: self.$todayGoal.title)
                        .font(.system(size: 25))
                    Button(action: {
                        self.todayGoal.complete = (self.todayGoal.complete ? false : true)
                        for task in self.todayGoal.tasks.allObjects as! [Task] {
                            if self.todayGoal.complete == true { task.complete = true }
                            else { task.complete = false }
                        }
                        self.dataController.updateGoal(
                            goal: self.todayGoal,
                            newTitle: self.todayGoal.title,
                            moc: self.moc
                        )
                    })
                    {
                        Image(systemName: (todayGoal.complete ? "checkmark.circle.fill" : "multiply.circle"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(todayGoal.complete ? .green : .red)
                    }.buttonStyle(CompletionGoal())
                }
            }
            Section(header: Text("3 tasks to achieve your goal"))
            {
                ForEach(0..<todayGoal.tasks.allObjects.count) { task in
                    TodayTaskView(task: self.todayGoal.tasks.allObjects[task] as! Task, image: self.numberImages[task])
                }
            }
        }
    }
}

struct TodayEmptyGoalView: View {
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @State var todayGoal: Goal
    
    let dataController = DataController()
    let timeController = TimeController()
    var numberImages = ["1.circle.fill", "2.circle.fill", "3.circle.fill"]
    
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
                            .font(.system(size: 25))
                        Button(action: {
                            self.todayGoal =  self.dataController.createEmptyGoalWithEmptyTasks(moc: self.moc)
                            self.dataController.updateGoal(
                                goal: self.todayGoal,
                                newTitle: self.title,
                                newDate: self.timeController.today,
                                completed: false,
                                moc: self.moc
                            )
                            self.goalSet.toggle()
                        })
                        {
                            Image(systemName: "plus.circle.fill")
                        }.buttonStyle(AddButton())
                    } else {
                        TextField("Set your goal..", text: self.$title)
                        Button(action: {
                            self.todayGoal.complete = (self.todayGoal.complete ? false : true)
                            self.dataController.updateGoal(
                                goal: self.todayGoal,
                                newTitle: self.title,
                                newDate: self.timeController.today,
                                completed: false,
                                moc: self.moc
                            )
                        })
                        {
                            Image(systemName: (todayGoal.complete ? "checkmark.circle.fill" : "multiply.circle"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(todayGoal.complete ? .green : .red)
                        }.buttonStyle(CompletionGoal())
                    }
                }
            }
            Section(header: Text("3 tasks to achieve your goal"))
            {
                VStack {
                    if goalSet == false {
                        Text("To access tasks, please set up your goal.")
                    } else {
                        ForEach(0..<todayGoal.tasks.allObjects.count) { task in
                            TodayTaskView(task: self.todayGoal.tasks.allObjects[task] as! Task, image: self.numberImages[task])
                        }
                    }
                    
                }
            }
        }
    }
}


struct TodayTaskView: View {
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @ObservedObject var task: Task
    
    let dataController = DataController()
    fileprivate var image: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .imageScale(.large)
            TextField("Define task", text: self.$task.title)
            
            if task.title == "" {
                Button(action: {
                    if self.task.complete == false {
                        self.dataController.updateTask(task: self.task, completed: true, moc: self.moc)
                        self.task.complete.toggle()
                    } else {
                        self.dataController.updateTask(task: self.task, completed: true, moc: self.moc)
                        self.task.complete.toggle()
                    }
                })
                {
                    Image(systemName: "plus.circle.fill")
                }.buttonStyle(AddButton())
            } else {
                Button(action: {
                    self.task.complete = (self.task.complete ? false : true)
                    self.dataController.updateTask(task: self.task, newTitle: self.task.title, completed: self.task.complete, moc: self.moc)
                })
                {
                    Image(systemName: (task.complete ? "checkmark.circle.fill" : "multiply.circle"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(task.complete ? .green : .red)
                }.buttonStyle(CompletionTask())
            }
        }
    }
}

