//
//  UIViewController + Extension.swift
//  Mascota
//
//  Created by apple on 2021/07/07.
//

import UIKit

extension UIViewController {
    func presentSingleCustomAlert(view: UIView, preferredSize: CGSize, confirmHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let tempViewController = UIViewController()
        
        let confirmAction: UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: confirmHandler)

        tempViewController.view = view
        tempViewController.preferredContentSize = preferredSize
        
        alert.addAction(confirmAction)
        
        alert.setValue(tempViewController, forKey: "contentViewController")
    
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentDoubleCustomAlert(view: UIView, preferredSize: CGSize, firstHandler: ((UIAlertAction) -> Void)?, secondHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let tempViewController = UIViewController()
        
        let confirmAction: UIAlertAction = UIAlertAction(title: "취소", style: .default, handler: firstHandler)
        let deleteAction: UIAlertAction = UIAlertAction(title: "삭제", style: .default, handler: secondHandler)
        
        confirmAction.setValue(UIColor.macoLightGray, forKey: "titleTextColor")
//        confirmAction.setValue(UIColor.macoWhite, forKey: "backgroundColor")
        deleteAction.setValue(UIColor.macoOrange, forKey: "titleTextColor")
//        deleteAction.setValue(UIColor.macoWhite, forKey: "backgroundColor")

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
