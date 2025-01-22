//
//  ContentView.swift
//  LottieExampleApp
//
//  Created by 吉澤翔吾 on 2025/01/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var stateText: String = "aiueo"
    @State private var isCompleteAnimation: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.yellow.ignoresSafeArea()
            VStack {
                Text(stateText)
                    .font(.title)
                    .padding()
                
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 300)
            }
            if !isCompleteAnimation {
                AnimationView(mode: .hit, onPlay: {
                    stateText = "onPlay"
                }, onComplete: {
                    stateText = "onComplete"
                    isCompleteAnimation = true
                })
            }
        }
        .padding()
    }
    
}

#Preview {
    ContentView()
}
