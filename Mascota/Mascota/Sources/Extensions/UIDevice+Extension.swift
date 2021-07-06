//
//  UIDevice+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

extension UIDevice {
    var hasNotch: Bool {
        guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return false }
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}
