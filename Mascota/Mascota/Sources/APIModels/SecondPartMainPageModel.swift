//
//  SecondPartMainPageModel.swift
//  Mascota
//
//  Created by apple on 2021/07/15.
//

import Foundation

struct SecondPartMainPageModel: Codable {
    let title: String?
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        title = (try? value.decode(String.self, forKey: .title)) ?? ""
    }
    
}

