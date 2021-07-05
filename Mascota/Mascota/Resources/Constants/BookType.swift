//
//  BookType.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/03.
//

import UIKit

enum BookType {
    case home
    case rainbow
    
    func color() -> UIColor {
        switch self {
        case .home:
            return .macoOrange
        case .rainbow:
            return .macoBlue
        }
    }
    
    func titleFont() -> UIFont {
        switch self {
        case .home:
            return .macoFont(type: .regular, size: 20)
        case .rainbow:
            return .macoFont(type: .medium, size: 20)
        }
    }
}
