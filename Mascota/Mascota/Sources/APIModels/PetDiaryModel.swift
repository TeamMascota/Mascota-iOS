//
//  PetDiaryModel.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/16.
//

struct PetDiaryModel: Codable {
    let id: String
    let episode: Int
    let title: String
    let bookImg: [String]
    let date, contents: String
    let timeTogether: Int
    let feelingList: [FeelingListModel]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case episode, title, bookImg, date, contents, timeTogether, feelingList
    }
}
