//
//  UIStackView+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
