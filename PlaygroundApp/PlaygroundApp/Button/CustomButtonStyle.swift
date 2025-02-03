//
//  CustomButtonStyle.swift
//  PlaygroundApp
//
//  Created by 吉澤翔吾 on 2025/01/31.
//

import SwiftUI

/*
 buttonのactionは呼ばれる
 onTapGestureは呼ばれない
 */
struct DisableAfterTapForViewModifier: ViewModifier {
    var delay: TimeInterval
    @State private var isDisabled = false
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                print("DisableAfterTapForViewModifier onTapGesture")
                if !isDisabled {
                    isDisabled = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        isDisabled = false
                    }
                }
            }
            .disabled(isDisabled)
    }
}

/*
 buttonのactionも呼ばれる
 onTapGestureは呼ばれる
 */
struct DisableAfterTapForButtonStyle: ButtonStyle {
    var disableDuration: TimeInterval
    
    func makeBody(configuration: Configuration) -> some View {
        DisableAfterTapButton(disableDuration: disableDuration, configuration: configuration)
    }
    
    struct DisableAfterTapButton: View {
        @State private var isDisabled: Bool = false
        let disableDuration: TimeInterval
        let configuration: ButtonStyle.Configuration
        
        var body: some View {
            configuration.label
                .onTapGesture {
                    print("DisableAfterTapForButtonStyle onTapGesture")
                    if !isDisabled {
                        isDisabled = true
                        
                        // 指定時間後にボタンを再び有効化
                        DispatchQueue.main.asyncAfter(deadline: .now() + disableDuration) {
                            isDisabled = false
                        }
                    }
                }
                .disabled(isDisabled)
        }
    }
}

/*
 buttonのactionは適切なタイミングで呼ばれる
 onTapGestureも呼ばれる
 */
struct DisableAfterTapForPrimitiveButtonStyle: PrimitiveButtonStyle {
    let disableDuration: TimeInterval
    func makeBody(configuration: Configuration) -> some View {
        DisableAfterTapButton(disableDuration: disableDuration, configuration: configuration)
    }
    
    struct DisableAfterTapButton: View {
        @State private var isDisabled: Bool = false
        let disableDuration: TimeInterval
        let configuration: PrimitiveButtonStyle.Configuration
        
        var body: some View {
            let _ = Self._printChanges()
            let _ = print(isDisabled)
            configuration.label
                .onTapGesture {
                    print("DisableAfterTapForPrimitiveButtonStyle onTapGesture")
                    if !isDisabled {
                        isDisabled = true
                        configuration.trigger()
                        
                        // 指定時間後にボタンを再び有効化
                        DispatchQueue.main.asyncAfter(deadline: .now() + disableDuration) {
                            isDisabled = false
                        }
                    }
                }
                .disabled(isDisabled)
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.gray)
            .cornerRadius(40)
    }
}

extension View {
    func disableAfterTapForViewModifier(disableDuration: TimeInterval) -> some View {
        self.modifier(DisableAfterTapForViewModifier(delay: disableDuration))
    }
    
    func disableAfterTapForButtonStyle(disableDuration: TimeInterval) -> some View {
        self.buttonStyle(DisableAfterTapForButtonStyle(disableDuration: disableDuration))
    }
    
    func disableAfterTapForPrimitiveButtonStyle(disableDuration: TimeInterval) -> some View {
        self.buttonStyle(DisableAfterTapForPrimitiveButtonStyle(disableDuration: disableDuration))
    }
    
    func customButtonStyle() -> some View {
        self.buttonStyle(CustomButtonStyle())
    }
}

struct SampleView: View {
    
    @State var isPressed = false
    var body: some View {
        let _ = Self._printChanges()
        Text(isPressed ? "Pressed" : "Not Pressed")
        Button(action: {
            print("disableAfterTapForViewModifier action")
        }, label: {
            Text("disableAfterTapForViewModifier")
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        })
        .disableAfterTapForViewModifier(disableDuration: 1)
        
        Button {
            print("disableAfterTapForButtonStyle action")
        } label: {
            Text("disableAfterTapForButtonStyle")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .disableAfterTapForButtonStyle(disableDuration: 1)
        
        Button {
            print("disableAfterTapForPrimitiveButtonStyle action")
            isPressed.toggle()
        } label: {
            Text("disableAfterTapForPrimitiveButtonStyle")
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .disableAfterTapForPrimitiveButtonStyle(disableDuration: 1)
        
    }
}

#Preview {
    SampleView()
}
