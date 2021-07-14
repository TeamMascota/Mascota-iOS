//
//  UIBarButtonItem+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/12.
//

import UIKit

extension UIBarButtonItem {
    
    func backBarButtonItem(color: UIColor = .macoDarkGray, style: UIBarButtonItem.Style, target: AnyObject, action: Selector?) {
        self.image = UIImage(named: "btnIconBack")?.withTintColor(color)
        self.target = target
        self.action = action
    }
    
    func closeBarButtonItem(color: UIColor = .macoDarkGray, style: UIBarButtonItem.Style, target: AnyObject, action: Selector?) {
        self.image = UIImage(named: "btnIconQuitDefaultGray")?.withTintColor(color)
        self.target = target
        self.action = action
    }
    
    func textBarButtonItem(color: UIColor? = .macoDarkGray, title: String, style: UIBarButtonItem.Style, target: AnyObject, action: Selector?) {
        self.tintColor = color
        self.title = title
        self.target = target
        self.action = action
        self.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.macoFont(type: .regular, size: 14), NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)
    }
    
}
