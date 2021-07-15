//
//  FirstPartMainModel.swift
//  Mascota
//
//  Created by apple on 2021/07/14.
//

import Foundation

struct FirstPartMainPageModel: Codable {
    let title: String
    let bookImg: String
    let diary: BriefDiaryModel
    let tableContents: [IndexModel]
}
