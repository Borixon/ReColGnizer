//
//  IntroCoordinator.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var window = (UIApplication.shared.delegate as? AppDelegate)?.appWindow
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let windowTag: Int = 69
    
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
        let tabBar = TabController.instantiate()
        if let controllers = tabBar.viewControllers {
            for controller in controllers {
                (controller as? BaseViewController)?.coordinator = self
            }
        }
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(tabBar, animated: true)
    }
    
    // TODO zmiana color model
    func openColorData(data: ColorModel) {
        let vc = ColorDataViewController.instantiate()
        vc.vm = ColorDataViewModel(model: data)
        DispatchQueue.main.async {
            self.navigationController.present(vc, animated: true, completion: nil)
        }
    }
    
    func openColorScheme() {
        
    }
    
    func show(error: Error?) {
        
    }
    
    func insertLoadingScreen() {
        // todo
        let loading = LoadingViewController.instantiate()
        loading.view.tag = windowTag
        window?.addSubview(loading.view)
    }
    
    func removeLoadingScreen() {
        window?.subviews.filter({ $0.tag == windowTag }).first?.removeFromSuperview()
    }
}
