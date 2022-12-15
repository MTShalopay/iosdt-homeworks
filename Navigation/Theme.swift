//
//  Theme.swift
//  Navigation
//
//  Created by Shalopay on 15.12.2022.
//

import Foundation
import  UIKit
class Theme {
    static var appleTintTextColor = UIColor { (traitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .light {
            return UIColor.white
        } else {
            return UIColor.black
        }
    }
    static var appleNavigationBarTintColor = UIColor { (traitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .light {
            return UIColor.black
        } else {
            return UIColor.white
            }
    }
}
