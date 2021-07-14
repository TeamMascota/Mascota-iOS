//
//  GetChapterModel.swift
//  Mascota
//
//  Created by apple on 2021/07/14.
//

import Foundation

struct GetChapterModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: TableContentsModel
}
