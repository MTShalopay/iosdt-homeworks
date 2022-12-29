//
//  Extension+Localizable.swift
//  Navigation
//
//  Created by Shalopay on 15.12.2022.
//

import Foundation
extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
//"statusTextField.Placeholder".localized
