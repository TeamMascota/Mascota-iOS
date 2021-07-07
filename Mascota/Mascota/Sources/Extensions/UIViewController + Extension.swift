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
//        tempViewController.preferredContentSize = preferredSize
        tempViewController.preferredContentSize.width = 320
        tempViewController.preferredContentSize.height = 500
        
        alert.addAction(confirmAction)
        
        alert.setValue(tempViewController, forKey: "contentViewController")
    
        self.present(alert, animated: true, completion: nil)
    }
}
