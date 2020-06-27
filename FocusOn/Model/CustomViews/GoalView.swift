//
//  GoalView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 26/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI

struct GoalView: View {
    
    let timeController = TimeController()
    var goal: Goal
    let dateFormatter = DateFormatter()
    
    var body: some View {
        
        Section(header: Text(timeController.formatteDateToString(date: goal.createdAt))) {
                       VStack {
                           HStack() {
                            Text(goal.title)
                               .bold()
                               .font(.largeTitle)
                               .frame(height: 50.0)
                           Spacer()
                               Image(systemName: "checkmark.circle.fill")
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: 40.0, height: 50.0)
                                   .foregroundColor(.green)
                               
                        }
            }
        }
    }
}
