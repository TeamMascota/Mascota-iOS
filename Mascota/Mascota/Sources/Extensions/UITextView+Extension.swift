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
        let border = UIView()
        border.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        border.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height - 1, width: self.frame.width, height: 1)
        border.backgroundColor = color
        superview?.insertSubview(border, aboveSubview: self)
    }
}
