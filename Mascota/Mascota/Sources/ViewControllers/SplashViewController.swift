//
//  SplashViewController.swift
//  Mascota
//
//  Created by DYS on 2021/07/17.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var view1: UIView!
    
    let animationView = AnimationView(name: "maco_logo")
    let x = Constant.DeviceSize.width * (85/375)
    let y = Constant.DeviceSize.height * (242.3/812)
    let width = Constant.DeviceSize.width * (203/375)
    let height = Constant.DeviceSize.height * (38/812)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
            setAnimation()
        //        animationView.pause() // 종료
        
        //
        //    override func viewDidLoad() {
        //        super.viewDidLoad()
        //        textLabel.font = .macoFont(type: .regular, size: 16.0)
        //        self.view.addSubview(macoLottieView)
        //
        //        macoLottieView.center = view.center
        //        macoLottieView.play { _ in
        //            self.macoLottieView.removeFromSuperview()
        //        }
        //    }
    }
    
    func setAnimation() {
        
        textLabel.font = .macoFont(type: .regular, size: 16.0)
        animationView.center = self.view1.center
        animationView.frame = CGRect(x: x, y: y, width: width, height: height)
        animationView.contentMode = .scaleAspectFill
        view1.addSubview(animationView)
        animationView.play() { _ in
            self.animationView.removeFromSuperview()
        }
        //animationView.loopMode = .loop
    }
    
}
