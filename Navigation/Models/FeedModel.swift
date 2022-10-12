//
//  FeedModel.swift
//  Navigation
//
//  Created by Shalopay on 06.09.2022.
//

import Foundation

struct FeedModel {
    private var secretWord: String = "ops"
    
    func check(word: String) -> Bool {
        if secretWord == word { return true }
        return false
    }
    
}
