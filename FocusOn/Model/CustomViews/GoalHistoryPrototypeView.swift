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
    let dateFormatter = DateFormatter()
    
    var goal: Goal
    //    var tasks: [Task]
    
    
    var body: some View {
        
        Section(header: Text(timeController.formatteDateToString(date: goal.createdAt))) {
            VStack {
                HStack {
                    Text(goal.title)
                        .font(.system(size: 500))
                        .fontWeight(.medium)
                        .minimumScaleFactor(0.01)
                        .frame(height: 30.0)
                    
                    Spacer()
                    Button(action: {
                        self.goal.complete = (self.goal.complete ? false : true)
                    })
                    {
                        Image(systemName: (goal.complete ? "checkmark.circle.fill" : "multiply.circle"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(goal.complete ? .green : .red)
                    }.buttonStyle(GoalCompletionBtn())
                }
            }
        }
    }
}
