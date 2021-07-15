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
    case postPetDiary
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
            return ""
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
        case .postPetDiary:
            return .requestCompositeData(bodyData: Data(), urlParameters: ["": 1])
        case .deletePetDiary:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
