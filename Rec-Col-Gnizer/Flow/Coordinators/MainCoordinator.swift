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
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            self.navigationController.topViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func insertLoadingScreen() {
        let loading = LoadingViewController.instantiate()
        loading.view.tag = windowTag
        loading.view.alpha = 0
        navigationController.topViewController?.view.addSubview(loading.view)
        UIView.animate(withDuration: 0.1, animations: {
            loading.view.alpha = 1
        })
    }
    
    func removeLoadingScreen() {
        let loading = navigationController.topViewController?.view.subviews.filter({ $0.tag == windowTag }).first
        UIView.animate(withDuration: 0.1, animations: {
            loading?.alpha = 0
        }, completion: { finish in
            loading?.removeFromSuperview()
        })
    }
}
