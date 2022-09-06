//
//  CustomTexfield.swift
//  Navigation
//
//  Created by Shalopay on 06.09.2022.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String?, tag: Int?, borderWidth: CGFloat, borderColor: CGColor, font: UIFont, textColor: UIColor, tintColor: UIColor, autocapitalizationType: UITextAutocapitalizationType, isSecureTextEntry: Bool, backgroundColor: UIColor, translatesAutoresizingMaskIntoConstraints: Bool, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.tag = tag ?? 0
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.font = font
        self.textColor = textColor
        self.tintColor = tintColor
        self.autocapitalizationType = autocapitalizationType
        self.isSecureTextEntry = isSecureTextEntry
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
