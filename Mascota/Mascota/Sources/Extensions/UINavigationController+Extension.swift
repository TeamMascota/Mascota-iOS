//
//  UINavigationController+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

let borderView = UIView()

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
        navigationBar.clipsToBounds = false
        
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

}
