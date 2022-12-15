//
//  LocalizableShortCut.swift
//  Navigation
//
//  Created by Shalopay on 13.12.2022.
//

import Foundation
postfix operator ~
postfix func ~ (String: String) -> String {
    return NSLocalizedString(String, comment: "")
}
