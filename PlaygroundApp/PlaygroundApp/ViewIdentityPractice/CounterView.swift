//
//  CounterView.swift
//  PlaygroundApp
//
//  Created by 吉澤翔吾 on 2025/02/01.
//

import SwiftUI

struct CounterView: View {

    @State var count = 0

    var body: some View {
        let _ = Self._printChanges()
        Button {
            count += 1
        } label: {
            Text(count.description)
                .font(.title)
        }
    }
}
