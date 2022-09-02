//
//  LogInViewController.swift
//  Navigation
//
//  Created by Shalopay on 10.06.2022.
//

import UIKit

class LogInViewController: UIViewController {
     var loginDelegate: LoginViewControllerDelegate?
    
    private let currentUserService = CurrentUserService()
    private let testUserService = TestUserService()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var logoImageView: UIImageView = {
       let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    private lazy var emailTextField: UITextField = {
       let emailTextField = UITextField()
        emailTextField.placeholder = "Login"
        emailTextField.tag = 0
        emailTextField.delegate = self
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        emailTextField.leftViewMode = .always
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.font = .systemFont(ofSize: 16)
        emailTextField.textColor = .black
        emailTextField.tintColor = UIColor.lightText
        emailTextField.autocapitalizationType = .none
        emailTextField.backgroundColor = .systemGray6
        return emailTextField
    }()
    
    private lazy var passTextField: UITextField = {
       let passTextField = UITextField()
        passTextField.placeholder = "Password"
        passTextField.tag = 1
        passTextField.delegate = self
        passTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passTextField.frame.height))
        passTextField.leftViewMode = .always
        passTextField.layer.borderWidth = 0.5
        passTextField.layer.borderColor = UIColor.lightGray.cgColor
        passTextField.font = .systemFont(ofSize: 16)
        passTextField.textColor = .black
        passTextField.tintColor = UIColor.lightText
        passTextField.autocapitalizationType = .none
        passTextField.isSecureTextEntry = true
        passTextField.backgroundColor = .systemGray6
        return passTextField
    }()
    
    private lazy var verticalStack: UIStackView = {
       let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 1
        verticalStack.distribution = .fillEqually
        verticalStack.layer.cornerRadius = 10
        verticalStack.clipsToBounds = true
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        return verticalStack
    }()
    
    private lazy var myButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.layer.cornerRadius = 10
        myButton.setTitle("Log In", for: .normal)
        myButton.setImage(UIImage(named: "blue_pixel"), for: .normal)
        myButton.setTitleColor(.white, for: .normal)
        myButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        myButton.backgroundColor = .blue
        myButton.addTarget(self, action: #selector(logIn(sender:)), for: .touchUpInside)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        return myButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupGestures()
        setupViews()
        stateMyButton(sender: myButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func setupViews() {
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(logoImageView)
        verticalStack.addArrangedSubview(emailTextField)
        verticalStack.addArrangedSubview(passTextField)
        scrollView.addSubview(verticalStack)
        scrollView.addSubview(myButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
                                     logoImageView.heightAnchor.constraint(equalToConstant: 120),
                                     logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            verticalStack.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            verticalStack.heightAnchor.constraint(equalToConstant: 100),
            myButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor,constant: 16),
            myButton.heightAnchor.constraint(equalToConstant: 50),
            myButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            myButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
                                     
        ])
    }
    @objc func dissmiskeyboard() {
        view.endEditing(true)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
    }
    @objc func logIn(sender: UIButton) {
        guard let loginDelegate = loginDelegate, let login = emailTextField.text, let password = passTextField.text else { return }
        
        if loginDelegate.check(login: login, password: password) {
            let profileVC = ProfileViewController()
            self.navigationController?.pushViewController(profileVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Что то подсказывает что логина: \(emailTextField.text!) с паролем: \(passTextField.text!) нет в БД", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Понял принял", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
            
//        print("entered")
//        #if DEBUG
//        let user = currentUserService.userNew
//        #else
//        let user = testUserService.testUser
//        #endif
//
//        guard emailTextField.text == user.login, passTextField.text == user.password else {
//            let alert = UIAlertController(title: "Ошибка", message: "Что то подсказывает что логина: \(emailTextField.text!) с паролем: \(passTextField.text!) нет в БД", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Понял принял", style: .default, handler: nil))
//            self.present(alert, animated: true)
//            return
//        }
//
//        let profileVC =  ProfileViewController()
//        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let myButtonPointY =  myButton.frame.origin.y + myButton.frame.height
            let keyboardOriginY = scrollView.frame.height - keyboardHeight
            let yOffset = keyboardOriginY < myButtonPointY ? myButtonPointY - keyboardOriginY + 16 : 0
//            print("scrollView.frame.height \(scrollView.frame.height), myButtonPointY \(myButtonPointY), keyboardOriginY \(keyboardOriginY)")
            scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    @objc private func didHideKeyboard(_ notification: Notification) {
        self.dissmiskeyboard()
    }
    
    private func setupGestures() {
    let tapDissmis = UITapGestureRecognizer(target: self, action: #selector(dissmiskeyboard))
    view.addGestureRecognizer(tapDissmis)
    }
    func stateMyButton(sender: UIButton) {
        switch sender.state {
        case .normal:
            sender.alpha = 1.0
        case .selected:
            sender.alpha = 0.8
        case .highlighted:
            sender.alpha = 0.8
        default:
            sender.alpha = 1.0
        }
    }
}
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}


