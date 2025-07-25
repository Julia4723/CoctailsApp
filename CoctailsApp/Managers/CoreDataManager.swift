//
//  CoreDataManager.swift
//  CoctailsApp
//
//  Created by user on 20.07.2025.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    let name = "CocktailsModel"
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: name) // имя .xcdatamodeld
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("Ошибка загрузки хранилища: \(error)")
            }
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    
    
    func saveContext() {
        guard persistentContainer.viewContext.hasChanges else {return}
        
        do {
            try persistentContainer.viewContext.save()
            print("Context saved successfully")
        } catch {
            print("CoreDataManager - save() error" + error.localizedDescription)
        }
    }
    
    func delete(_ object: NSManagedObject) {
        persistentContainer.viewContext.delete(object)
        saveContext()
    }
    
    func fetch() {
        let request: NSFetchRequest<CocktailItem> = CocktailItem.fetchRequest()
        do {
            let notes = try persistentContainer.viewContext.fetch(request)
            print(notes)
        } catch {
            print("Ошибка загрузки: \(error)")
        }
    }
}
