//
//  SwiftUIView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 03/07/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData
import SwiftUICharts


struct ProgressMenuView: View {
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @FetchRequest( entity: Goal.entity(), sortDescriptors: [] ) var allGoals: FetchedResults<Goal>
    
    let timePeriods = ["week", "month", "year"]
    
    
    var body: some View {
        List {
            VStack {
                ForEach(timePeriods, id: \.self) { period in
                    RectangleBtnView(title: period)
                    
                }
            }
        }
    }
}



struct RectangleBtnView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @FetchRequest( entity: Goal.entity(), sortDescriptors: [] ) var allGoals: FetchedResults<Goal>
    
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(self.colorScheme == .dark ? Color.black : Color.white)
                .frame(width: (UIScreen.screenWidth - 40), height: 180)
                .cornerRadius(20)
                .shadow(color: Color.gray, radius: 8)
            HStack {
                Text("Last \(title)")
                    .font(.largeTitle)
                    .offset(x: 15)
                Spacer()
                PieChartView(data: [12,3], title: "", form: ChartForm.medium)
                    .offset(x: -15)
            }
        }
        .padding(.bottom, 20)
        
    }
}


extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
