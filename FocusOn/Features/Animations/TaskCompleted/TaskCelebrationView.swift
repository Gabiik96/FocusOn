//
//  PartyEmojiView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 25/07/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI

struct TaskCelebrationView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        VStack {
        LottieView(fileName: self.colorScheme == .dark ? "PartyEmojiDark" : "PartyEmojiLight")
            .frame(width: 60.0, height: 70.0)
        Text("TASK COMPLETED")
            .font(.system(size: 15, weight: .light))
        }
    }
}

