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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRainbowHome:
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
