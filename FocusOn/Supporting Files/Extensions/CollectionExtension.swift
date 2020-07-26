//
//  ArrayExtension.swift
//  FocusOn
//
//  Created by Gabriel Balta on 26/07/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI

extension Collection {
  func enumeratedArray() -> Array<(offset: Int, element: Self.Element)> {
    return Array(self.enumerated())
  }
}
