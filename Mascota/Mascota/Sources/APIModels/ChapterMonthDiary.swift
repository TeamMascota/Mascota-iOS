//
//  ChapterMonthDiary.swift
//  Mascota
//
//  Created by apple on 2021/07/14.
//

import Foundation

struct ChapterMonthDiary: Codable {
    let episodePerMonthCount: Int
    let month: Int
    let diaries: [DetailDiaryModel]
}
