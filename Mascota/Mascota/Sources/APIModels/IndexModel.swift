//
//  TableContentModel.swift
//  Mascota
//
//  Created by apple on 2021/07/14.
//

import Foundation

struct IndexModel: Codable {
    let chapterID: String
    let chapter: Int
    let chapterTitle: String
    let episodePerchapterCount: Int?

    enum CodingKeys: String, CodingKey {
        case chapterID = "chapterId"
        case chapter, chapterTitle, episodePerchapterCount
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chapterID = (try? values.decode(String.self, forKey: .chapterID)) ?? ""
        chapter = (try? values.decode(Int.self, forKey: .chapter)) ?? 0
        chapterTitle = (try? values.decode(String.self, forKey: .chapterTitle)) ?? ""
        episodePerchapterCount = (try? values.decode(Int.self, forKey: .episodePerchapterCount))
    }
}
