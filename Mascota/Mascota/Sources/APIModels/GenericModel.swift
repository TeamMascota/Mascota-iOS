//
//  GenericModel.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/14.
//

struct GenericModel<T: Codable>: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: T?
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? value.decode(Int.self, forKey: .status)) ?? 0
        success = (try? value.decode(Bool.self, forKey: .success)) ?? false
        message = (try? value.decode(String.self, forKey: .message)) ?? ""
        data = (try? value.decode(T.self, forKey: .data))
    }
}
