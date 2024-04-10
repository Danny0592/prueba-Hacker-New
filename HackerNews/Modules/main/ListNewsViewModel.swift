//
//  ListNewsViewModel.swift
//  HackerNews
//
//  Created by daniel ortiz millan on 03/04/24.
// para agarrar los datos

import Foundation
import Combine
import CoreData //

// Define una estructura llamada HitEntity que implementa el protocolo Identifiable
class HitEntity1: NSManagedObject {
       
       @NSManaged var highlightResult: HighlightResultEntity?
       @NSManaged var tags: [String]
       @NSManaged var author: String
       @NSManaged var commentText: String?
       @NSManaged var createdAt: String
       @NSManaged var createdAtI: Int
       @NSManaged var objectID1: String
       @NSManaged var parentID: Int
       @NSManaged var storyID: Int
       @NSManaged var storyTitle: String?
       @NSManaged var storyURL: String?
       @NSManaged var updatedAt: String?
       @NSManaged var children: [Int]?
       @NSManaged var numComments: Int
       @NSManaged var points: Int
       @NSManaged var title: String?
       @NSManaged var url: String?
       @NSManaged var storyText: String?
}

class HighlightResultEntity1: NSManagedObject {
    @NSManaged var author: AuthorEntity?
    @NSManaged var commentText, storyTitle, storyURL, title: AuthorEntity?
    @NSManaged var url, storyText: AuthorEntity?
}

class AuthorEntity1: NSManagedObject {
    @NSManaged var matchLevel: String
    @NSManaged var matchedWords: [String]
    @NSManaged var value: String
    @NSManaged var fullyHighlighted: Bool
}

 // esta clase puede ser utilizada como un objeto observable en SwiftUI y puede notificar a las vistas
class ListNewsViewModel: ObservableObject {
    
// Crea una instancia de la clase ApiClient, que se utiliza para realizar solicitudes a una API para obtener noticias.
    let ApliClient = ApiClient ()
  //  Crea una instancia de la clase CoreDataManager, que se utilizará para manejar las operaciones relacionadas con CoreData, como guardar noticias en la base de datos.

    @Published var news: News?
    @Published var error: Error?
    //se utiliza para almacenar los suscriptores a los publishers de Combine para evitar que se cancelen prematuramente.
    private var cancellables = Set<AnyCancellable>()
    
    
    // para realizar la solicitud a la API y se actualizan las variables news y error en consecuencia.
    func performGetNews() {
        
        ApliClient.getNews { result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let news):
                    self.news = news
                    self.error = nil
                    CoreDataManager.shared.saveNewsToCoreData(news: news.hits)
                case .failure(let error):
                    self.news = nil
                    self.error = error
                }
                
            }
        }
        
    }
    
    // Esta función actualiza la lista de noticias eliminando los elementos en los índices dados.
    func deleteNews(at offsets: IndexSet) {
        guard var currentNews = news else { return }
        currentNews.hits.remove(atOffsets: offsets)
        news = currentNews
        
    }
    // Define una función que probablemente se utilizaba para guardar noticias en CoreData, pero está actualmente comentada
    /*func saveNewsToCoreData(news: News) {       //
        for hit in news.hits {                   //
            coreDataManager.saveNews(hit: hit)  //
        }
    }*/

}
