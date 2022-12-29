//
//  LogInViewController.swift
//  Navigation
//
//  Created by Shalopay on 10.06.2022.
//

import UIKit
import RealmSwift

class LogInViewController: UIViewController {
    let localAuthorizationService = LocalAuthorizationService()
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
        emailTextField.placeholder = "emailTextFieldPlaceholder".localized
        emailTextField.tag = 0
        emailTextField.delegate = self
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        emailTextField.leftViewMode = .always
        emailTextField.keyboardType = .emailAddress
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.font = .systemFont(ofSize: 16)
        emailTextField.textColor = Theme.appleTextFieldTextColor
        emailTextField.tintColor = UIColor.lightText
        emailTextField.autocapitalizationType = .none
        emailTextField.backgroundColor = .systemGray6
        return emailTextField
    }()
    
    private lazy var passTextField: UITextField = {
       let passTextField = UITextField()
        passTextField.placeholder = "passTextFieldPlaceholder".localized
        passTextField.tag = 1
        passTextField.delegate = self
        passTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passTextField.frame.height))
        passTextField.leftViewMode = .always
        passTextField.layer.borderWidth = 0.5
        passTextField.layer.borderColor = UIColor.lightGray.cgColor
        passTextField.font = .systemFont(ofSize: 16)
        passTextField.textColor = Theme.appleTextFieldTextColor
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
        let myButton = CustomButton(title: "myButton.title".localized, titleColor: .white)
        myButton.clipsToBounds = true
        myButton.setTitleColor(Theme.appleButtonTextColor, for: .normal)
        myButton.backgroundColor = Theme.appleButtonBackGroundColor
        myButton.layer.cornerRadius = 10
        return myButton
    }()
    
    private lazy var getPassButton: CustomButton = {
        let getPassButton = CustomButton(title: "getPassButton.title".localized, titleColor: .white)
        getPassButton.clipsToBounds = true
        getPassButton.setTitleColor(Theme.appleButtonTextColor, for: .normal)
        getPassButton.backgroundColor = Theme.appleButtonBackGroundColor
        getPassButton.layer.cornerRadius = 10
        return getPassButton
    }()
    private lazy var enterFaceIDorTouchID: CustomButton = {
        let button = CustomButton(title: "enterFaceIDorTouchIDtext".localized, titleColor: .white)
        button.clipsToBounds = true
        button.setTitleColor(Theme.appleButtonTextColor, for: .normal)
        button.backgroundColor = Theme.appleButtonBackGroundColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToTabBarVC), for: .touchUpInside)
        return button
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
        view.backgroundColor = Theme.appleViewBackGroundColorController
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
        localAuthorizationService.canEvaluate { (success, type, _) in
            guard success else {
                enterFaceIDorTouchID.isHidden = true
                return
            }
            switch type {
            case .faceID:
                enterFaceIDorTouchID.isHidden = false
                let image = UIImage(systemName: "faceid")
                enterFaceIDorTouchID.tintColor = Theme.appleImageFaceId
                enterFaceIDorTouchID.setImage(image, for: .normal)
            case .touchID:
                enterFaceIDorTouchID.isHidden = false
                let image = UIImage(systemName: "touchid")
                enterFaceIDorTouchID.tintColor = Theme.appleImageFaceId
                enterFaceIDorTouchID.setImage(image, for: .normal)
            case .none:
                enterFaceIDorTouchID.isHidden = true
            case .unknown:
                enterFaceIDorTouchID.isHidden = true
            }
        }
    }
    
    
    private func setupTimer(_ interval: Double, repeats: Bool) {
        timer = Timer.scheduledTimer(timeInterval: interval,
                             target: self,
                             selector: #selector(wakeUpAlertController),
                             userInfo: nil,
                             repeats: repeats)
    }
    
    @objc private func goToTabBarVC(sender: CustomButton) {
        localAuthorizationService.authorizeIfPossible { (success) in
            if success {
                print("OKEY")
                self.showTabBarController()
            } else {
                print("NOY")
            }
        }
    }
    
    @objc func wakeUpAlertController() {
        let title = "wakeUpAlertController.title".localized
        let titleRange = (title as NSString).range(of: title)
        let titleAttribute = NSMutableAttributedString.init(string: title)
        titleAttribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black , range: titleRange)
        titleAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: 25)!, range: titleRange)
        
        let message = "wakeUpAlertController.message".localized
        let messageRange = (message as NSString).range(of: message)
        let messageAttribute = NSMutableAttributedString.init(string: message)
        messageAttribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: messageRange)
        messageAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Helvetica", size: 17)!, range: messageRange)
        let alert = UIAlertController(title: "", message: "",  preferredStyle: .actionSheet)
        alert.setValue(titleAttribute, forKey: "attributedTitle")
        alert.setValue(messageAttribute, forKey: "attributedMessage")

        let okAction = UIAlertAction(title: "wakeUpAlertControllerOkAction".localized, style: .destructive) {_ in
            self.timer?.invalidate()
            self.getPassword()

        }
        let noAction = UIAlertAction(title: "wakeUpAlertControllerNoAction".localized, style: .cancel) { alertAction in
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
        scrollView.addSubview(enterFaceIDorTouchID)
        passTextField.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
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
            enterFaceIDorTouchID.topAnchor.constraint(equalTo: getPassButton.bottomAnchor, constant: 20),
            enterFaceIDorTouchID.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            enterFaceIDorTouchID.heightAnchor.constraint(equalToConstant: 50),
            enterFaceIDorTouchID.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            enterFaceIDorTouchID.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
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
                self.userDefault.setValue(login, forKey: "login")
                self.userDefault.setValue(password, forKey: "password")
                self.realmService.createCategory(name: "Users")
                let newUser = NewUsers()
                newUser.login = login
                newUser.password = password
                let allCategory = self.realm.objects(Category.self)
                allCategory.forEach { (category) in
                    guard category.categoryName == "Users" else {
                        self.realmService.createCategory(name: "Users")
                        return
                    }
                    self.realmService.addUser(categoryId: category.id, user: newUser)
                }
                self.showTabBarController()
            } else {
                print("Что то пошло не так")
            }
        }
        getPassButton.action = {
            self.getPassword()
        }
    }
    private func showTabBarController() {
        let tabBarVC = UITabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.modalTransitionStyle = .flipHorizontal
        let feedVC = FeedViewController()
        feedVC.tabBarItem.title = NSLocalizedString("tabBarItem.titleProfileFeed", comment: "")
        feedVC.tabBarItem.image = UIImage(systemName: "book")
        feedVC.tabBarItem.tag = 0
        let profilVC = ProfileViewController()
        profilVC.tabBarItem.title = NSLocalizedString("tabBarItem.titleProfile", comment: "")
        profilVC.tabBarItem.image = UIImage(systemName: "person.crop.square")
        profilVC.tabBarItem.tag = 3
        let favoriteVC = FavoriteViewController()
        favoriteVC.tabBarItem.title = NSLocalizedString("tabBarItem.titleSaved", comment: "")
        favoriteVC.tabBarItem.image = UIImage(systemName: "star")
        favoriteVC.tabBarItem.tag = 4
        let feedNC = UINavigationController(rootViewController: feedVC)
        let profilNC = UINavigationController(rootViewController: profilVC)
        let favoriteNC = UINavigationController(rootViewController: favoriteVC)
        tabBarVC.setViewControllers([feedNC, profilNC, favoriteNC], animated: true)
        tabBarVC.selectedViewController = profilNC
        self.present(tabBarVC, animated: true)
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


