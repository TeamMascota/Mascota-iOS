//
//  BaseViewController.swift
//  Mascota
//
//  Created by apple on 2021/07/17.
//
import UIKit

import Lottie
class BaseViewController: UIViewController {
    
    var indicatorView: UIView = UIView().then {
        $0.alpha = 0
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var indicatorAnimation: AnimationView = AnimationView(name: "loading_block").then {
        $0.contentMode = .scaleAspectFit
        $0.stop()
        $0.loopMode = .loop
        $0.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
    }
    
    func attachIndicator(_ type: IndicatorType) {
        switch type {
        case .normal:
            self.indicatorView.backgroundColor = .macoIvory
        case .rainbow:
            self.indicatorView.backgroundColor = .macoBlue
        case .translucent:
            self.indicatorView.backgroundColor = .clear
        }

        self.indicatorView.frame = UIScreen.main.bounds
        self.view.addSubview(self.indicatorView)
        self.indicatorAnimation.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        self.indicatorAnimation.center = self.indicatorView.center
        self.indicatorView.addSubview(indicatorAnimation)
        
        self.tabBarController?.tabBar.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1) {
            self.indicatorView.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.15) {
                self.indicatorAnimation.play()
            }
        }
    }

    func detachIndicator() {
        self.indicatorAnimation.stop()
        
        UIView.animate(withDuration: 0.1) {
            self.indicatorView.alpha = 0
        }
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
        self.indicatorAnimation.removeFromSuperview()
        self.indicatorView.removeFromSuperview()
    }
    
}
