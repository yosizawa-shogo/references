//
////
////  WebViewReaderProxy.swift
////  PlaygroundApp
////
////  Created by 吉澤翔吾 on 2025/01/31.
////
//
//import SwiftUI
//import WebKit
//
//final class WebViewInstanceStore: ObservableObject {
//    @Published var webView: WKWebView = .init()
//}
//
//@dynamicMemberLookup
//struct WebViewReaderProxy {
//    @ObservedObject private var webViewInstanceStore: WebViewInstanceStore
//
//    init(webViewInstanceStore: WebViewInstanceStore) {
//        _webViewInstanceStore = .init(initialValue: webViewInstanceStore)
//    }
//
//    subscript<T>(dynamicMember keyPath: KeyPath<WKWebView, T>) -> T {
//        webViewInstanceStore.webView[keyPath: keyPath]
//    }
//
//    @discardableResult
//    public func goBack() -> WKNavigation? {
//        return webViewInstanceStore.webView.goBack()
//    }
//
//    @discardableResult
//    public func goForward() -> WKNavigation? {
//        return webViewInstanceStore.webView.goForward()
//    }
//
//    @discardableResult
//    public func reload() -> WKNavigation? {
//        return webViewInstanceStore.webView.reload()
//    }
//
//    @discardableResult
//    public func stopLoading() {
//        return webViewInstanceStore.webView.stopLoading()
//    }
//}
//
//struct WebViewReader<Content: View>: View {
//    @StateObject private var webViewInstanceStore: WebViewInstanceStore = .init()
//
//    @ViewBuilder var content: (WebViewReaderProxy) -> Content
//
//    private var proxy: WebViewReaderProxy {
//        .init(webViewInstanceStore: webViewInstanceStore)
//    }
//
//    init(@ViewBuilder content: @escaping (WebViewReaderProxy) -> Content) {
//        self.content = content
//    }
//
//    var body: some View {
//        content(proxy)
//            .environmentObject(webViewInstanceStore)
//    }
//}
