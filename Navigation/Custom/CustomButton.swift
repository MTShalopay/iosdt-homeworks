//
//  CustomButton.swift
//  Navigation
//
//  Created by Shalopay on 02.09.2022.
//

import UIKit

class CustomButton: UIButton {
    var action: (() -> Void)?
    private var buttonCustomState: UIControl.State
    private var buttonCustomType: UIButton.ButtonType
    private var buttonCustomTag: Int?
    private var buttonCustomBackground: UIColor
    private var buttonCustomSetTitle: String
    private var buttonCustomSetTitleColor: UIColor
    private var buttonCustomTitleFont: UIFont
    private var buttonCustomCornerRadius: CGFloat
    init(buttonCustomState: UIControl.State, buttonCustomType: UIButton.ButtonType, buttonCustomTag: Int?, buttonCustomBackground: UIColor, buttonCustomSetTitle: String, buttonCustomSetTitleColor: UIColor, buttonCustomTitleFont: UIFont, buttonCustomCornerRadius: CGFloat) {
        self.buttonCustomType = buttonCustomType
        self.buttonCustomTag = buttonCustomTag
        self.buttonCustomBackground = buttonCustomBackground
        self.buttonCustomSetTitle = buttonCustomSetTitle
        self.buttonCustomSetTitleColor = buttonCustomSetTitleColor
        self.buttonCustomTitleFont = buttonCustomTitleFont
        self.buttonCustomState = buttonCustomState
        self.buttonCustomCornerRadius = buttonCustomCornerRadius
        super.init(frame: .zero)
        self.tag = buttonCustomTag ?? 0
        self.setTitle(buttonCustomSetTitle, for: buttonCustomState)
        self.setTitleColor(buttonCustomSetTitleColor, for: buttonCustomState)
        self.titleLabel?.font = buttonCustomTitleFont
        self.backgroundColor = buttonCustomBackground
        self.layer.cornerRadius = buttonCustomCornerRadius
        self.clipsToBounds = true
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func buttonTapped() {
        action?()
    }
}


