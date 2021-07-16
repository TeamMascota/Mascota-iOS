//
//  ChapterMontlyDiariesModel.swift
//  Mascota
//
//  Created by apple on 2021/07/15.
//

import Foundation

struct ChapterMonthlyDiariesModel: Codable {
    let chapterId: String
    let chapter: Int
    let chapterTitle: String
    let monthly: [MonthlyDiariesModel]
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        chapterId = try value.decode(String.self, forKey: .chapterId)
        chapter = try value.decode(Int.self, forKey: .chapter)
        chapterTitle = try value.decode(String.self, forKey: .chapterTitle)
        monthly = try value.decode([MonthlyDiariesModel].self, forKey: .monthly)
    }
}
