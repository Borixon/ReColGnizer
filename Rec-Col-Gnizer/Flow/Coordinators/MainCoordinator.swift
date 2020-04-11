//
//  IntroCoordinator.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    init() {
        let vc = RGBViewController.instantiate()
        self.navigationController = UINavigationController(rootViewController: vc)
        vc.coordinator = self
    }
    
    func start() {
//        let vc = RGBViewController.instantiate()
//        vc.coordinator = self
//        navigationController.setViewControllers([vc], animated: true)
    }
    
    func openMenu() {
//        var vc = MenuViewController.instantiate()
//        vc.setCoordinator(self)
//        navigationController.pushViewController(vc, animated: true)
    }
    
    func openCameraPicker() {
//        var vc = CameraCaptureViewController.instantiate()
//        vc.setCoordinator(self)
//        navigationController.pushViewController(vc, animated: true)
    }
    
    func openRGBPicker() {
//        var vc = RGBViewController.instantiate()
//        vc.setCoordinator(self)
//        navigationController.pushViewController(vc, animated: true)
    }
}
