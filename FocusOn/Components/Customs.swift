//
//  CustomButtons.swift
//  FocusOn
//
//  Created by Gabriel Balta on 16/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI

//MARK: - Button

struct AddGoal: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.green)
            .imageScale(.large)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
            .frame(width: 30.0, height: 60.0)
    }
}

struct AddTask: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.green)
            .imageScale(.large)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
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

//MARK: - Divider

struct LabelledDivider: View {

    let label: String
    let horizontalPadding: CGFloat
    let color: Color

    init(label: String, horizontalPadding: CGFloat = 10, color: Color = .divColor ) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }

    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color)
            line
        }
    }

    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}


