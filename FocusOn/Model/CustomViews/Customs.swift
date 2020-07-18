//
//  CustomButtons.swift
//  FocusOn
//
//  Created by Gabriel Balta on 16/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI

//MARK: - Green Symbol Add Button

struct AddButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.green)
            .imageScale(.large)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
    }
    
    func scaleAnimation(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.5 : 1.0)
    }
}

struct CompletionGoal: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .imageScale(.large)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
            .frame(width: 40.0, height: 40.0)
    }
}

struct CompletionTask: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .imageScale(.large)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
            .frame(width: 25.0, height: 25.0)
    }
}

struct AnimatedGradientView2: View {
    
    @State var gradient = [Color.white, Color.green]
    @State var startPoint = UnitPoint(x: 0.5, y: -1)
    @State var endPoint = UnitPoint(x: 0, y: 1)
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))

            .onTapGesture {
                withAnimation (.easeInOut(duration: 3)){
                    self.startPoint = UnitPoint(x: 1, y: -1)
                    self.endPoint = UnitPoint(x: 0, y: 1)
                }
        }
    }
}

