//
//  TodayView.swift
//  FocusOn
//
//  Created by Gabriel Balta on 04/06/2020.
//  Copyright © 2020 Gabriel Balta. All rights reserved.
//

import SwiftUI

struct TodayView: View {
    var body: some View {
        
        VStack(alignment: .center) {
            Text("FocusOn Today")
                .bold()
            Divider()
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
