//
//  TabController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 17/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class TabController: UITabBarController, StoryboardedProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        styleView() 
    }
    
    public func setupViewControllers() {
        let nav1 = NavigationController()
        nav1.setViewControllers([SliderPickerViewController.instantiate()], animated: true)
        let nav2 = NavigationController()
        nav2.setViewControllers([ImagePickerViewController.instantiate()], animated: true)
        let nav3 = NavigationController()
        nav3.setViewControllers([FavoriteViewController.instantiate()], animated: true)
        
        setViewControllers([SliderPickerViewController.instantiate(),
                                 ImagePickerViewController.instantiate(),
                                 FavoriteViewController.instantiate()], animated: false)

        setViewControllers([nav1, nav2, nav3], animated: false)
    }

    private func styleView() {
        tabBar.tintColor = Style.accentColor
        tabBar.unselectedItemTintColor = Style.keyHelperColor
    }
    
}
