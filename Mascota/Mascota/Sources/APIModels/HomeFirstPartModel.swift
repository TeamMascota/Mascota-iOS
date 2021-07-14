//
//  HomeFirstPartModel.swift
//  Mascota
//
//  Created by apple on 2021/07/15.
//

import Foundation

struct HomeFirstPartModel: Codable {
    let firstPartMainPage: FirstPartMainPageModel
    let secondPartBook: SecondPartMainPageModel?
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        firstPartMainPage = try value.decode(FirstPartMainPageModel.self, forKey: .firstPartMainPage)
        secondPartBook = (try? value.decode(SecondPartMainPageModel.self, forKey: .secondPartBook))
    }
}
