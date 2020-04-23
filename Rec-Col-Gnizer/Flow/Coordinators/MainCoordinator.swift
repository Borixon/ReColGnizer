//
//  IntroCoordinator.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var window = (UIApplication.shared.delegate as? AppDelegate)?.appWindow // TODO: why nil
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
    
    func openColorData(data: ColorModel) {
        let vc = ColorDataViewController.instantiate()
        vc.vm = ColorDataViewModel(model: data)
        self.navigationController.modalPresentationStyle = .overFullScreen
        self.navigationController.present(vc, animated: true, completion: nil)
    }
    
    func openColorScheme() {
        
    }
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        navigationController.topViewController?.present(alert, animated: true, completion: nil)
    }
    
    func insertLoadingScreen() {
        let loading = LoadingViewController.instantiate()
        loading.view.tag = windowTag
        window?.addSubview(loading.view)
    }
    
    func removeLoadingScreen() {
        window?.subviews.filter({ $0.tag == windowTag }).first?.removeFromSuperview()
    }
}
