//
//  macoTabBarController.swift
//  Mascota
//
//  Created by apple on 2021/07/14.
//

import UIKit

class MacoTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        selectInitialViewController()
        initializeTabBarController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func initializeTabBarController() {
        self.view.tintColor = .macoOrange
        UITabBar.appearance().barTintColor = .macoIvory
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor.macoOrange.cgColor
    }
    
    private func setTabBar() {
        let homeStoryboard = UIStoryboard(name: AppConstants.Storyboard.homeStart, bundle: nil)
        guard let homeViewController = homeStoryboard.instantiateViewController(identifier: AppConstants.ViewController.homeStart) as? HomeStartViewController else {
            return
        }
        
        let rainbowViewController = RainbowViewController()
        let calendarViewController = CalendarViewController()
        
        rainbowViewController.tabBarItem.image = UIImage(named: "rainbow1")
        rainbowViewController.tabBarItem.selectedImage = UIImage(named: "rainbow2")
        
        homeViewController.tabBarItem.image = UIImage(named: "home1")
        homeViewController.tabBarItem.selectedImage = UIImage(named: "home2")
        
        calendarViewController.tabBarItem.image = UIImage(named: "calendar1")
        calendarViewController.tabBarItem.selectedImage = UIImage(named: "calendar2")
        
        setViewControllers([calendarViewController, homeViewController, rainbowViewController], animated: true)
        
        if UIDevice.current.hasNotch {
            [rainbowViewController, homeViewController, calendarViewController].forEach {
                $0.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
            }
        } else {
            [rainbowViewController, homeViewController, calendarViewController].forEach {
                $0.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 2, bottom: -5, right: 0)
            }
        }

    }
    
    private func selectInitialViewController() {
        self.selectedIndex = 1
    }

}
