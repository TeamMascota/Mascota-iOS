//
//  RegisterMyPetModel.swift
//  Mascota
//
//  Created by DYS on 2021/07/09.
//

import Foundation
import UIKit

// MARK: - RegisterMyPetModel
struct RegisterMyPetModel {
    let pets: [PetInfo]
    let userID: String
    
    enum CodingKeys: String, CodingKey {
        case pets
        case userID = "userId"
    }
}

// MARK: - PetInfo
struct PetInfo {
    var petImages: UIImage
    var name: String
    var kind: Int
    var startDate: String
    var gender: Int
}

