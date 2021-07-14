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
        
        rainbowViewController.tabBarItem.image = UIImage(systemName: "shareplay")
        rainbowViewController.tabBarItem.selectedImage = UIImage(systemName: "shareplay")
        
        homeViewController.tabBarItem.image = UIImage(systemName: "house.fill")
        homeViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        calendarViewController.tabBarItem.image = UIImage(systemName: "house.fill")
        calendarViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
//        calendarViewController.tabBarItem.image = UIImage()
//        calendarViewController.tabBarItem.selectedImage = UIImage()
        
        setViewControllers([calendarViewController, homeViewController, rainbowViewController], animated: true)
        
//        setViewControllers([homeViewController, rainbowViewController], animated: true)

    }
    
    private func selectInitialViewController() {
        self.selectedIndex = 1
    }

}
