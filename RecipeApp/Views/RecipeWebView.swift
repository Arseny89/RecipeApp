//
//  RecipeWebView.swift
//  RecipeApp
//
//  Created by Арсений Корниенко on 12/12/24.
//

import WebKit
import SwiftUI

struct RecipeWebView: View {
    var url: URL
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(icon: .xmark)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.white)
                    .shadow(color: .black, radius: 1, x: -1, y: 1)
                    .onTapGesture {
                        self.dismiss()
                    }
            }
            WebView(url: url)
        }
    }
}

struct WebView: UIViewRepresentable {
    
    typealias UIViewType = WKWebView
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
