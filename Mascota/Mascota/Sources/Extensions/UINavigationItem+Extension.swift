//
//  UINavigationItem+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/08.
//

import UIKit

extension UINavigationItem {
    func setTitle(title: String, subtitle: String = "", color: UIColor = .macoWhite) {
        
        let one = UILabel().then {
            $0.text = title
            $0.font = .macoFont(type: .medium, size: 17)
            $0.textColor = .macoWhite
            $0.sizeToFit()
        }
        
        let two = UILabel().then {
            $0.text = subtitle
            $0.font = .macoFont(type: .regular, size: 14)
            $0.textAlignment = .center
            $0.textColor = .macoWhite
            $0.sizeToFit()
        }
        
        let stackView = UIStackView(arrangedSubviews: [two, one]).then { stackView in
            stackView.distribution = .equalCentering
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.spacing = 8
        }
        
        titleView = stackView
    }
}
