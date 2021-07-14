//
//  ChaperAPI.swift
//  Mascota
//
//  Created by apple on 2021/07/14.
//

import Foundation
import Moya

enum ChapterAPI {
    case getChapterMonth(id: Int)
    case getChapterList
    case postChapterList(title: String)
    case deleteChapterList(chapterID: String)
    case putChapterList(chapterID: String, title: String)
}

extension ChapterAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: APIService.baseURL + "/chapter") else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getChapterMonth(let id):
            return "/pet/\(id)"
        case .getChapterList:
            return "/"+APIService.userID
        case .postChapterList:
            return "/"+APIService.userID
        case .deleteChapterList(let chapterID):
            return "/" + chapterID
        case .putChapterList(let chapterID, let title):
            return "/" + chapterID
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getChapterList, .getChapterMonth:
            return .get
        case .postChapterList:
            return .post
        case .putChapterList:
            return .put
        case .deleteChapterList:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .putChapterList(let chapterID, let title):
            return .requestParameters(parameters: ["chapterTitle": title], encoding: JSONEncoding.default)
            
        case .postChapterList(let title):
            return .requestParameters(parameters: ["chapterTitle": title], encoding: JSONEncoding.default)
        
        default:
            return .requestPlain
        }
    
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
