//
//  GetCalendarModel.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/14.
//

struct GetCalendarModel: Codable {
    let name, part: String
    let nextEpilogue: Int?
    let calendar: MacoCalendarModel
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        name = (try? value.decode(String.self, forKey: .name)) ?? ""
        part = (try? value.decode(String.self, forKey: .part)) ?? ""
        nextEpilogue = (try? value.decode(Int.self, forKey: .name)) ?? 0
        calendar = try value.decode(MacoCalendarModel.self, forKey: .calendar)
    }
}
