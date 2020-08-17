//
//  TaskUnchecked.swift
//  FocusOn
//
//  Created by Gabriel Balta on 17/08/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI

struct TaskSadView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        VStack {
            LottieView(fileName: self.colorScheme == .dark ? "SadEmojiDark" : "SadEmojiLight")
                .frame(width: 60.0, height: 70.0)
            Text("TASK UNCHECKED")
                .font(.system(size: 15, weight: .light))
        }
    }
}
