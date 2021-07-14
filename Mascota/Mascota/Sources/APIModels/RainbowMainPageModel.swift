//
//  RainbowMainPageModel.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/15.
//

struct RainbowMainPageModel: Codable {
    let title, bookImg: String
    let rainbowCheck: Bool
    let memories: [MemoryModel?]
    let help: [HelpCardModel]
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        title = (try? value.decode(String.self, forKey: .title)) ?? ""
        bookImg = (try? value.decode(String.self, forKey: .bookImg)) ?? ""
        rainbowCheck = (try? value.decode(Bool.self, forKey: .bookImg)) ?? false
        memories = (try? value.decode([MemoryModel?].self, forKey: .memories))
            ?? []
        help = (try? value.decode([HelpCardModel].self, forKey: .help))
            ?? []
    }
}
