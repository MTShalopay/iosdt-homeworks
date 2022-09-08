//
//  Protocols.swift
//  Navigation
//
//  Created by Shalopay on 31.08.2022.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func check(login: String, password: String) -> Bool
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
