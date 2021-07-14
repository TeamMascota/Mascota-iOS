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
    let chapterName: String
    let episodePerchapterCount: Int?

    enum CodingKeys: String, CodingKey {
        case chapterID = "chapterId"
        case chapter, chapterName, episodePerchapterCount
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chapterID = (try? values.decode(String.self, forKey: .chapterID)) ?? ""
        chapter = (try? values.decode(Int.self, forKey: .chapter)) ?? 0
        chapterName = (try? values.decode(String.self, forKey: .chapterName)) ?? ""
        episodePerchapterCount = (try? values.decode(Int.self, forKey: .episodePerchapterCount)) ?? nil
    }
}
