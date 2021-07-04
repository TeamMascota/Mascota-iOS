//
//  UIViewController+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/03.
//

import UIKit

import SnapKit

extension UIViewController {
     var topBarHeight: CGFloat {
         return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
             (self.navigationController?.navigationBar.frame.height ?? 0.0)
     }
}
