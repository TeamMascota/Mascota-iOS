//
//  PetsAPI.swift
//  Mascota
//
//  Created by apple on 2021/07/16.
//

import Foundation
import Moya

enum PetsAPI {
    case getPetsInfo
}

extension PetsAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: APIService.baseURL + "/pet") else {
            fatalError("baseURL 가져오기 실패")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getPetsInfo:
            return "/register/petInfo"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPetsInfo:
            return .get
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPetsInfo:
            return .requestPlain
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
