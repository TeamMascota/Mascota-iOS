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
            var params: [String: Any] = [String: Any]()
            var multipartData: [MultipartFormData] = []
                
            var character: Data = Data()
                
            let encoder = JSONEncoder()
            do {
                let characterJson = try encoder.encode(charactersModel)
                character = characterJson
            } catch (let err) {
                print(err.localizedDescription)
            }
            
            let characterData = MultipartFormData(provider: .data(character), name: "character")
            
            multipartData.append(characterData)
            print(character)
    //                character.append(Data(temp))

                
    //            print(type(of: Data(character)))
                
    //            let temp = MultipartFormData(provider: .data(Data(character)), name: "character")
    //            multipartData.append(temp)
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
                
    //            return .uploadCompositeMultipart(multipartData, urlParameters: [String : Any])
            return .uploadMultipart(multipartData)
        case .deletePetDiary:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
