//
//  UIDevice+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/06.
//

import UIKit

extension UIDevice {
//        var hasNotch: Bool {
//            guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
//            if UIDevice.current.orientation.isPortrait {
//                return window.safeAreaInsets.top >= 44
//            } else {
//                return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
//        }
//    }
    
    var hasNotch: Bool {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        }
}
