//
//  CalendarAPI.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/14.
//

import Foundation
import Moya

enum CalendarAPI {
  case getCalendar(year: String, month: String, part: String)
}

extension CalendarAPI: TargetType {

    var baseURL: URL {
        guard let url = URL(string: APIService.baseURL + "/calendar") else {
            fatalError("baseURL 가져오기 실패")
        }
        return url
    }

    var path: String {
        switch self {
        case .getCalendar(let year, let month, let part):
            return "/\(year)/\(month)/\(part)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCalendar:
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
