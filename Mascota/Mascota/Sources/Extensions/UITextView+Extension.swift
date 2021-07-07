//
//  UITextView+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

extension UITextView {
    func setMacoTextView(color: UIColor? = .macoOrange) {
        layer.masksToBounds = true
        backgroundColor = .macoWhite
        
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = Constant.round3
        
        tintColor = color
    }
    
    func setUnderLine(color: UIColor? = .macoOrange) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.width, height: 1)
        border.backgroundColor = UIColor.macoBlue.cgColor
        layer.addSublayer(border)
    }
}
