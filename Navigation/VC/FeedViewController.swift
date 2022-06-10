//
//  FeedViewController.swift
//  Navigation
//
//  Created by Shalopay on 27.05.2022.
//

import UIKit

class FeedViewController: UIViewController {
    var post = Post(title: "Мой личный пост")
    
    private lazy var verticalStack: UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 10
        verticalStack.distribution = .fillEqually
        verticalStack.layer.cornerRadius = 10
        verticalStack.clipsToBounds = true
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        return verticalStack
    }()
    
    private lazy var buttonOne: UIButton = {
        let buttonOne = UIButton(type: .system)
        buttonOne.tag = 0
        buttonOne.backgroundColor = UIColor.blue
        buttonOne.setTitle("buttonOne", for: .normal)
        buttonOne.setTitleColor(.lightGray, for: .normal)
        buttonOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        buttonOne.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return buttonOne
    }()
    
    private lazy var buttonTwo: UIButton = {
        let buttonTwo = UIButton(type: .system)
        buttonOne.tag = 1
        buttonTwo.backgroundColor = UIColor.blue
        buttonTwo.setTitle("buttonTwo", for: .normal)
        buttonTwo.setTitleColor(.lightGray, for: .normal)
        buttonTwo.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        buttonTwo.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return buttonTwo
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "book"), tag: 0)
        view.backgroundColor = UIColor.gray
        setupVerticalStack()

    }
    private func setupVerticalStack() {
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(buttonOne)
        verticalStack.addArrangedSubview(buttonTwo)
        NSLayoutConstraint.activate([
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            verticalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            verticalStack.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    @objc func buttonAction(sender: UIButton) {
        print("Переходим на пост \(post.title)")
        switch sender.tag {
        case 0:
            print("\(sender.tag)")
            let postVC = PostViewController()
            postVC.title = post.title
            self.navigationController?.pushViewController(postVC, animated: true)
        case 1:
            print("\(sender.tag)")
            let postVC = PostViewController()
            postVC.title = post.title
            self.navigationController?.pushViewController(postVC, animated: true)
        default:
            print("ops")
        }
    }
}
