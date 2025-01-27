//
//  CustomDialog.swift
//  PlaygroundApp
//
//  Created by 吉澤翔吾 on 2025/01/27.
//

import SwiftUI

struct BottomDialog<Content: View>: View {
    var closeAction: (() -> Void)?
    let title: String
    let content: Content
    
    init(title: String, closeAction: (() -> Void)? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
        self.closeAction = closeAction
    }
    
    init(title: String, message: String, closeAction: (() -> Void)? = nil) where Content == AnyView {
        self.content = AnyView(
            Text(message)
                .frame(maxWidth: .infinity, alignment: .leading)
        )
        self.title = title
        self.closeAction = closeAction
    }
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(Color.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    closeAction?()
                }
            
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Text(title)
                            .font(.headline)
                        
                        Spacer()
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    
                    // 移動したcontent部分
                    content
                        .padding(16)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .shadow(color: Color(red: 29/255, green: 32/255, blue: 37/255, opacity: 0.3), radius: 50, x: 0, y: 16)
                .padding(.horizontal)
                .contentShape(Rectangle())
            }
        }
    }
}

#Preview {
//    BottomDialog(title: "タイトル") {
//        Text("メッセージメッセージメッセージメッセージメッセージメッセージメッセージ")
//    }
    BottomDialog(title: "タイトル", message: "メッセージメッセージメッセージメッセージメッセージメッセージメッセージ")
}

extension View {
    
    func alertFullScreenCover(
        _ title: String,
        isPresented: Binding<Bool>,
        closeAction: (() -> Void)? = nil
    ) -> some View {
        fullScreenCover(isPresented: isPresented) {
            BottomDialog(title: title, message: "messagemessagemessagemessage", closeAction: closeAction)
        }
    }
    
    func bottomAlertOverlay(
        title: String,
        message: String,
        isPresented: Binding<Bool>,
        closeAction: (() -> Void)? = nil
    ) -> some View {
        overlay {
            if isPresented.wrappedValue {
                BottomDialog(title: title, message: message, closeAction: closeAction)
            }
        }
    }
    
    func bottomAlertOverlay(
        title: String,
        @ViewBuilder contentArea: () -> some View,
        isPresented: Binding<Bool>,
        closeAction: (() -> Void)? = nil
    ) -> some View {
        overlay {
            if isPresented.wrappedValue {
                BottomDialog(title: title, closeAction: closeAction, content: contentArea)
            }
        }
    }
    
    func alertOverlay(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        overlay {
            if isPresented.wrappedValue {
                content()
            }
        }
    }
}
