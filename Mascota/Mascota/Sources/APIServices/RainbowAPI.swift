//
//  RainbowAPI.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/15.
//

import Foundation
import Moya

enum RainbowAPI {
    case getRainbowHome(userId: String, petId: String)
    case getRainbowPet
    case putRainbowBridge(petId: String)
    case deleteRainbowBridge(petId: String)
    case getRainbowRecord(petId: String)
    case getRainbowMoment(userId: String, petId: String)
}

extension RainbowAPI: TargetType {

    var baseURL: URL {
        guard let url = URL(string: APIService.baseURL + "/rainbow") else {
            fatalError("baseURL 가져오기 실패")
        }
        return url
    }

    var path: String {
        switch self {
        case .getRainbowHome(let userId, let petId):
            return "/main/\(userId)/\(petId)"
        case .getRainbowPet:
            return "/pet"
        case .putRainbowBridge(let petId):
            return "/pet/\(petId)"
        case .deleteRainbowBridge(let petId):
            return "/pet/\(petId)"
        case .getRainbowRecord(let petId):
            return "/record/\(petId)"
        case .getRainbowMoment(let userId, let petId):
            return "/moment/\(userId)/\(petId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRainbowHome:
            return .get
        case .getRainbowPet:
            return .get
        case .putRainbowBridge:
            return .put
        case .deleteRainbowBridge:
            return .delete
        case .getRainbowRecord:
            return .get
        case .getRainbowMoment:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [ String: String]? {
        return nil
    }
}
