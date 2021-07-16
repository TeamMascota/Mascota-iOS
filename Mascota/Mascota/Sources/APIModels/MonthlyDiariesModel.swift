//
//  MonthlyDiariesModel.swift
//  Mascota
//
//  Created by apple on 2021/07/15.
//

import Foundation

struct MonthlyDiariesModel: Codable {
    let episodePerMonthCount: Int
    let month: Int
    let diaries: [DetailDiaryModel]
}
