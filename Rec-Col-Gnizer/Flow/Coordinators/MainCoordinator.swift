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
    
    required init() {
        navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .fullScreen
    }
    
    func start() {
        let introVC = IntroViewController.instantiate()
        introVC.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.setViewControllers([introVC], animated: true)
    }
    
    func openTabBar() {
        
        // to replace
        let picker = PickerViewController.instantiate()
        picker.coordinator = self
        let cameraPicker = CameraCaptureViewController.instantiate()
        cameraPicker.coordinator = self
        let tabbar = UITabBarController()
        tabbar.setViewControllers([picker, cameraPicker], animated: false)
        let buttonRgb = UIBarButtonItem(title: "Manual Picker", style: .plain, target: self, action: nil)
        let buttonCam = UIBarButtonItem(title: "Camera Picker", style: .plain, target: self, action: nil)
        tabbar.setToolbarItems([buttonRgb, buttonCam], animated: false)
        tabbar.tabBar.tintColor = .red
        
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(tabbar, animated: true)
        
    }
    
    func openCameraPicker() {
        let vc = CameraCaptureViewController.instantiate()
        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
    }
    
    func openRGBPicker() {
        let vc = RGBViewController.instantiate()
        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
    }
    
    func openColorData(data: ColorModel) {
        let vc = ColorDataViewController.instantiate()
        vc.vm = ColorDataViewModel(model: data)
        DispatchQueue.main.async {
            self.navigationController.present(vc, animated: true, completion: nil)
        }
    }
    
    func show(error: Error?) {
        
    }
    
    func insertLoadingScreen() {
//        let loading = LoadingViewController()
//
    }
}
