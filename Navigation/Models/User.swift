//
//  UserModel.swift
//  Navigation
//
//  Created by Shalopay on 30.08.2022.
//

import UIKit

protocol UserService {
    func logIn(login: String, password: String) -> User?
}

class User {
    let login: String
    let password: String
    let fullname: String
    let statusLabel: String
    let avatar: UIImage
    init(login: String, password: String, fullname: String, statusLabel: String, avatar: UIImage) {
        self.login = login
        self.password = password
        self.fullname = fullname
        self.statusLabel = statusLabel
        self.avatar = avatar
    }
}

