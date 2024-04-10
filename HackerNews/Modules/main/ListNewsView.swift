//
//  ListNewsView.swift
//  HackerNews
//
//  Created by daniel ortiz millan on 03/04/24.
//

import SwiftUI




struct ListNewsView: View {
    @StateObject var viewModel = ListNewsViewModel()
    
    // Define el cuerpo de la vista.
    var body: some View {
        
        // Envuelve el contenido de la vista dentro de un NavigationView, que es necesario para navegar entre vistas en una aplicación SwiftUI.
        NavigationView {
            
            // Verifica si hay noticias disponibles en el viewModel. Si es así, muestra una lista de noticias.
            VStack {
                if let news = viewModel.news {
                    // Define una lista de elementos, donde cada elemento es un NavigationLink que lleva a la vista de detalles de la noticia.
                    
                    List {
                        ForEach(news.hits, id: \.objectID) {
                            item in NavigationLink(destination: NewsDetailView(newsItem: item)) {
                                Text("\(item.author)")
                                
                            }
                        }
                        
                        .onDelete(perform: deleteNews)
                        
                    }
                    
                } else if let error = viewModel.error {
                    Text("Error: \(error.localizedDescription)")
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Noticias")
            .refreshable {
                viewModel.performGetNews()
            }
            
        }
        .onAppear {
            viewModel.performGetNews()
            
        }
    }
        func deleteNews(at offsets: IndexSet) {
            viewModel.deleteNews(at: offsets)
        
    }
    
}

#Preview {
    ListNewsView()
}
