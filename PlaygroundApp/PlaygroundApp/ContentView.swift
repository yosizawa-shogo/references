//
//  ContentView.swift
//  PlaygroundApp
//
//  Created by 吉澤翔吾 on 2025/01/27.
//

import SwiftUI

struct ContentView: View {
    
    @State var isShowCoverDialog: Bool = false
    @State var isShowOverlayAlert: Bool = false
    @State var isShowOverlayAlertCustom: Bool = false
    @State private var isShowCustomModal = false
    
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
            
            Button("Show Cover") {
                withAnimation(.easeInOut) {
                    isShowCoverDialog = true
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .bottomAlertOverlay(title: "Title", message: "message", isPresented: $isShowOverlayAlert) {
            withAnimation {
                isShowOverlayAlert = false
            }
        }
        .fullScreenCover(isPresented:  $isShowCoverDialog, content: {
            BottomDialog(title: "Title", message: "message") {
                isShowCoverDialog = false
            }
            .presentationBackground(.clear)
        })
        .bottomAlertOverlay(title: "title", contentArea: {
            VStack {
                Text("content")
                Button("Close") {
                    isShowOverlayAlertCustom = false
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
