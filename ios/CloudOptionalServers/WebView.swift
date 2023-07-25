//
//  WebView.swift
//  CloudOptionalServers
//
//  Created by Maximilian Alexander on 7/24/23.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
 
    var url: String
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: URL(string: self.url)!)
        webView.load(request)
    }
}
