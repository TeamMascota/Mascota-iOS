//
//  UIViewController+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/03.
//

import UIKit
import Foundation

import SnapKit

extension UIViewController {
    var topBarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}

