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

extension String {
  func attributedString(font: UIFont, color: UIColor? = nil, customLineHeight: CGFloat? = nil, alignment: NSTextAlignment? = nil, kern: Double? = nil, lineBreakMode: NSLineBreakMode? = nil, underlineStyle: NSUnderlineStyle? = nil, strikeThroughStyle: NSUnderlineStyle? = nil) -> NSAttributedString {
    
    let finalKern: Double = kern ?? 0.0
    let finalLineHeight: CGFloat = customLineHeight ?? font.lineHeight
    let finalColor: UIColor = color ?? UIColor.black
    
    let paragraphStyle = NSMutableParagraphStyle()
    
    paragraphStyle.lineSpacing = finalLineHeight - font.lineHeight
    
    if let alignment = alignment {
      paragraphStyle.alignment = alignment
    }
    
    if let lineBreakMode = lineBreakMode {
      paragraphStyle.lineBreakMode = lineBreakMode
    }
    
    var attributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: finalColor,
      .font: font,
      .kern: finalKern,
      .paragraphStyle: paragraphStyle
    ]
    
    if let underlineStyle = underlineStyle {
        attributes.updateValue(underlineStyle.rawValue, forKey: NSAttributedString.Key.underlineStyle)
      
    }
    
    if let strikeThroughStyle = strikeThroughStyle {
        attributes.updateValue(strikeThroughStyle.rawValue, forKey: NSAttributedString.Key.strikethroughStyle)
      
    }
    
    return NSAttributedString.init(string: self, attributes: attributes)
  }
  
}
