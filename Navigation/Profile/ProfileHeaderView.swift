//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Shalopay on 27.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private var statusText: String?
    
    private lazy var avaImage: UIImageView = {
        let avaImage = UIImageView()
        let image = UIImage(named: "cat")
        avaImage.backgroundColor = .white
        avaImage.layer.cornerRadius = 40
        avaImage.image = image
        avaImage.contentMode = .scaleAspectFill
        avaImage.clipsToBounds = true
        avaImage.layer.borderWidth = 3
        avaImage.layer.borderColor = .none
        avaImage.translatesAutoresizingMaskIntoConstraints = false
        return avaImage
    }()
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Hipster Cat"
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
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
    private lazy var buttonStatus: UIButton = {
        let buttonStatus = UIButton(type: .system)
        
        buttonStatus.backgroundColor = UIColor.blue
        buttonStatus.layer.shadowOffset = CGSize(width: 4, height: 4)
        buttonStatus.layer.cornerRadius = 4
        buttonStatus.layer.shadowOpacity = 0.7
        buttonStatus.layer.cornerRadius = 15
        buttonStatus.setTitle("Show Status", for: .normal)
        buttonStatus.setTitleColor(.white, for: .normal)
        buttonStatus.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        buttonStatus.translatesAutoresizingMaskIntoConstraints = false
        buttonStatus.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        return buttonStatus
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(avaImage)
        NSLayoutConstraint.activate([
            avaImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avaImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avaImage.widthAnchor.constraint(equalToConstant: 80),
            avaImage.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 27),
            nameLabel.leadingAnchor.constraint(equalTo: avaImage.trailingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -20)
        ])

        addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.leadingAnchor.constraint(equalTo: avaImage.trailingAnchor,constant: 25),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        addSubview(statusTextField)
        NSLayoutConstraint.activate([
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor,constant: 5),
            statusTextField.leadingAnchor.constraint(equalTo: avaImage.trailingAnchor,constant: 25),
            statusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])

        addSubview(buttonStatus)
        NSLayoutConstraint.activate([
            buttonStatus.topAnchor.constraint(equalTo: statusTextField.bottomAnchor,constant: 16),
            buttonStatus.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 16),
            buttonStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -16),
            buttonStatus.heightAnchor.constraint(equalToConstant: 50)
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
