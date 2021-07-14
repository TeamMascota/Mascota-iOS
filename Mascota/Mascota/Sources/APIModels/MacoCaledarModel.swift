//
//  MacoCaledarModel.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/14.
//

struct MacoCalendarModel: Codable {
    let year, month: String
    let date: [DateDiaryModel?]
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        year = (try? value.decode(String.self, forKey: .year)) ?? ""
        month = (try? value.decode(String.self, forKey: .month)) ?? ""
        date = (try? value.decode([DateDiaryModel?].self, forKey: .date))
            ?? []
        
    }
}
