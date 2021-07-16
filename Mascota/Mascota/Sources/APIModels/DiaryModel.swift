//
//  DiaryModel.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/15.
//

struct DiaryModel: Codable {
    let chapter, episode: Int?
    let title, contents, date, diaryId: String?
}
