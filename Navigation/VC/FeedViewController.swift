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
    
    private lazy var buttonOne: CustomButton = {
        let buttonOne = CustomButton(title: "buttonOne.title".localized, titleColor: .lightGray)
        buttonOne.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        buttonOne.tag = 0
        buttonOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return buttonOne
    }()
    
    private lazy var buttonTwo: CustomButton = {
        let buttonOne = CustomButton(title: NSLocalizedString("buttonTwo.title", comment: ""), titleColor: .lightGray)
        buttonOne.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        buttonOne.tag = 1
        buttonOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return buttonOne
    }()
    private lazy var checkGuessButton: CustomButton = {
        let checkGuessButton = CustomButton(title: NSLocalizedString("checkGuessButton.title", comment: ""), titleColor: .black)
        checkGuessButton.backgroundColor = .systemBlue
        checkGuessButton.layer.cornerRadius = 10
        checkGuessButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return checkGuessButton
    }()
     
    private lazy var wordTextField: CustomTextField = {
        let wordTextField = CustomTextField(font: UIFont.systemFont(ofSize: 16), placeholder: NSLocalizedString("wordTextField.placeholder", comment: ""), borderColor: UIColor.lightGray.cgColor, borderWidth: 0.5)
        wordTextField.backgroundColor = .systemGray
        wordTextField.layer.cornerRadius = 5
        return wordTextField
    }()
        
    private lazy var labelCheck: UILabel = {
       let labelCheck = UILabel()
        //labelCheck.textColor = .black
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
        view.backgroundColor = UIColor.gray
        setupVerticalStack()
        actionButton()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        view.addGestureRecognizer(tap)
        setupThemeStyle(button: [buttonOne,buttonTwo,checkGuessButton], textfiled: wordTextField)
    }
    
    private func setupThemeStyle(button: [UIButton], textfiled: UITextField) {
        button.forEach { (button) in
            button.setTitleColor(Theme.appleTintTextColor, for: .normal)
        }
        textfiled.textColor = Theme.appleTintTextColor
        textfiled.attributedPlaceholder = NSAttributedString(string: "Введите секретное слово", attributes: [NSAttributedString.Key.foregroundColor : Theme.appleTintTextColor])
        
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
            postVC.myTitle = NSLocalizedString("actionButton.buttonOne.myTitle", comment: "")
            postVC.myMessage = NSLocalizedString("actionButton.buttonOne.Message", comment: "")
            self.navigationController?.pushViewController(postVC, animated: true)
        }
        buttonTwo.action = {
            guard self.buttonTwo.tag == 1 else { return }
            let postVC = PostViewController()
            postVC.myTitle = NSLocalizedString("actionButton.buttonTwe.myTitle", comment: "")
            postVC.myMessage = NSLocalizedString("actionButton.buttonTwe.Message", comment: "")
            self.navigationController?.pushViewController(postVC, animated: true)
        }
        checkGuessButton.action = {
            guard let word = self.wordTextField.text else { return }
                let feedModel = FeedModel()
                let check = feedModel.check(word: word)
                print(check)
                check ? self.labelShow(text: NSLocalizedString("checkGuessButton.labelShowTrue", comment: ""), color: .green) : self.labelShow(text: NSLocalizedString("checkGuessButton.labelShowFalse", comment: ""), color: .systemRed)
        }
    }
        
}

