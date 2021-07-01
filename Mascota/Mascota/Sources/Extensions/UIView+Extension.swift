//
//  UIView+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/06/30.
//

import UIKit

extension UIView {
    func addSubviews(_ views:UIView...){
        for view in views {
            self.addSubview(view)
        }
    }
}
