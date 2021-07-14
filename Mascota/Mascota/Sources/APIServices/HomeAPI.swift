//
//  HomeAPI.swift
//  Mascota
//
//  Created by apple on 2021/07/15.
//

import Foundation
import Moya

enum HomeAPI {
    case getHomeFirstPart
}

extension HomeAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: APIService.baseURL) else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getHomeFirstPart:
            return "/firstPart/main/" + APIService.userID
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHomeFirstPart:
            return .get
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getHomeFirstPart:
            return .requestPlain
        default:
            return .requestData(<#T##Data#>)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
