//
//  UINavigationController+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/05.
//

import UIKit

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
      return topViewController?.preferredStatusBarStyle ?? .default
   }

    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
