//
//  TodayView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 04/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData

struct AppView: View {
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @FetchRequest( entity: Goal.entity(), sortDescriptors: [] ) var allGoals: FetchedResults<Goal>
    
    var body: some View {
        TabView {
            ProgressView()
                .tabItem {
                    Image(systemName: "checkmark.rectangle")
                    Text("Progress")
                    
            }
            
            TodayView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Today")
            }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "calendar.circle")
                    Text("History")
            }
            
        }
        .accentColor(.textColor)
    }
}





