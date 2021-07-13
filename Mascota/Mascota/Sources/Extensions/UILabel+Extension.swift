//
//  UILabel+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/01.
//

import UIKit

extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0, lineHeight: CGFloat? = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        if let lineHeight = lineHeight {
            paragraphStyle.lineSpacing = lineHeight - self.font.pointSize
        }

        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        self.attributedText = attributedString
    }
    
    func setCountLabel(current: Int, limit: Int) {
        if current <= limit {
            self.text = "(\(current)/\(limit))"
        } else {
            print(1)
            self.attributedText = "(\(current)/\(limit))".convertSomeColorFont(color: .red, fontSize: 14, type: .regular, start: 1, length: "\(current)".count)
        }
    }
}
