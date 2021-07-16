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
    
    func grid() -> UIImage? {
        switch self {
        case .home:
            return UIImage(named: "bgGrid")
        case .rainbow:
            return UIImage(named: "bgGridRainbow")
        }
    }
}
