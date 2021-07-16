//
//  AccountAPI.swift
//  Mascota
//
//  Created by DYS on 2021/07/14.
//

import Foundation
import Moya

enum AccountAPI {
    case postLogin(email: String, password: String)
    case postSignUp(email: String, password: String)
}

extension AccountAPI: TargetType {
    var baseURL: URL {
        return URL(string: APIService.baseURL)!
    }

    var path: String {
        switch self {
        case .postLogin:
            return "/user/login"
        case .postSignUp:
            return "/user/register"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postLogin, .postSignUp:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .postSignUp(let email,let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
            
        case .postLogin(let email,let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
//    
//    var validationType: ValidationType {
//        return .successCodes
//    }
}
