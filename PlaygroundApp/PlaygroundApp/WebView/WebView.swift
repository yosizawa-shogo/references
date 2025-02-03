////
////  WebView.swift
////  PlaygroundApp
////
////  Created by 吉澤翔吾 on 2025/01/31.
////
//
//import SwiftUI
//import WebKit
//import UIKit
//
//struct WebView: UIViewRepresentable {
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//    
//    private var url: URL
//    private let configuration: WKWebViewConfiguration?
//
//    private var onRefreshCallback: ((_ webView: WKWebView) async -> Void)?
//
//    init(url: URL, configuration: WKWebViewConfiguration? = nil) {
//        self.url = url
//        self.configuration = configuration
//    }
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView: WKWebView = {
//            guard let configuration else { return .init() }
//
//            return .init(frame: .zero, configuration: configuration)
//        }()
//
//        if self.onRefreshCallback != nil {
//            webView.scrollView.refreshControl = context.coordinator.refreshControl(for: webView)
//        }
//
//        let request: URLRequest = .init(url: url)
//
//        webView.load(request)
//
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//    }
//
//    class Coordinator {
//        private let parent: WebView
//
//        private var refreshableTask: Task<Void, Never>?
//
//        init(parent: WebView) {
//            self.parent = parent
//        }
//
//        deinit {
//            refreshableTask?.cancel()
//        }
//
//        func refreshControl(for webView: WKWebView) -> UIRefreshControl {
//            let refreshControl: UIRefreshControl = .init()
//
//            let action: UIAction = .init { [weak self] _ in
//                guard let unwrappedSelf = self else { return }
//
//                unwrappedSelf.refreshableTask?.cancel()
//
//                unwrappedSelf.refreshableTask = Task {
//                    await unwrappedSelf.parent.onRefreshCallback?(webView)
//
//                    await MainActor.run {
//                        // MARK: 呼ばないと永遠にクルクルする
//                        refreshControl.endRefreshing()
//                    }
//                }
//            }
//
//            refreshControl.addAction(
//                action,
//                for: .valueChanged
//            )
//
//            return refreshControl
//        }
//    }
//}
//
//extension WebView {
//    // MARK: モディファイアっぽく使えるようにするやつ
//    func refreshable(action: @escaping @Sendable (_ webView: WKWebView) async -> Void) -> Self {
//        var view = self
//
//        view.onRefreshCallback = action
//
//        return view
//    }
//
//    func refreshable() -> Self {
//        var view = self
//
//        view.onRefreshCallback = {
//           if $0.url == nil {
//                $0.load(URLRequest(url: url))
//
//                return
//            }
//
//            $0.reload()
//        }
//
//        return view
//    }
//}
