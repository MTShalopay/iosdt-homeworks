//
//  FeedViewController.swift
//  Navigation
//
//  Created by Shalopay on 27.05.2022.
//

import UIKit

class FeedViewController: UIViewController {
    var post = Post(title: "Мой личный пост")
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 12
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "book"), tag: 0)
        view.backgroundColor = UIColor.gray
        createButton()

    }
    private func createButton() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -100),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc func buttonAction(sender: UIButton) {
        print("Переходим на пост \(post.title)")
        let postVC = PostViewController()
        postVC.title = post.title
        self.navigationController?.pushViewController(postVC, animated: true)
        
    }
}
