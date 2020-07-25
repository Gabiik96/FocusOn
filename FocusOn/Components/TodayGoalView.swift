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
    
    // validation state for title of goal field
    @State var goalTitleValid = FieldChecker()
    
    let dataController = DataController()
    var numberImages = ["1.circle", "2.circle", "3.circle"]
    
    var body: some View {
        List {
            Section(header: Text("Goal for the day to focus on:")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color("textColor"))
                .frame(height: 45.0))
            {
                HStack {
                    TextFieldWithValidator(title: "Set your goal..", value: self.$todayGoal.title, checker: $goalTitleValid) { v in
                        // validation closure where ‘v’ is the current value
                        if( v.isEmpty ) {
                            return "Goal cannot be empty"
                        } else {
                            return nil
                        }
                    }
                        .onReceive(self.todayGoal.objectWillChange, perform: { self.dataController.saveMoc(moc: self.moc) })
                        .font(.system(size: 25))
                    Button(action: {
                        self.todayGoal.complete = (self.todayGoal.complete ? false : true)
                        for task in self.todayGoal.tasks.allObjects as! [Task] {
                            if self.todayGoal.complete == true {
                                
                                task.complete = true
                            }
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
                    TodayTaskView(task: self.todayGoal.tasks.allObjects[task] as! Task, goal: self.todayGoal, image: self.numberImages[task])
                }
            }
        }
    }
}

struct TodayEmptyGoalView: View {
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    
    let dataController = DataController()
    
    @State private var todayGoal: Goal?
    @State private var title = ""
    
    var body: some View {
        List {
            Section(header: Text("Goal for the day to focus on:")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color("textColor"))
                .frame(height: 45.0))
            {
                HStack {
                    TextField("Set your goal..", text: self.$title)
                        .font(.system(size: 25))
                    Button(action: {
                        self.todayGoal = self.dataController.createEmptyGoalWithEmptyTasks(moc: self.moc)
                        if self.todayGoal != nil {
                            self.todayGoal!.title = self.title
                            self.dataController.updateGoal(
                                goal: self.todayGoal!,
                                newTitle: self.todayGoal!.title,
                                moc: self.moc
                            )
                        }
                    })
                    {
                        Image(systemName: "plus.circle.fill")
                    }.buttonStyle(AddButton())
                }
            }
            Section(header: Text("3 tasks to achieve your goal"))
            {
                Text("To access tasks, please set up your goal.")
            }
        }
    }
}


struct TodayTaskView: View {
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @ObservedObject var task: Task
    @ObservedObject var goal: Goal
    
    let dataController = DataController()
    fileprivate var image: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(Color.divColor)
            TextField("Define task", text: self.$task.title)
                .onReceive(self.task.objectWillChange, perform: { self.dataController.saveMoc(moc: self.moc) })
            if task.title == "" {
                Button(action: {
                    self.btnPressed()
                })
                {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }.buttonStyle(AddButton())
                    .frame(width: 25.0, height: 25.0)
            } else {
                Button(action: {
                    self.btnPressed()
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
    
    func btnPressed() {
        var countToThree = 0
        if self.task.complete == true && self.goal.complete == true {
            self.goal.complete.toggle()
            self.task.complete.toggle()
        } else {
            self.task.complete.toggle()
        }
        self.dataController.updateTask(task: self.task, newTitle: self.task.title, completed: self.task.complete, moc: self.moc)
        for task in self.goal.tasks {
            if (task as AnyObject).complete == true { countToThree += 1 }
            if countToThree == 3 { self.goal.complete = true }
        }
    }
}

