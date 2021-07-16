//
//  DiaryAPI.swift
//  Mascota
//
//  Created by apple on 2021/07/15.
//

import Foundation
import Moya

enum DiaryAPI {
    case getPetDiary(diaryID: String)
    case postPetDiary(characters: [CharacterModel], diaryWrite: DiaryWriteModel, images: [Data])
    case deletePetDiary(diaryID: String)
}

extension DiaryAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: APIService.baseURL + "/diary/pet") else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getPetDiary(let diaryID):
            return "/\(diaryID)"
        case .postPetDiary:
            return "/withImage"
        case .deletePetDiary(let diaryID):
            return "/\(diaryID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPetDiary:
            return .get
        case .postPetDiary:
            return .post
        case .deletePetDiary:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    
    var task: Task {
        switch self {
        case .getPetDiary:
            return .requestPlain
        case .postPetDiary(let characters, let diaryWrite, let images):
            let charactersModel: CharactersModel = CharactersModel(character: characters)
            var multipartData: [MultipartFormData] = []
            
            var character: [[String: Any]] = []
            
            for i in 0..<characters.count {
                var temp: [String: Any] = [String: Any]()
                temp["id"] = characters[i].id
                temp["feeling"] = characters[i].feeling
                character.append(temp)
            }
            
            let temp = MultipartFormData(provider: .data("\(character)".data(using: .utf8)!), name: "character")
            multipartData.append(temp)
//
//

            images.forEach {
                let temp = MultipartFormData(provider: .data($0), name: "images", fileName: "image.png", mimeType: "image/png")
                multipartData.append(temp)
            }
//
            let title = MultipartFormData(provider: .data(diaryWrite.title.data(using: .utf8)!), name: "title")
            multipartData.append(title)
            let contents = MultipartFormData(provider: .data(diaryWrite.contents.data(using: .utf8)!), name: "contents")
            let date = MultipartFormData(provider: .data(diaryWrite.date.data(using: .utf8)!), name: "date")
            let id = MultipartFormData(provider: .data(diaryWrite.id.data(using: .utf8)!), name: "_id")
            
            multipartData.append(contents)
            multipartData.append(date)
            multipartData.append(id)
            
            return .uploadMultipart(multipartData)
        case .deletePetDiary:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
