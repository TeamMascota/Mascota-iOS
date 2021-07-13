//
//  CALayer + Extension.swift
//  Mascota
//
//  Created by apple on 2021/07/13.
//

import UIKit

extension CALayer {
    func addBorder(_ edges: [UIRectEdge], color: UIColor, width: CGFloat) {
        var layers: [CALayer] = []
        for edge in edges {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect(x: 0, y: 0, width: frame.width, height: width)
                layers.append(border)
            case UIRectEdge.bottom:
                border.frame = CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
                layers.append(border)
            case UIRectEdge.left:
                border.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
                layers.append(border)
            case UIRectEdge.right:
                border.frame = CGRect(x: frame.width - width, y: 0, width: width, height: frame.height)
                layers.append(border)
            default:
                break
            }
        }
        layers.forEach {
            $0.backgroundColor = color.cgColor
            self.addSublayer($0)
        }
    }
}
