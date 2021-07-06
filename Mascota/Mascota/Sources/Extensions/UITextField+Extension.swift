//
//  UITextField+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

extension UITextField {
    func setBottomBorder(color: UIColor? = .macoBlue) {
        self.borderStyle            = .none
        self.layer.masksToBounds    = false
        self.layer.shadowColor      = color?.cgColor
        self.layer.shadowOffset     = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity    = 0.8
        self.layer.shadowRadius     = 0.0
    }
    
    func setMacoTextField(color: UIColor? = .macoOrange) {
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
    }
}
