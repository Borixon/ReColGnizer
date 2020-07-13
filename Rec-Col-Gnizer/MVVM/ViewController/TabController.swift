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
        let imgPicker = ImagePickerViewController.instantiate()
        imgPicker.startCameraSession()
        nav2.setViewControllers([imgPicker], animated: true)
        
        let nav3 = NavigationController()
        nav3.setViewControllers([FavouriteViewController.instantiate()], animated: true)
        
        let nav4 = NavigationController()
        nav4.setViewControllers([LibrariesViewController.instantiate()], animated: true)
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
    }

    private func styleView() {
        tabBar.tintColor = Style.accentColor
        tabBar.unselectedItemTintColor = Style.keyHelperColor
    }
    
}
