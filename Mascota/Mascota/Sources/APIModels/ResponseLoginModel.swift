//
//  ResponseLoginModel.swift
//  Mascota
//
//  Created by DYS on 2021/07/15.
//

import Foundation

struct ResponseLoginModel: Codable {
    let status: Int
    let success: Bool?
    let data: UserID?
    let message: String
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? value.decode(Int.self, forKey: .status)) ?? 0
        success = (try? value.decode(Bool?.self, forKey: .success)) ?? false
        data = (try? value.decode(UserID?.self, forKey: .data)) ?? UserID(userId: "009900")
        message = (try? value.decode(String.self, forKey: .message)) ?? ""
    }
}

// MARK: - DataClass
struct UserID: Codable {
    let userId: String

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
    }
}
