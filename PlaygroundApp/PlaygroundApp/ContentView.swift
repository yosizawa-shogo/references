//
//  ContentView.swift
//  PlaygroundApp
//
//  Created by 吉澤翔吾 on 2025/01/27.
//

import SwiftUI

struct ContentView: View {
    
    @State var isShowOverlayAlert: Bool = false
    @State var isShowOverlayAlertCustom: Bool = false
    
    var body: some View {
        VStack {
            Button("Show Overlay") {
                withAnimation {
                    isShowOverlayAlert = true
                }
            }
            
            Button("Show Overlay custom content") {
                withAnimation {
                    isShowOverlayAlertCustom = true
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .bottomAlertOverlay(title: "Title", message: "message", isPresented: $isShowOverlayAlert) {
            withAnimation {
                isShowOverlayAlert = false
            }
        }
        .bottomAlertOverlay(title: "title", contentArea: {
            VStack {
                Text("content")
                Button("Close") {
                    isShowOverlayAlert = false
                }
            }
        }, isPresented: $isShowOverlayAlertCustom) {
            withAnimation {
            isShowOverlayAlertCustom = false
            }
        }
    }
}

#Preview {
    ContentView()
}
