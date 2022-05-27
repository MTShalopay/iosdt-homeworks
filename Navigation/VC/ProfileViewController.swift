//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Shalopay on 27.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "person.crop.square"), tag: 0)
        view.backgroundColor = UIColor.white
    }    
}
