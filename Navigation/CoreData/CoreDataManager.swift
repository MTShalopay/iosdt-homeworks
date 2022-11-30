//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Shalopay on 27.11.2022.
//

import CoreData

class CoreDataManager {
    var items: [FavoriteItem] = []
    var searchPost: [FavoriteItem] = []
    static let shared = CoreDataManager()
    
    private init() {
        reloadFolders()
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func reloadFolders() {
        do {
            let items = try persistentContainer.viewContext.fetch(FavoriteItem.fetchRequest()) as! [FavoriteItem]
            self.items = items
        } catch {
            print("ERROR reloadFolders: \(error)")
        }
    }
    func addNewItem(author: String, imagePath: String) {
        
        let item = FavoriteItem(context: persistentContainer.viewContext)
        item.date = Date()
        item.image = imagePath
        item.author = author
        saveContext()
        reloadFolders()
    }
    func deleteFolder(folder: FavoriteItem) {
        persistentContainer.viewContext.delete(folder)
        saveContext()
        reloadFolders()
    }
    
    func checkDuplicate(imagePath: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteItem")
        fetchRequest.predicate = NSPredicate(format: "image == %@", argumentArray: [imagePath])
        let count = try! persistentContainer.viewContext.count(for: fetchRequest)
        guard count == 0 else {
            print("POST DUBLICATE")
            return false
        }
        return true
    }
    
   
    func searchPost(name: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteItem")
        fetchRequest.predicate = NSPredicate(format: "image == %@", argumentArray: [name])
        do {
            let posts = try persistentContainer.viewContext.fetch(fetchRequest) as! [FavoriteItem]
            self.searchPost = posts
            saveContext()
        } catch {
            print("ERROR SEARCHPOST \(error)")
        }
    }
    
    private func printStats() {
        let context = persistentContainer.viewContext
        context.perform {
            
            if Thread.isMainThread {
                print("MAIN поток")
            } else {
                print("Background поток")
                }
            }
        }
}



