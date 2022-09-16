//
//  InfoViewController.swift
//  Navigation
//
//  Created by Shalopay on 27.05.2022.
//

import UIKit

class InfoViewController: UIViewController {
    public var myTitle: String?
    public var myMessage: String?
    private lazy var button: UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 12
        button.setTitle("Нажми на меня", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton()
        self.view.backgroundColor = UIColor.white
    }
    
    func createButton() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func buttonAction(sender:UIButton) {
        print("Вызываем экшен команду")
        let alert = UIAlertController(title: myTitle, message: myMessage, preferredStyle: .alert)
        let buttonDefault = UIAlertAction(title: "Кабан", style: .default) { _ in
            print("Нажали на кабана")
        }
        let buttonCancel = UIAlertAction(title: "Свинья", style: .cancel) {_ in
            print("Нажали на свинью")
        }
        alert.addAction(buttonCancel)
        alert.addAction(buttonDefault)
        self.present(alert, animated: true) {
            print("Отображаем алерт")
        }
    }
}
