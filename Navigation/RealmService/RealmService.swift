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
        try! realm.write({
            realm.add(category)
        })
    }
    //create User
    func addUser(categoryId: String, user: NewUsers) {
        guard let category = realm.object(ofType: Category.self, forPrimaryKey: categoryId) else { return }
        try! realm.write({
            category.users.append(user)
        })
    }
    
    //delete Category

    //delete User
    
    //deleteAll
    func deleteAllCategory() {
        try! realm.write({
            _ = realm.objects(Category.self)
            realm.deleteAll()
        })
    }
    
}
