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
    
    @State var textIsHidden: Bool
    
    var body: some View {
        ZStack {
            Group {
                LottieView(fileName: self.colorScheme == .dark ? "LanternDark" : "LanternLight")
                    .padding(.bottom, 50)
                LottieView(fileName: self.colorScheme == .dark ? "ConfettiDark" : "ConfettiLight")
                    .position(x: (UIScreen.screenWidth / 2), y: (UIScreen.screenHeight / 2))
                
            }.onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation { self.textIsHidden = false }
                }
            }
            if textIsHidden == false {
                withAnimation {
                    Text("GOAL COMPLETED")
                        .position(x: (UIScreen.screenWidth / 2), y: (UIScreen.screenHeight / 2.1))
                        .font(.system(size: 30))
                }
                
            }
        }
    }
}
