//
//  String+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/04.
//

import UIKit

extension String {
   func maxLength(length: Int) -> String {
       var str = self
       let nsString = str as NSString
       if nsString.length >= length {
           str = nsString.substring(with:
               NSRange(
                location: 0,
                length: nsString.length > length ? length : nsString.length)
           )
       }
       return  str
   }
    
    func convertColorFont(color: UIColor? = nil, fontSize: CGFloat? = nil, type: UIFont.NotoSansCJKkrType) -> NSAttributedString {
        let text = NSMutableAttributedString(string: self)

        if let unwrappedColor = color {
            text.addAttribute(.foregroundColor,
                              value: unwrappedColor,
                              range: NSRange(location: 0, length: self.count))
        }
        
        if let unwrappedSize = fontSize {
            text.addAttribute(.font,
                              value: UIFont.macoFont(type: type, size: unwrappedSize) ,
                              range: NSRange(location: 0, length: self.count))
        }
        
        return text
    }
}
