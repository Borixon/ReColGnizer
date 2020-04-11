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
    
    required init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = IntroViewController.instantiate()
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func openMenu() {
        let vc = MenuViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openCameraPicker() {
        let vc = CameraCaptureViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openRGBPicker() {
        let vc = RGBViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openColorData(data: ColorModel) {
        let vc = ColorDataViewController.instantiate()
        vc.vm = ColorDataViewModel(model: data)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func insertLoadingScreen() {
        
    }
}
