//
//  Theme.swift
//  Navigation
//
//  Created by Shalopay on 15.12.2022.
//

import Foundation
import  UIKit

class Theme {
    
    //MARK: Theme color for label
    static var appleLableTextColor = UIColor { (traitCollection) -> UIColor in
        return traitCollection.userInterfaceStyle == .light ? UIColor.black : UIColor.white
    }
    
    //MARK: Theme color for rightImage
    static var appleRightColor = UIColor { (traitCollection) -> UIColor in
        return traitCollection.userInterfaceStyle == .light ? UIColor.black : UIColor.white
    }
    
    //MARK: Theme color for button
    static var appleButtonBackGroundColor = UIColor { (traitCollection) -> UIColor in
        return traitCollection.userInterfaceStyle == .light ? #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1) : UIColor.white
    }
    static var appleButtonTextColor = UIColor { (traitCollection) -> UIColor in
        return traitCollection.userInterfaceStyle == .light ? UIColor.white : UIColor.black
    }
    
    //MARK: Theme color for textfield
    static var appleTextFieldTextColor = UIColor { (traitCollection) -> UIColor in
        traitCollection.userInterfaceStyle == .light ? UIColor.black : UIColor.white
    }
    static var appleTextFieldBackGroundColor = UIColor { (traitCollection) -> UIColor in
        traitCollection.userInterfaceStyle == .light ? UIColor.white : UIColor.systemGray6
    }
    static var appleTextFieldTextPlaceHolderColor = UIColor { (traitCollection) -> UIColor in
        traitCollection.userInterfaceStyle == .light ? UIColor.systemGray3 : UIColor.white
    }
    
    //MARK: Theme color for ViewController background
    static var appleViewBackGroundColorController = UIColor { (traitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .light {
            return UIColor(named: "ColorTheme")!
        } else {
            return UIColor(named: "ColorTheme")!
        }
    }
}

extension UIColor {
    static func viewColorController(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
