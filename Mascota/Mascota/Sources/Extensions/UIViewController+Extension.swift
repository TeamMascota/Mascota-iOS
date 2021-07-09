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
    
    func presentSingleCustomAlert(view: UIView,
                                  preferredSize: CGSize,
                                  confirmHandler: ((UIAlertAction) -> Void)?,
                                  text: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let tempViewController = UIViewController()
        
        let confirmAction: UIAlertAction = UIAlertAction(title: text, style: .default, handler: confirmHandler)

        tempViewController.view = view
        tempViewController.preferredContentSize = preferredSize
        
        alert.addAction(confirmAction)
        
        alert.setValue(tempViewController, forKey: "contentViewController")
    
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentDoubleCustomAlert(view: UIView,
                                  preferredSize: CGSize,
                                  firstHandler: ((UIAlertAction) -> Void)?,
                                  secondHandler: ((UIAlertAction) -> Void)?,
                                  firstText: String,
                                  secondText: String) {

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let tempViewController = UIViewController()
        
        let confirmAction: UIAlertAction = UIAlertAction(title: firstText, style: .default, handler: firstHandler)
        let deleteAction: UIAlertAction = UIAlertAction(title: secondText, style: .default, handler: secondHandler)
        
        confirmAction.setValue(UIColor.macoLightGray, forKey: "titleTextColor")
        deleteAction.setValue(UIColor.macoOrange, forKey: "titleTextColor")

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
}
