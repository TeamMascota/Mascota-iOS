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
        
        textContainerInset = UIEdgeInsets(top: 15, left: 12, bottom: 10, right: 12)
    }
    
    func setText(text: String, textColor: UIColor = .macoBlack) {
        attributedText = text.attributedString(font: .macoFont(type: .regular, size: 16), color: textColor, customLineHeight: 28)
    }
    
    func setUnderLine(color: UIColor? = .macoOrange) {
        let border = UIView()
        border.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        border.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height - 1, width: self.frame.width, height: 1)
        border.backgroundColor = color
        superview?.insertSubview(border, aboveSubview: self)
    }
    
    func addDoneButtonOnKeyboard(color: UIColor? = .systemBlue) {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let done: UIBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.doneButtonAction))
        done.tintColor = color
    
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
        
    }
    
    @objc
    func doneButtonAction() {
        self.resignFirstResponder()
    }
}
