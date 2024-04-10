//
//  ApiClient.swift
//  HackerNews
//
//  Created by daniel ortiz millan on 03/04/24.
//

import Foundation

class ApiClient{
    func getNews(completion: @escaping (Result<News, Error>) -> Void) {
        
        var request = URLRequest(url: URL(string: "http://hn.algolia.com/api/v1/search_by_date?query=androi%20d")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let _: Void = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print("Error: \(error)")
                } else {
                    print("No data received")
                }
                return
                
                
            }
            
            print(String(data: data, encoding: .utf8)!)
            
         
            do {
                  // Decodificar el JSON en un objeto Swift
                
                  let result = try JSONDecoder().decode(News.self, from: data)
                completion(.success(result))
             
                  // Aquí, 'YourObjectType' debe ser el tipo de objeto Swift que deseas obtener del JSON.
                  // Puedes reemplazar 'YourObjectType' con el tipo de objeto real que esperas recibir.

                  // Ahora puedes trabajar con 'result', que es tu objeto Swift decodificado.
              } catch {
                  print("Error al decodificar el JSON: \(error)")
                  completion(.failure(error))
              }
          }.resume()
        
    }
}


