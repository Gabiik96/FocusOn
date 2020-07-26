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

struct RectangleBtnView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @FetchRequest( entity: Goal.entity(), sortDescriptors: [] ) var allGoals: FetchedResults<Goal>
    
    let title: String
    
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

struct ProgressDetailView: View {
    
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext
    @FetchRequest( entity: Goal.entity(), sortDescriptors: [] ) var goalsForPeriod: FetchedResults<Goal>
    
    let timePeriod: String
    
    var body: some View {
        VStack {
            HStack {
                taskGoalBtn()
            }
            LineView(data: [8,23,54,32,12,37,7,23,43], title: "Last \(timePeriod)", legend: "Full screen")
        }
    }
}

struct taskGoalBtn: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var goalIsPressed = false
    @State var taskIsPressed = false
    
    var body: some View {
        HStack {
        Button(action: {
            self.goalIsPressed = (self.goalIsPressed ? false : true)
            
        }){
            if self.goalIsPressed == false {
                DetailedBtn(title: "Goals", pressed: false)
            } else {
                DetailedBtn(title: "Goals", pressed: true)
        }
            }
        
        Spacer()
            .frame(width: 20)
            
        Button(action: {
            self.taskIsPressed = (self.taskIsPressed ? false : true)
            
        }){
            if self.taskIsPressed == false {
                DetailedBtn(title: "Tasks", pressed: false)
            } else {
                DetailedBtn(title: "Tasks", pressed: true)
            }
        }
        
        }
    }
    
    struct DetailedBtn: View {
        @Environment(\.colorScheme) var colorScheme: ColorScheme
        
        let title: String
        let pressed: Bool
        
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(self.pressed == false ? (self.colorScheme == .dark ? Color.white : Color.black) : (self.colorScheme == .dark ? Color.black : Color.white))
                    .frame(width: 60, height: 30)
                    .cornerRadius(3)
                    .shadow(color: Color.gray, radius: 3)
                Text(self.title)
                    .foregroundColor(self.pressed == true ? (self.colorScheme == .dark ? Color.white : Color.black) : (self.colorScheme == .dark ? Color.black : Color.white))
            }
        }
    }
    
}
