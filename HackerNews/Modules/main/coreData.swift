//
//  coreData.swift
//  HackerNews
//
//  Created by daniel ortiz millan on 08/04/24.
//
import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error initializing Core Data: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    func saveNewsToCoreData(news: [Hit]) {
        for hit in news {
            let hitEntity = HitEntity(context: context)
            hitEntity.author = hit.author
            hitEntity.commentText = hit.commentText
            hitEntity.storyURL = hit.storyURL
        }
        
        do {
            try context.save()
            print("guardado de manera correcta en la base de datos")
        } catch {
            print("Error al guardar en CoreData: \(error.localizedDescription)")
        }
    }
    
}


