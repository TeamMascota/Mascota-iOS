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
    
    func text() -> String {
        switch self {
        case .home:
            return "1부"
        case .rainbow:
            return "2부"
        }
    }
    
}
