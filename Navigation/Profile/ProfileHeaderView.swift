//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Shalopay on 27.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private var statusText: String?
    
    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(named: "cat")
        avatarImageView.layer.cornerRadius = 40
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        return avatarImageView
    }()
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.text = "Hipster Cat"
        fullNameLabel.textAlignment = .left
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        fullNameLabel.textColor = .black
        return fullNameLabel
    }()
    private lazy var statusLabel: UILabel = {
       let statusLabel = UILabel()
        statusLabel.text = "Waiting for something..."
        statusLabel.font = UIFont(name: "regular", size: 14)
        statusLabel.textColor = .gray
        statusLabel.textAlignment = .left
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    private lazy var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.placeholder = "Введите статус"
        statusTextField.textAlignment = .center
        statusTextField.font = UIFont(name: "regular", size: 15)
        statusTextField.textColor = .black
        statusTextField.backgroundColor = .white
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.cornerRadius = 12
        statusTextField.delegate = self
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.addTarget(self, action: #selector(statusTextChanged(textField:)), for: .editingChanged)
        return statusTextField
    }()
    private lazy var setStatusButton: UIButton = {
        let setStatusButton = UIButton(type: .system)
        
        setStatusButton.backgroundColor = UIColor.blue
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.layer.cornerRadius = 15
        setStatusButton.setTitle("Show Status", for: .normal)
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        return setStatusButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightText
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 25),
            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -20),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 25),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor,constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor,constant: 5),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 25),
            statusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor,constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func buttonPressed(sender:UIButton) {
        if statusText != nil {
            statusLabel.text = statusText
            statusTextField.text = ""
            statusTextField.placeholder = "Введите статус"
        } else {
            statusTextField.placeholder = "Поле пустым не возможно"
        }
    }
    @objc func statusTextChanged(textField: UITextField) {
        statusText = textField.text
    }
}
extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
