//
//  TestUserService.swift
//  Navigation
//
//  Created by Shalopay on 30.08.2022.
//

import UIKit

class TestUserService: UserService {
    public let testUser:User = User(login: "22", password: "22", fullname: "Fullname", statusLabel: "Opsss", avatar: UIImage(named: "pucture12")!)
    
    func logIn(login: String, password: String) -> User? {
        guard login == testUser.login, password == testUser.password else { return nil }
        return testUser
    }
    
    init() {}
    
    
}
