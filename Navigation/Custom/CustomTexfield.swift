//
//  CustomTexfield.swift
//  Navigation
//
//  Created by Shalopay on 06.09.2022.
//

import UIKit

class CustomTextField: UITextField {
    
    init(font: UIFont, placeholder: String, borderColor: CGColor, borderWidth: CGFloat) {
        super.init(frame: .zero)
        self.font = font
        self.placeholder = placeholder
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.translatesAutoresizingMaskIntoConstraints = false
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
