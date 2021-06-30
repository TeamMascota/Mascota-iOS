//
//  UIFont+Extension.swift
//  Mascota
//
//  Created by DYS on 2021/06/30.
//

import UIKit

extension UIFont {
    class func NotoSansCJKkr(type: NotoSansCJKkrType, size: CGFloat) -> UIFont! {
        guard let font = UIFont(name: type.name, size: size) else {
            return nil
        }
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

