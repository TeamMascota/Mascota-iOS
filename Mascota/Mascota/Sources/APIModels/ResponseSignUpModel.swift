//
//  ResponseSignUpModel.swift
//  Mascota
//
//  Created by DYS on 2021/07/14.
//

import Foundation

struct ResponseSignUpModel: Codable {
    let status: Int
    let success: Bool?
    let message: String
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? value.decode(Int.self, forKey: .status)) ?? 0
        success = (try? value.decode(Bool?.self, forKey: .success)) ?? false
        message = (try? value.decode(String.self, forKey: .message)) ?? ""
    }
}
