//
//  FeedModel.swift
//  Navigation
//
//  Created by Shalopay on 06.09.2022.
//

import Foundation

struct FeedModel {
    var secretWord: String = "ops"
    
    func check(word: String) -> Bool {
        guard self.secretWord == word else { return false }
        return true
    }
}
