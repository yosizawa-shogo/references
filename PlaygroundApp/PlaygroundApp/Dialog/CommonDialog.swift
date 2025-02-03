//
//  CommonDialog.swift
//  PlaygroundApp
//
//  Created by 吉澤翔吾 on 2025/01/31.
//

import SwiftUI

struct Dialog: View {
    
    struct DialogAction {
        enum Style {
            case primary
            case secondary
            
            var titleColo: Color {
                switch self {
                case .primary:
                    return .white
                case .secondary:
                    return .black
                }
            }
            
            var buttonColor: Color {
                switch self {
                case .primary:
                    return .blue
                case .secondary:
                    return .gray
                }
            }
            
            var borderColor: Color {
                switch self {
                case .primary:
                    return .blue
                case .secondary:
                    return .gray
                }
            }
        }
        
        let title: String
        let style: Style
        let action: () -> Void
    }
    
    let title: String
    let subTitle: String?
    let message: String
    private let actions: [DialogAction]
    
    init(title: String, subTitle: String? = nil, message: String, actions: [DialogAction]) {
        self.title = title
        self.subTitle = subTitle
        self.message = message
        self.actions = actions
    }
    
    var body: some View {
        content()
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Button {
                    
                } label: {
                    Color.black.opacity(0.3)
                }
            }
    }
    
    private func content() -> some View {
        VStack(spacing: 0) {
            Text(title)
                .foregroundStyle(.black)
                .font(.body)
                .fontWeight(.semibold)
                .padding(16)
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
                .frame(maxWidth: .infinity)
            
            alertContents(subTitle: subTitle, message: message)
            actionButtons()
        }
        .background(.white)
        .contentShape(.rect)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(maxWidth: .infinity)
    }
    
    private func alertContents(subTitle: String?, message: String?) -> some View {
        VStack(spacing: 0) {
            if let subTitle = subTitle {
                Text(subTitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            
            if let message = message {
                Text(message)
                    .font(.body)
            }
        }
        .padding(16)
        .foregroundStyle(.black)
    }
    
    private func actionButtons() -> some View {
        HStack(spacing: 16) {
            ForEach(0..<actions.count, id: \.self) { index in
                let action = actions[index]
                Button(action: action.action) {
                    Text(action.title)
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(action.style.titleColo)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(action.style.buttonColor)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(action.style.borderColor, lineWidth: 1)
                        )
                        
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

#Preview {
    Dialog(title: "タイトル", subTitle: "サブタイトル", message: "メッセージ", actions: [Dialog.DialogAction(title: "OK", style: .primary, action: {}), Dialog.DialogAction(title: "キャンセル", style: .secondary, action: {})])
}
