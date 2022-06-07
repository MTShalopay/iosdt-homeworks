//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Shalopay on 27.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profHeaderView: ProfileHeaderView = {
       let profHeaderView = ProfileHeaderView()
        return profHeaderView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "person.crop.square"), tag: 1)
        view.backgroundColor = .lightGray
        view.addSubview(profHeaderView)
        
        let tapDissmis = UITapGestureRecognizer(target: self, action: #selector(dissmiskeyboard))
        view.addGestureRecognizer(tapDissmis)

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let frameView = view.frame.size
        profHeaderView.frame.size = frameView
        
    }
    @objc func dissmiskeyboard() {
        view.endEditing(true)
    }
}
