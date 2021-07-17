//
//  UINavigationController+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

let borderView = UIView()

let stackView = UIStackView().then {
    $0.alignment = .center
    $0.distribution = .fillEqually
    $0.axis = .horizontal
    $0.spacing = 0
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
      return topViewController?.preferredStatusBarStyle ?? .default
   }

    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    func setMacoNavigationBar(barTintColor: UIColor, tintColor: UIColor, underLineColor: UIColor? = nil) {
        navigationBar.barTintColor = barTintColor
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        borderView.backgroundColor = underLineColor

        navigationBar.addSubview(borderView)

        borderView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(1)
        }

        navigationBar.layoutIfNeeded()
    }
    
    func setHalfMacoNavigationBar(barTintColor: UIColor, tintColor: UIColor) {
        navigationBar.barTintColor = barTintColor
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        let leftView = UIView().then {
            $0.backgroundColor = .macoOrange
        }
        let rightView = UIView().then {
            $0.backgroundColor = .lightGray
        }
        stackView.addArrangedSubviews(leftView, rightView)
        
        leftView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }
        
        rightView.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(leftView.snp.trailing)
        }
        navigationBar.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(1)
        }

        navigationBar.layoutIfNeeded()
    }


}
