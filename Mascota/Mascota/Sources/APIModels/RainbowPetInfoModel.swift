//
//  RainbowPetInfoModel.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/15.
//

struct RainbowPetInfoModel: Codable {
    let id, name, img: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, img
    }
}
