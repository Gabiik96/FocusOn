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
    
    let timePeriods = ["week", "month", "year"]
    
    
    var body: some View {
        NavigationView {
            List(timePeriods, id: \.self) { period in
                VStack {
                    NavigationLink(destination: ProgressDetailView(timePeriod: period)) {
                        RectangleBtnView(title: period)
                    }
                }
            }.navigationBarTitle("FocusOn Progress")
        }
    }
}
