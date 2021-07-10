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
