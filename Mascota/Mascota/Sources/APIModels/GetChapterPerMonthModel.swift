//
//  GetChapterPerMonth.swift
//  Mascota
//
//  Created by apple on 2021/07/14.
//

import Foundation

struct GetChapterPerMonthModel: Codable {
    let chapterID: String
    let chapter: Int
    let chapterTitle: String
    let monthly: [ChapterMonthDiary]

    enum CodingKeys: String, CodingKey {
        case chapterID = "chapterId"
        case chapter, chapterTitle, monthly
    }
}
