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
}
