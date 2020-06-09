//
//  TodayView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 04/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI

struct AppView: View {
    
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor(named: "tabColor")
    }
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
        
    }
}

struct AppView_Previews: PreviewProvider {
    
    static var previews: some View {
        AppView()
    }
}
