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
        profHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return profHeaderView
    }()
    private lazy var myButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.backgroundColor = UIColor.blue
        myButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        myButton.layer.cornerRadius = 4
        myButton.layer.shadowOpacity = 0.7
        myButton.layer.cornerRadius = 15
        myButton.setTitle("knock Button", for: .normal)
        myButton.setTitleColor(.white, for: .normal)
        myButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        myButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        return myButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "person.crop.square"), tag: 1)
        view.backgroundColor = .lightGray
        
        let tapDissmis = UITapGestureRecognizer(target: self, action: #selector(dissmiskeyboard))
        view.addGestureRecognizer(tapDissmis)
        setupProfHeaderView()
        setupMyButton()
        

    }
    func setupProfHeaderView() {
        view.addSubview(profHeaderView)
        NSLayoutConstraint.activate([
            profHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profHeaderView.heightAnchor.constraint(equalToConstant: 220)
            
        ])
        
    }
    func setupMyButton() {
        view.addSubview(myButton)
        NSLayoutConstraint.activate([
            myButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5),
            myButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            myButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            myButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    @objc func buttonPressed(sender:UIButton) {
        title = "тык тык"
    }
    
    @objc func dissmiskeyboard() {
        view.endEditing(true)
    }
}
