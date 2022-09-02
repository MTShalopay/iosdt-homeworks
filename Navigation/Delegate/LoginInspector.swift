//
//  LoginInspector.swift
//  Navigation
//
//  Created by Shalopay on 31.08.2022.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    let checker = Checker.self
    func check(login: String, password: String) -> Bool {
        if checker.shared.check(login: login, password: password) {
            print("Доступен вход")
            return true
        } else {
            print("В доступе отказанно")
            return false
        }
    }
}
