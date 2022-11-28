//
//  LogInViewController.swift
//  Navigation
//
//  Created by Shalopay on 10.06.2022.
//

import UIKit
import RealmSwift

class LogInViewController: UIViewController {
    var users: Results<Category>?
    let realmService = RealmService()
    let realm = try! Realm()
    var loginDelegate: LoginViewControllerDelegate?
    let userDefault = UserDefaults.standard
    private var timer: Timer?
    private let currentUserService = CurrentUserService()
    private let testUserService = TestUserService()
    private let brutForceService = BrutForceService()
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
        emailTextField.keyboardType = .emailAddress
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
    private lazy var myButton: CustomButton = {
        let myButton = CustomButton(title: "LOG IN", titleColor: .white)
        myButton.clipsToBounds = true
        myButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        myButton.layer.cornerRadius = 10
        return myButton
    }()
    
    private lazy var getPassButton: CustomButton = {
        let getPassButton = CustomButton(title: "Подобрать пароль", titleColor: .white)
        getPassButton.clipsToBounds = true
        getPassButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        getPassButton.layer.cornerRadius = 10
        return getPassButton
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupGestures()
        setupViews()
        stateMyButton(sender: myButton)
        actionButton()
        /*
         /Users/shalopay/Library/Developer/CoreSimulator/Devices/F9D2C937-826A-4E28-9610-4FC9A215EE7F/data/Containers/Data/Application/7452F94E-8FDF-4225-8840-F8D8287D35C3/Documents/
         */
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
        //setupTimer(10, repeats: false)
    }
    
    
    private func setupTimer(_ interval: Double, repeats: Bool) {
        timer = Timer.scheduledTimer(timeInterval: interval,
                             target: self,
                             selector: #selector(wakeUpAlertController),
                             userInfo: nil,
                             repeats: repeats)
    }
    
    @objc func wakeUpAlertController() {
        let title = "Забыли пароль?"
        let titleRange = (title as NSString).range(of: title)
        let titleAttribute = NSMutableAttributedString.init(string: title)
        titleAttribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black , range: titleRange)
        titleAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: 25)!, range: titleRange)
        
        let message = "Пароль можно подобрать, с вашего разрешения. Помочь?"
        let messageRange = (message as NSString).range(of: message)
        let messageAttribute = NSMutableAttributedString.init(string: message)
        messageAttribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: messageRange)
        messageAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Helvetica", size: 17)!, range: messageRange)
        let alert = UIAlertController(title: "", message: "",  preferredStyle: .actionSheet)
        alert.setValue(titleAttribute, forKey: "attributedTitle")
        alert.setValue(messageAttribute, forKey: "attributedMessage")

        let okAction = UIAlertAction(title: "Да", style: .destructive) {_ in
            self.timer?.invalidate()
            self.getPassword()

        }
        let noAction = UIAlertAction(title: "Не надо", style: .cancel) { alertAction in
            self.timer?.invalidate()
        }
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        verticalStack.addArrangedSubview(emailTextField)
        verticalStack.addArrangedSubview(passTextField)
        scrollView.addSubview(verticalStack)
        scrollView.addSubview(myButton)
        scrollView.addSubview(getPassButton)
        passTextField.addSubview(activityIndicator)
        
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
            myButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            getPassButton.topAnchor.constraint(equalTo: myButton.bottomAnchor, constant: 20),
            getPassButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            getPassButton.heightAnchor.constraint(equalToConstant: 50),
            getPassButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            getPassButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            activityIndicator.centerYAnchor.constraint(equalTo: passTextField.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: passTextField.centerXAnchor)
                                     
        ])
    }
    @objc func dissmiskeyboard() {
        view.endEditing(true)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
    }
    private func getPassword() {
        self.passTextField.isSecureTextEntry = true
        self.passTextField.text = "qaz"
        let queue = DispatchQueue(label: "ru.IOSInt-homeworks.9", attributes: .concurrent)
        let workItem = DispatchWorkItem {
            self.brutForceService.bruteForce(passwordToUnlock: "qaz")
        }
        self.activityIndicator.startAnimating()
        queue.async(execute: workItem)
        workItem.notify(queue: .main) {
            self.passTextField.isSecureTextEntry = false
            self.activityIndicator.stopAnimating()
        }
    }
    private func actionButton() {
        myButton.action = {
            guard let login = self.emailTextField.text, let password = self.passTextField.text else { return }
            if !login.isEmpty, !password.isEmpty {
                let allCategory = self.realm.objects(Category.self)
                self.userDefault.setValue(login, forKey: "login")
                self.userDefault.setValue(password, forKey: "password")
                let newUser = NewUsers()
                newUser.login = login
                newUser.password = password
                self.realmService.addUser(categoryId: allCategory[0].id, user: newUser)
                print(allCategory)
                let profileVC = ProfileViewController()
                self.navigationController?.pushViewController(profileVC, animated: true)
            } else {
                print("Что то пошло не так")
            }
//            guard let loginDelegate = self.loginDelegate, let login = self.emailTextField.text, let password = self.passTextField.text else { return }
//
//            if loginDelegate.check(login: login, password: password) {
//                let profileVC = ProfileViewController()
//                self.navigationController?.pushViewController(profileVC, animated: true)
//            } else {
//                let alert = UIAlertController(title: "Ошибка", message: "Что то подсказывает что логина: \(self.emailTextField.text!) с паролем: \(self.passTextField.text!) нет в БД", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Понял принял", style: .default, handler: nil))
//                self.present(alert, animated: true)
//            }
        }
        getPassButton.action = {
            self.getPassword()
        }
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
    private func stateMyButton(sender: UIButton) {
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


