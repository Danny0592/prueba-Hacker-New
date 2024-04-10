//
//  NewsDetailView.swift
//  HackerNews
//
//  Created by daniel ortiz millan on 08/04/24.
//

import SwiftUI

struct NewsItem: Identifiable {
    let id: String // Assuming id is unique
    let title: String
    let author: String
    let content: String
}

// Ejemplo de uso:
let newsItem = NewsItem(id: "1", title: "Título de la noticia", author: "Autor de la noticia", content: "Contenido de la noticia...")


struct NewsDetailView: View {
    let newsItem: Hit
    
    var body: some View {
        VStack {
            NewsView(url: newsItem.storyURL ?? "www.google.com")
        }
        .padding()
        .navigationTitle(newsItem.author)
        
    }
}

import WebKit

// Crear una vista representable para WKWebView
struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

// Uso de WebView en tu vista
struct NewsView: View {
    var url: String
    var body: some View {
        WebView(url: URL(string: url)!)
            .edgesIgnoringSafeArea(.all)
    }
}


//#Preview {
//    NewsDetailView(newsItem: newsItem)
//    
//}
