//
//  characterModel.swift
//  Mascota
//
//  Created by apple on 2021/07/16.
//

import Foundation

struct CharacterModel: Codable {
    let id: String
    let feeling: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case feeling
    }
}


