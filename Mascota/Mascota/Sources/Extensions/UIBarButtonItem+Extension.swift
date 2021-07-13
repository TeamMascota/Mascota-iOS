//
//  UIBarButtonItem+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/12.
//

import UIKit

extension UIBarButtonItem {
    
    func backBarButtonItem(style: UIBarButtonItem.Style, target: AnyObject, action: Selector?) {
        self.tintColor = .macoDarkGray
        self.image = UIImage(named: "btnIconBack")
        self.target = target
        self.action = action
    }
    
    func textBarButtonItem(title: String, style: UIBarButtonItem.Style, target: AnyObject, action: Selector?) {
        self.tintColor = .macoDarkGray
        self.title = title
        self.target = target
        self.action = action
        self.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.macoFont(type: .regular, size: 14), NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)
    }
    
}
