//
//  UITextField+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

extension UITextField {
    func setMacoTextField(color: UIColor? = .macoOrange) {
        tintColor = color
        
        layer.masksToBounds = true
        backgroundColor = .macoWhite
        
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = Constant.round3
        
        let border = UIView()
        border.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        border.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height - 1, width: self.frame.width, height: 1)
        border.backgroundColor = color
        superview?.insertSubview(border, aboveSubview: self)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        leftView = paddingView
        leftViewMode = ViewMode.always
        
        rightView = paddingView
        rightViewMode = ViewMode.always
        
    }
}
