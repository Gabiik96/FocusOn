//
//  TodayView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 04/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData
struct TodayView: View {
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @FetchRequest(entity: Goal.entity(), sortDescriptors: []) var goals: FetchedResults<Goal>
    
    @State private var newGoal = ""
    @State private var task1 = ""
    @State private var task2 = ""
    @State private var task3 = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Goal for the day to focus on:")){
                    HStack {
                        TextField("Set your goal..", text: self.$newGoal)
                        Button(action: {
                            let goal = Goal(context: self.moc)
                            goal.title = self.newGoal
                            goal.createdAt = Date()
                            
                            do {
                                try self.moc.save()
                            } catch {
                                print(error)
                            }
                            })
                        
                        {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    }
                }.font(.headline)
                
                Section(header: Text("3 tasks to achieve your goal")){
                    VStack{
                        HStack {
                            TextField("1️⃣ Define task", text: self.$task1)
                        }
                        HStack {
                            TextField("2️⃣ Define task", text: self.$task2)
                        }
                        HStack {
                            TextField("3️⃣ Define task", text: self.$task3)
                        }
                    }
                }
            }
                        
            .navigationBarTitle(Text("FocusOn Today"), displayMode: .inline)
            
       
        

        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
