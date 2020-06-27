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
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [NSSortDescriptor(key: #keyPath(Goal.createdAt), ascending: false)]) var goals: FetchedResults<Goal>
    
    private let timeController = TimeController()
    private var dataController = DataController()
    
    @State var allGoals: [Goal]?
    
    
    var body: some View {
        NavigationView {
            List {
                
                if goals.count != 0 {
                    ForEach(goals) { goal in
                        GoalView(goal: goal)
                    }
                } else {
                    Text("Failed to fetch goals.")
                }
            }.navigationBarTitle("FocusOn History")
        }
    
        
    }
    
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

