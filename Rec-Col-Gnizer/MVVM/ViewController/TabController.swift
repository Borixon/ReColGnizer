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

    private func styleView() {
        tabBar.tintColor = Style.accentColor
        tabBar.unselectedItemTintColor = Style.keyHelperColor
    }
    
}
