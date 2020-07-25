//
//  LottieView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 25/07/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let animationView = AnimationView()
    var fileName = "LottieLogo2"
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        
        let animation = Animation.named(fileName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor
                .constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor
                .constraint(equalTo: view.widthAnchor),
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
    }
}
