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
    let monthly: [ChapterMonthDiary]?

    enum CodingKeys: String, CodingKey {
        case chapterID = "chapterId"
        case chapter, chapterTitle, monthly
    }
    
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        chapterID = try value.decode(String.self, forKey: .chapterID)
        chapter = try value.decode(Int.self, forKey: .chapter)
        chapterTitle = try value.decode(String.self, forKey: .chapterTitle)
        monthly = (try? value.decode([ChapterMonthDiary].self, forKey: .monthly))
    }
    
}

