//
//  RealmService.swift
//  Navigation
//
//  Created by Shalopay on 26.11.2022.
//

import Foundation
import RealmSwift

class RealmService {
    //создаем БД
    let realm = try! Realm()
    //create Category
    func createCategory(name: String) {
        let category = Category()
        category.categoryName = name
        do {
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("ERROR: \(error)")
        }
        
    }
    //create User
    func addUser(categoryId: String, user: NewUsers) {
        guard let category = realm.object(ofType: Category.self, forPrimaryKey: categoryId) else { return }
        do {
            try realm.write({
                category.users.append(user)
            })
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    //delete Category

    //delete User
    
    //deleteAll
    func deleteAllCategory() {
        do {
        try realm.write({
            _ = realm.objects(Category.self)
            realm.deleteAll()
        })
        } catch {
            print("ERROR: \(error)")
        }
    }
    
}
