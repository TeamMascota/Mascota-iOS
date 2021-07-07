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
        
        borderStyle            = .none
        layer.masksToBounds    = false
        layer.shadowColor      = color?.cgColor
        layer.shadowOffset     = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity    = 1
        layer.shadowRadius     = 0.0
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        leftView = paddingView
        leftViewMode = ViewMode.always
        
        rightView = paddingView
        rightViewMode = ViewMode.always
        
    }
}
