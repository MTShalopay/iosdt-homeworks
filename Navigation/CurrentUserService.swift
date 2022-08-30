//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Shalopay on 30.08.2022.
//

/*
 // 3. Constructor injection

 final class ViewModel {
     private let userService: UserServiceProtocol
     private let modelID: String
     
     init(userService: UserServiceProtocol, modelID: String) {
         self.userService = userService
         self.modelID = modelID
     }
 }

 let userService = UserService()
 let viewModel = ViewModel(
     userService: userService,
     modelID: UUID().uuidString
 )
 */

import UIKit

class CurrentUserService: UserService {
    
    var userNew:User = User(login: "11",
                          password: "11",
                          fullname: "Maxim Terentiev",
                          statusLabel: "Все ок",
                          avatar: (UIImage(named: "pucture1")!)
    )
    
    func logIn(login: String, password: String) -> User? {
        if login == userNew.login && password == userNew.password {
            print(userNew.avatar, userNew.fullname, userNew.login, userNew.password, userNew.statusLabel)
        } else {
            print("Данного пользователя с логином \(login) нет в БД")
        }
        return userNew
    }
    init() {}
    
}

