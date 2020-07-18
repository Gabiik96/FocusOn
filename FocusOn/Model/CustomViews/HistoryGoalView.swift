//
//  GoalView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 26/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData

struct HistoryBlockView: View {
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    
    let timeController = TimeController()
    let dateFormatter = DateFormatter()
    
    @State var goal: Goal
    var tasks: [Task] {
        goal.tasks.allObjects as! [Task]
    }
    
    
    
    var body: some View {
        
        Section(header: Text(timeController.formattedDayToString(date: goal.createdAt))) {
            VStack {
                HistoryPartOfBlockView(goal: goal)
                
                ForEach(tasks) { task in
                    HStack {
                        Text(task.title)
                            .font(.system(size: 20))
                            .fontWeight(.regular)
                            .minimumScaleFactor(0.01)
                            .frame(height: 30.0)
                        Spacer()
                        Button(action: { })
                        {
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

}

struct HistoryPartOfBlockView: View {
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(key: #keyPath(Goal.createdAt), ascending: false)]) var goals: FetchedResults<Goal>
    
    @State var goal: Goal
    
    var body: some View {
        HStack() {
            Text(goal.title)
                .font(.system(size: 30))
                .fontWeight(.medium)
                .frame(height: 30.0)
            
            Spacer()
            Button(action: { })
            {
                Image(systemName: (goal.complete ? "checkmark.circle.fill" : "multiply.circle"))
                    .resizable()
                    .frame(width: 40.0, height: 40.0)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(goal.complete ? .green : .red)
            }
        }
    }
}
