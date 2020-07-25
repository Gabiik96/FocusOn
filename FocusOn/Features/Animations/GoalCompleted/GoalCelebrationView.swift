//
//  GoalCelebrationView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 25/07/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI

struct GoalCelebrationView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
//    @State var textIsHidden: Bool
    
    var body: some View {
        ZStack {
            LottieView(fileName: self.colorScheme == .dark ? "ConfettiDark" : "ConfettiLight")
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 0,
                       maxHeight: .infinity)
//            if textIsHidden == false {
                withAnimation { Text("GOAL COMPLETED")}
                
//            }
        }
    }
}
