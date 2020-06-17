//
//  LoadingCoordinator.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 11/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit

class LoadingCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: NavigationController
     
    var vc: LoadingViewController?
    
    required init(withNavigationController navigation: NavigationController) {
        navigationController = navigation
    }
    
    func start() {
        let vc = LoadingViewController.instantiate()
        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        currentWindow?.addSubview(vc.view)
    }
    
    func finish() {

    }
}
