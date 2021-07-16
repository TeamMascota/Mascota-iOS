//
//  UIViewController+Extension.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/03.
//

import UIKit

import SnapKit
import Lottie

extension UIViewController {
//
//    var indicatorView: UIView {
//        return UIView().then {
//            $0.alpha = 0
//        }
//    }
//
    
//    var indicatorAnimation: AnimationView {
//        return AnimationView(name: "loading_block").then {
//            $0.contentMode = .scaleAspectFill
//            $0.stop()
//        }
//    }
    
    var topBarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
        func presentSingleCustomAlert(view: UIView,
                                  preferredSize: CGSize,
                                  confirmHandler: ((UIAlertAction) -> Void)?,
                                  text: String,
                                  color: UIColor? = .macoOrange) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let tempViewController = UIViewController()
        
        let confirmAction: UIAlertAction = UIAlertAction(title: text, style: .default, handler: confirmHandler)
        confirmAction.setValue(color, forKey: "titleTextColor")
        
        tempViewController.view = view
        tempViewController.preferredContentSize = preferredSize
        
        alert.addAction(confirmAction)
        
        alert.setValue(tempViewController, forKey: "contentViewController")
        
        if let bgView = alert.view.subviews.first,
                    let groupView = bgView.subviews.first,
                    let contentView = groupView.subviews.first {
                    contentView.backgroundColor = UIColor.macoWhite
                }
    
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentDoubleCustomAlert(view: UIView,
                                  preferredSize: CGSize,
                                  firstHandler: ((UIAlertAction) -> Void)?,
                                  secondHandler: ((UIAlertAction) -> Void)?,
                                  firstText: String,
                                  secondText: String,
                                  color: UIColor? = .macoOrange) {

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let tempViewController = UIViewController()
        
        let confirmAction: UIAlertAction = UIAlertAction(title: firstText, style: .default, handler: firstHandler)
        let deleteAction: UIAlertAction = UIAlertAction(title: secondText, style: .default, handler: secondHandler)
        
        confirmAction.setValue(UIColor.macoLightGray, forKey: "titleTextColor")
        deleteAction.setValue(color, forKey: "titleTextColor")

        tempViewController.view = view
        tempViewController.preferredContentSize = preferredSize
        
        if let bgView = alert.view.subviews.first,
                    let groupView = bgView.subviews.first,
                    let contentView = groupView.subviews.first {
                    contentView.backgroundColor = UIColor.macoWhite
                }
        
        alert.addAction(confirmAction)
        alert.addAction(deleteAction)
        
        alert.setValue(tempViewController, forKey: "contentViewController")
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
//    func attachIndicator(_ type: IndicatorType) {
//        switch type {
//        case .normal:
//            self.indicatorView.backgroundColor = .macoIvory
//        case .rainbow:
//            self.indicatorView.backgroundColor = .macoBlue
//        case .translucent:
//            self.indicatorView.backgroundColor = .clear
//        }
//        print("adding something")
//        self.indicatorView.frame = self.view.bounds
//        print(self.view.bounds)
//        self.view.addSubview(self.indicatorView)
//        self.view.bringSubviewToFront(self.indicatorView)
////        self.indicatorAnimation.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
////        self.indicatorAnimation.center = self.indicatorView.center
////        self.indicatorView.addSubview(indicatorAnimation)
//        
//        UIView.animate(withDuration: 0.3) {
//            self.indicatorView.alpha = 1
//        } completion: { _ in
//            UIView.animate(withDuration: 0.3) {
//                self.indicatorAnimation.play()
//            }
//        }
//    }
    
//    func detachIndicator() {
//        self.indicatorView.removeFromSuperview()
//        UIView.animate(withDuration: 0.3) {
//            self.indicatorAnimation.stop()
//        } completion: { _ in
//            UIView.animate(withDuration: 0.3) {
//                self.indicatorView.alpha = 0
//            }
//        }
//    }
//        
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
