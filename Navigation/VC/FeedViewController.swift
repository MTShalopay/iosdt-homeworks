//
//  FeedViewController.swift
//  Navigation
//
//  Created by Shalopay on 27.05.2022.
//

import UIKit

class FeedViewController: UIViewController {
    //var post = Post(title: "Мой личный пост")
    
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
    
    private lazy var buttonOne = CustomButton(buttonCustomState: .normal,
                                              buttonCustomType: .system,
                                              buttonCustomTag: 0,
                                              buttonCustomBackground: .blue,
                                              buttonCustomSetTitle: "ButtonOne",
                                              buttonCustomSetTitleColor: .lightGray,
                                              buttonCustomTitleFont: UIFont.boldSystemFont(ofSize: 24), buttonCustomCornerRadius: 0)
    
    private lazy var buttonTwo = CustomButton(buttonCustomState: .normal,
                                              buttonCustomType: .system,
                                              buttonCustomTag: 1,
                                              buttonCustomBackground: .blue,
                                              buttonCustomSetTitle: "ButtonTwo",
                                              buttonCustomSetTitleColor: .lightGray,
                                              buttonCustomTitleFont: UIFont.boldSystemFont(ofSize: 24), buttonCustomCornerRadius: 0)
    
    private lazy var checkGuessButton = CustomButton(buttonCustomState: .normal,
                                                     buttonCustomType: .system,
                                                     buttonCustomTag: 0,
                                                     buttonCustomBackground: .white,
                                                     buttonCustomSetTitle: "checkGuessButton",
                                                     buttonCustomSetTitleColor: .black,
                                                     buttonCustomTitleFont: UIFont.boldSystemFont(ofSize: 20),
                                                     buttonCustomCornerRadius: 10)
    
    private lazy var wordTextField = CustomTextField(placeholder: "Введите секретное слово",
                                                     tag: 0,
                                                     borderWidth: 0.5,
                                                     borderColor: UIColor.lightGray.cgColor,
                                                     font: UIFont.systemFont(ofSize: 16),
                                                     textColor: .black,
                                                     tintColor: UIColor.lightText,
                                                     autocapitalizationType: .none,
                                                     isSecureTextEntry: false,
                                                     backgroundColor: .systemGray6,
                                                     translatesAutoresizingMaskIntoConstraints: false,
                                                     cornerRadius: 5)
    private lazy var labelCheck: UILabel = {
       let labelCheck = UILabel()
        labelCheck.textColor = .black
        labelCheck.backgroundColor = .systemRed
        labelCheck.layer.cornerRadius = 10
        labelCheck.textAlignment = .center
        labelCheck.font = UIFont.boldSystemFont(ofSize: 20)
        labelCheck.clipsToBounds = true
        labelCheck.alpha = 0
        labelCheck.translatesAutoresizingMaskIntoConstraints = false
        return labelCheck
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "book"), tag: 0)
        view.backgroundColor = UIColor.gray
        setupVerticalStack()
        actionButton()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        view.addGestureRecognizer(tap)

    }
    @objc func dissmisKeyboard() {
        self.view.endEditing(true)
    }
    
    private func labelShow(text: String, color: UIColor) {
        UIView.animate(withDuration: 0.5) {
            self.labelCheck.text = text
            self.labelCheck.textColor = .black
            self.labelCheck.backgroundColor = color
            self.labelCheck.alpha = 1
        }
    }
    
    private func setupVerticalStack() {
        view.addSubview(checkGuessButton)
        view.addSubview(wordTextField)
        view.addSubview(labelCheck)
        checkGuessButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(buttonOne)
        verticalStack.addArrangedSubview(buttonTwo)
        NSLayoutConstraint.activate([
            wordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            wordTextField.heightAnchor.constraint(equalToConstant: 25),
            wordTextField.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            checkGuessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkGuessButton.topAnchor.constraint(equalTo: wordTextField.bottomAnchor, constant: 20),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 25),
            checkGuessButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            labelCheck.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 10),
            labelCheck.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelCheck.heightAnchor.constraint(equalToConstant: 25),
            labelCheck.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            verticalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            verticalStack.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    private func actionButton() {
        buttonOne.action = {
            guard self.buttonOne.tag == 0 else { return }
            let postVC = PostViewController()
            self.navigationController?.pushViewController(postVC, animated: true)
        }
        buttonTwo.action = {
            guard self.buttonTwo.tag == 1 else { return }
            let postVC = PostViewController()
            self.navigationController?.pushViewController(postVC, animated: true)
        }
        checkGuessButton.action = {
            if let word = self.wordTextField.text {
                let feedModel = FeedModel()
                let check = feedModel.check(word: word)
                print(check)
                check ? self.labelShow(text: "Верно", color: .green) : self.labelShow(text: "Не верно", color: .systemRed)
            }
        }
    }
}
