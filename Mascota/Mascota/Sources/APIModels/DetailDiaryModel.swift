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
    let image: String?
    let feelingCount, feeling: Int
    let date: String
    let weekday: String
    let kind: Int

    enum CodingKeys: String, CodingKey {
        case diaryID = "diaryId"
        case title, contents, episode, image, feelingCount, feeling, date, weekday, kind
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        diaryID = try value.decode(String.self, forKey: .diaryID)
        title = try value.decode(String.self, forKey: .title)
        contents = try value.decode(String.self, forKey: .contents)
        episode = try value.decode(Int.self, forKey: .episode)
        image = (try? value.decode(String.self, forKey: .image))
        feelingCount = try value.decode(Int.self, forKey: .feelingCount)
        feeling = try value.decode(Int.self, forKey: .feeling)
        date = try value.decode(String.self, forKey: .date)
        weekday = try value.decode(String.self, forKey: .weekday)
        kind = try value.decode(Int.self, forKey: .kind)
    }
}
