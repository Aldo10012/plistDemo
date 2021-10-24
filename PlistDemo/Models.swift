//
//  Models.swift
//  PlistDemo
//
//  Created by Alberto Dominguez on 10/24/21.
//  Copyright © 2021 Adriana González Martínez. All rights reserved.
//

import Foundation

struct Score: Decodable {
    let name: String
    let score: Int
}

enum UserDefaultKey: String {
    case characterWithHighestScore = "characterNameWithHighestScore"
    case highestScore = "highestScore"
    case favoriteCharacterName = "favoriteCharacterName"
}
