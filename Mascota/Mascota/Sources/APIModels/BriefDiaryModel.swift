//
//  BriefDiaryModel.swift
//  Mascota
//
//  Created by apple on 2021/07/14.
//

import Foundation

struct BriefDiaryModel: Codable {
    let chapter, episode: Int
    let id, title, contents, date: String

    enum CodingKeys: String, CodingKey {
        case chapter, episode
        case id = "_id"
        case title, contents, date
    }
}

