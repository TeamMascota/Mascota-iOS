//
//  PetImageModel.swift
//  Mascota
//
//  Created by apple on 2021/07/16.
//

import Foundation

struct PetImageModel: Codable {
    let id, img, name: String
    let kind: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case img, name, kind
    }
}
