//
//  UIFont+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/04.
//

import UIKit

extension UIFont {
    class func macoFont(type: NotoSansCJKkrType, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.name, size: size) else { return .systemFont(ofSize: 3) }
        return font
    }

    public enum NotoSansCJKkrType: String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"

        var name: String {
            "NotoSansCJKkr-" + self.rawValue
        }
    }
}
