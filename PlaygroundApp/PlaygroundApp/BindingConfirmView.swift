//
//  BindingConfirmView.swift
//  PlaygroundApp
//
//  Created by 吉澤翔吾 on 2025/01/28.
//

import SwiftUI

struct BindingConfirmConteiner: View {
    @StateObject var viewModel = BindingConfirmViewModel()
    
    var body: some View {
        let _ = print("BindingConfirmConteiner 再描画")
        BindingConfirmView(viewModel: viewModel)
    }
}


struct BindingConfirmView: View {
    
    private let uiModel: BindingConfirmUIModel
    private let intent: (BindingConfirmViewModel.BindingConfirmIntent) -> Void
    
    init(viewModel: BindingConfirmViewModel) {
        self.uiModel = viewModel.uiModel
        self.intent = viewModel.runIntent
    }
    
    var body: some View {
        List {
            ConfirmCellComponent(isOn: Binding(get: {
                uiModel.isOn
            }, set: {_ in
                
            }))
            Button(action: {
                intent(.confirm(!uiModel.isOn))
            }) {
                Text("OK")
            }
        }
        .shadow(color: .black, radius: 8)
    }
}

struct ConfirmCellComponent: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Text("Confirm")
        }
        .frame(height: 64)
        .padding(.horizontal, 16)
        .listRowInsets(EdgeInsets())
        .disabled(true)
    }
}

class BindingConfirmViewModel: ObservableObject {
    
    enum BindingConfirmIntent {
        case confirm(Bool)
    }
    
    var uiModel: BindingConfirmUIModel {
        BindingConfirmUIModel.from(isOn: isOn)
    }
    @Published var isOn: Bool = false
    
    func runIntent(_ intent: BindingConfirmIntent) {
        switch intent {
        case .confirm(let isOn):
            let _ = print(isOn)
            self.isOn = isOn
        }
    }
}

struct BindingConfirmUIModel {
    var isOn: Bool = false
    
    static func from(isOn: Bool) -> BindingConfirmUIModel {
        return .init(isOn: isOn)
    }
}

#Preview {
    BindingConfirmConteiner()
}
