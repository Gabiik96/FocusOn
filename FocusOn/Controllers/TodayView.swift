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
    @FetchRequest(entity: Goal.entity(), sortDescriptors: []) var goals: FetchedResults<Goal>
    
    @State private var emptyText = ""
    
    @State private var newGoal = ""
    @State private var task1 = Task()
    @State private var task2 = ""
    @State private var task3 = ""
    
    @State private var goalSet = false
    @State private var taskSet1 = false
    @State private var taskSet2 = false
    @State private var taskSet3 = false
    
    private let timeController = TimeController()
    private let dataController = DataController()
    
    
    var body: some View {
       
        NavigationView {
        
                List {
                    Section(header: Text("Goal for the day to focus on:")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color("textColor"))
                        .frame(height: 45.0))
                    {
                    HStack {
                        if goalSet == false {
                            TextField("Set your goal..", text: self.$newGoal)
                            Button(action: {
                                
                                self.dataController.addNewGoal(title: self.newGoal)
                                
//                                let goal = Goal(context: self.moc)
//                                goal.title = self.newGoal
//                                goal.createdAt = Date()
//
                                do {
                                    try self.moc.save()
                                    print("Today goal saved")
                                } catch {
                                    print(error)
                                }
                                self.goalSet.toggle()
                            })
                            {
                                Image(systemName: "plus.circle.fill")
                            }.buttonStyle(AddButton())
                        } else {
                            Text(newGoal)
                            
                        }
                            }
                    }
                
                Section(header: Text("3 tasks to achieve your goal")){
                    VStack {
                        HStack {
                            if taskSet1 == false {
                                Image(systemName: "1.circle.fill")
                                    .imageScale(.large)
                                TextField("Define task", text: self.$emptyText)
                                Button(action: {
                                    self.task1 = Task(context: self.moc)
                                    self.task1.title = self.emptyText
                                
                                    do {
                                        try self.moc.save()
                                    } catch {
                                        print(error)
                                    }
                                    self.taskSet1.toggle()
                                })
                                {
                                    Image(systemName: "plus.circle.fill")
                                }.buttonStyle(AddButton())
                            } else {
                                Image(systemName: "1.circle.fill")
                                .imageScale(.large)
                                    
                                Text(task1.title!)
                                Button(action: {
                                    //HEREEEEE
                                    
                                })
                                {
                                    
                                    Image(systemName: "circle")
                                        .imageScale(.large)
                                }
                            }
                        }

                        }
                        HStack {
                            if taskSet2 == false {
                            Image(systemName: "2.circle.fill")
                                .imageScale(.large)
                            TextField("Define task", text: self.$task2)
                            Button(action: {
                                let task2 = Task(context: self.moc)
                                task2.title = self.task2
                                
                                do {
                                    try self.moc.save()
                                } catch {
                                    print(error)
                                }
                                self.taskSet2.toggle()
                                })
                            {
                                Image(systemName: "plus.circle.fill")
                            }.buttonStyle(AddButton())
                            } else {
                                Image(systemName: "2.circle.fill")
                                .imageScale(.large)
                                Text(task2)
                            }
                        }
                        HStack {
                            if taskSet3 == false {
                            Image(systemName: "3.circle.fill")
                                .imageScale(.large)
                            TextField("Define task", text: self.$task3)
                            Button(action: {
                                let task3 = Task(context: self.moc)
                                task3.title = self.task3
                                
                                do {
                                    try self.moc.save()
                                } catch {
                                    print(error)
                                }
                                self.taskSet3.toggle()
                                })
                            {
                                Image(systemName: "plus.circle.fill")
                            }.buttonStyle(AddButton())
                            } else {
                                Image(systemName: "3.circle.fill")
                                .imageScale(.large)
                                Text(task3)
                            }
                        }
                    }
                    
                }
            }
                .navigationBarTitle(Text("FocusOn Today"), displayMode: .automatic)
        }
    }


struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
 
    }
}
