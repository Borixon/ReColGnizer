//
//  TabController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 17/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

final class TabController: UITabBarController, StoryboardedProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        styleView() 
    }
    
    public func setupViewControllers() {
        // Sliders view
        let nav1 = NavigationController()
        nav1.setViewControllers([SliderPickerViewController.instantiate()], animated: true)
        
        // Camera picker view
        let nav2 = NavigationController()
        let imgPicker = ImagePickerViewController.instantiate()
        imgPicker.startCameraSession()
        nav2.setViewControllers([imgPicker], animated: true)
        
        // Favourite view
        let nav3 = NavigationController()
        let fav = ColourListViewController.instantiate()
        nav3.setViewControllers([fav], animated: true)
        fav.vm = ColourListViewModel()
        fav.vm.data = FavouriteListData()
        fav.setupFavouriteSearchBar()
        
        // Libraries view
        let nav4 = NavigationController()
        nav4.setViewControllers([LibrariesViewController.instantiate()], animated: true)
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
    }

    private func styleView() {
        tabBar.tintColor = Style.accentColor
        tabBar.unselectedItemTintColor = Style.keyHelperColor
    }
    
}
