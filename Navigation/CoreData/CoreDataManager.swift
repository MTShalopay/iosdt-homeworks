//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Shalopay on 27.11.2022.
//

import CoreData
import UIKit

enum TableViewState {
    case normal, nsfetchedResultsController, searchPost
}

class CoreDataManager {
    var items: [FavoriteItem] = []
    var searchPosts: [FavoriteItem] = []
    static let shared = CoreDataManager()
    
    private init() {
        //reloadFolders()
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
    
    lazy var nsfetchedResultsController: NSFetchedResultsController<FavoriteItem> = {
        let fetchRequest: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        let nsfrc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                              managedObjectContext: persistentContainer.viewContext,
                                              sectionNameKeyPath: nil,
                                              cacheName: nil)
       return nsfrc
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
        let fetchRequest: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
        do {
            let items = try persistentContainer.viewContext.fetch(fetchRequest) 
            self.items = items
        } catch {
            print("ERROR reloadFolders: \(error)")
        }
    }
    
    func addNewItem(author: String, imagePath: Data, desc: String, likes: String, views: String) {
        persistentContainer.performBackgroundTask { (contex) in
            let item = FavoriteItem(context: contex)
            item.date = Date()
            item.image = imagePath
            item.author = author
            item.desc = desc
            item.likes = likes
            item.views = views
            do {
                try contex.save()
                self.reloadFolders()
            } catch {
                print("ERROR addNewItem: \(error)")
            }
        }
    }
    func deleteFolder(folder: FavoriteItem) {
        persistentContainer.viewContext.delete(folder)
        saveContext()
        reloadFolders()
    }
        
    func checkDuplicate(authorName: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteItem")
        fetchRequest.predicate = NSPredicate(format: "author == %@", argumentArray: [authorName])
        let count = try! persistentContainer.viewContext.count(for: fetchRequest)
        fetchRequest.fetchLimit = count
        guard count == 0 else {
            print("POST DUBLICATE")
                return false
        }
        return true
    }
    
   
    func searchPost(authorName: String) -> [FavoriteItem]{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteItem")
            fetchRequest.predicate = NSPredicate(format: "author contains[c] %@", argumentArray: [authorName])
            do {
                let posts = try persistentContainer.viewContext.fetch(fetchRequest) as! [FavoriteItem]
                return posts
            } catch {
                print("ERROR SEARCHPOST \(error)")
                return []
            }
    }
    
    func deletePost(author: FavoriteItem) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteItem")
        do {
            let posts = try persistentContainer.viewContext.fetch(fetchRequest) as! [FavoriteItem]
            for post in posts {
                if post.author == author.author {
                    print("post delete :\(String(describing: post.author))")
                    persistentContainer.viewContext.delete(post)
                    saveContext()
                }
            }
        } catch {
            print("ERROR for deletePost")
        }
    }
    
    private func isMainThreadPrint() {
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



