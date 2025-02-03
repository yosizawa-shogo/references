//
//  ClickableOnce.swift
//  PlaygroundApp
//
//  Created by 吉澤翔吾 on 2025/01/31.
//

import SwiftUI

// この方法はPreventDoubleTapModifier内のonTapgestureが反応しないためNG
struct PreventDoubleTapModifier: ViewModifier {
    @State private var isDisabled = false
    let delay: TimeInterval
    
    func body(content: Content) -> some View {
        content
            .disabled(isDisabled)
            .onTapGesture {
                print("Button onTapGesture!")
                if !isDisabled {
                    isDisabled = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        isDisabled = false
                    }
                }
            }
    }
}

// Viewのextensionとしてカスタムメソッドを定義
extension View {
    func preventDoubleTap(for delay: TimeInterval) -> some View {
        self.modifier(PreventDoubleTapModifier(delay: delay))
    }
}

struct ClickableOnceSampleView: View {
    var body: some View {
        VStack {
            Button(action: {
                print("Button tapped!")
            }) {
                Text("Tap me")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .preventDoubleTap(for: 0.5) // 多重タップ防止Modifierを適用
        }
    }
}

#Preview {
    ClickableOnceSampleView()
}





