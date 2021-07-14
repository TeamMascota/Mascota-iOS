//
//  DetailDiaryModel.swift
//  Mascota
//
//  Created by apple on 2021/07/14.
//

import Foundation

struct DetailDiaryModel: Codable {
    let diaryID, title, contents: String
    let episode: Int
    let image: String
    let feelingCount, feeling: Int
    let date: String
    let kind: Int

    enum CodingKeys: String, CodingKey {
        case diaryID = "diaryId"
        case title, contents, episode, image, feelingCount, feeling, date, kind
    }
}
