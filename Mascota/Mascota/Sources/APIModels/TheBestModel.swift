//
//  TheBestModel.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/15.
//

struct TheBestModel: Codable {
    let feeling: Int
    let diaries: [DiaryModel?]?
    let comment: String
}
