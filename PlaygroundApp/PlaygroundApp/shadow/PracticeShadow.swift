//
//  PracticeShadow.swift
//  PlaygroundApp
//
//  Created by 吉澤翔吾 on 2025/01/29.
//

import SwiftUI

struct PracticeShadowView: View {
    
    @State private var isCheck: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            content
            footer
        }
    }
    
    private var content: some View {
        ScrollView(.vertical) {
            VStack {
                Text("〇〇〇〇〇〇〇〇〇〇〇〇")
                    .font(.title)
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
            }
        }
    }
    
    private var footer: some View {
        VStack {
            HStack(spacing: 12) {
                Button {
                    withAnimation {
                        isCheck.toggle()
                    }
                } label: {
                    Image(systemName: isCheck ? "checkmark.square" : "square")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 24)
                        .foregroundStyle(isCheck ? .black: .gray)
                }
                Text("〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇〇")
                    .font(.subheadline)
            }
            
            VStack(spacing: 12) {
                
                Button {
                    
                } label: {
                    Text("同意する")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.black)
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.black, lineWidth: 1)
                            }
                        )
                }
                
                Button {
                    isCheck = false
                } label: {
                    Text("同意しない")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.black)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.clear)
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1)
                            }
                        )
                }
                
            }
        }
        .padding(.top, 12)
        .padding(.horizontal, 16)
        .background(.white)
        .background(
            Color.white
                .shadow(radius: 8)
        )
    }
}


#Preview {
    PracticeShadowView()
}
