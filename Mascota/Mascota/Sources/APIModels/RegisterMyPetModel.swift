//
//  RegisterMyPetModel.swift
//  Mascota
//
//  Created by DYS on 2021/07/09.
//

import Foundation

// MARK: - RegisterMyPetModel
struct RegisterMyPetModel: Codable {
    let pets: [Pet]
    let userID: String

    enum CodingKeys: String, CodingKey {
        case pets
        case userID = "userId"
    }
}

// MARK: - Pet
struct Pet: Codable {
    let petImages: String
    let name: String
    let kind: Int
    let startDate: String
    let gender: Int
}
