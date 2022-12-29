//
//  CustomButton.swift
//  Navigation
//
//  Created by Shalopay on 02.09.2022.
//

import UIKit

class CustomButton: UIButton {
    var action: (() -> Void)?
    init(title: String? = nil, titleColor: UIColor? = nil) {
            super.init(frame: .zero)
            self.setTitle(title, for: .normal)
            self.setTitleColor(titleColor, for: .normal)
            self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func buttonTapped() {
        action?()
    }
}


