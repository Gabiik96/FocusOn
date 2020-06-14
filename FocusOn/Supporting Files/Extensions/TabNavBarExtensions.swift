//
//  TabNavBarExtensions.swift
//  FocusOn
//
//  Created by Gabriel Balta on 10/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let standardAppearance = UITabBarAppearance()

        standardAppearance.backgroundColor = .backgColor

        tabBar.standardAppearance = standardAppearance
    }
}
