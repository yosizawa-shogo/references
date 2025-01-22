//
//  AnimationView.swift
//  LottieExampleApp
//
//  Created by 吉澤翔吾 on 2025/01/21.
//
import SwiftUI
import DotLottie

struct AnimationView: View {
    enum Mode {
        case check
        case hit
        
        var fileName: String {
            switch self {
            case .check:
                return "check_animation"
            case .hit:
                return "hit_animation"
            }
        }
    }
    
    @StateObject private var animation: DotLottieAnimation
    private let observer: AnimationObserver
    let mode: Mode
    
    init(mode: Mode,
         onPlay: @escaping @MainActor () -> Void,
         onComplete: @escaping @MainActor () -> Void) {
        self.mode = mode
        self._animation = StateObject(wrappedValue: DotLottieAnimation(fileName: mode.fileName, config: AnimationConfig(autoplay: false, loop: false)))
        observer = AnimationObserver(onPlay: onPlay, onComplete: onComplete)
    }
    
    var body: some View {
        animation.view()
            .onAppear {
                animation.subscribe(observer: observer)
                _ = animation.play()
            }
    }
}

extension AnimationView {
    
    private class AnimationObserver: Observer {
        var onPlayHandler: (() -> Void)?
        var onCompleteHandler: (() -> Void)?
        
        init(onPlay: (() -> Void)? = nil, onComplete: (() -> Void)? = nil) {
            onPlayHandler = onPlay
            onCompleteHandler = onComplete
        }
        
        func onComplete() {
            onCompleteHandler?()
            print("onComplete")
        }
        
        func onFrame(frameNo: Float) {
            
        }
        
        func onLoad() {
            print("onLoad")
        }
        
        func onLoadError() {
            print("onLoadError")
        }
        
        func onLoop(loopCount: UInt32) {
        }
        
        func onPause() {
            print("onPause")
        }
        
        func onPlay() {
            self.onPlayHandler?()
            print("onPlay")
        }
        
        func onRender(frameNo: Float) {
        }
        
        func onStop() {
            print("onStop")
        }
        
    }
}
