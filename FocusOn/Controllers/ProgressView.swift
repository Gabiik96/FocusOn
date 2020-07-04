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
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @FetchRequest( entity: Goal.entity(), sortDescriptors: [] ) var allGoals: FetchedResults<Goal>
    
    var body: some View {
        NavigationView {
            
            HistoryMenuView()
                .navigationBarTitle("FocusOn Progress")
        }
    }
}


struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
