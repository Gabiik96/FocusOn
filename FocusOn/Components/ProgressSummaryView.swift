//
//  SwiftUIView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 03/07/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import CoreData


struct CountData: Identifiable, Equatable {
    var id = UUID()
    var date: String = ""
    var value: CGFloat = 0
    var goal: Goal
}

struct BarView: View {
    
    @State private var showValue = false
    
    var value: CGFloat = 10
    var date: String = ""
    var goal: Goal
    
    var body: some View {
        HStack {
            VStack {
                ZStack(alignment:.bottom) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.backgColor)
                        .frame(width: (showValue ? 60 : 30), height: 160)
                    if value > 80 {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [.darkGreen, .green ]), startPoint: .bottom, endPoint: .top))
                            .frame(width: (showValue ? 60 : 30), height: value)
                    } else if value == 80 {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [.darkOrange, .orange]), startPoint: .bottom, endPoint: .top))
                            .frame(width: (showValue ? 60 : 30), height: value)
                    } else if value < 80 && value > 30 {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [.darkRed, .red]), startPoint: .bottom, endPoint: .top))
                            .frame(width: (showValue ? 60 : 30), height: value)
                    }  else if value < 30 {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.textColor)
                            .frame(width: (showValue ? 60 : 30), height: 10)
                    }
                }.onTapGesture { self.showValue.toggle() }
                Text(date)
                    .fontWeight(.light)
                    .font(.system(size: 15))
            }
            if showValue == true {
                VStack(alignment: .leading){
                    BarObjectDetails(object: goal, bold: true)
                    ForEach(0..<goal.tasks.allObjects.count) { task in
                        BarObjectDetails(object: self.goal.tasks.allObjects[task] as! Task)
                    }
                }
            }
        }
    }
}

struct BarObjectDetails: View {
    
    let object: AnyObject
    var bold: Bool = false
    
    var body: some View {
        HStack {
            if bold == true {
                Text(object.title)
                    .bold()
            } else {
                Text(object.title)
            }
            Image(systemName: (object.complete ? "checkmark.circle.fill" : "multiply.circle"))
                .foregroundColor(object.complete ? .green : .red)
        }
    }
}
