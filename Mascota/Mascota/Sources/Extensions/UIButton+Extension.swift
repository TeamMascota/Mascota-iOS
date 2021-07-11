//
//  UIButton+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        layer.masksToBounds = true
        layer.cornerRadius = 3.0
        
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
}
