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
    
    
    
    private let timeController = TimeController()
    private var dataController = DataController()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(allGoals) { goal in
                    HistoryBlockView(goal: goal)
                }.onDelete(perform: removeGoal)
            }.navigationBarTitle("FocusOn History")
        }
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
}



struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

