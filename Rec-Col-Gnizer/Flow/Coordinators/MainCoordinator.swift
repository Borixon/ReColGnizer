//
//  IntroCoordinator.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import PromiseKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: NavigationController
    var tabBar: TabController?
    
    required init() {
        navigationController = NavigationController()
        navigationController.modalPresentationStyle = .fullScreen
    }
    
    func start() {
        let introVC = IntroViewController.instantiate()
        introVC.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.setViewControllers([introVC], animated: true)
    }
    
    func openTabBar() {
        tabBar = TabController.instantiate()
        tabBar?.setupViewControllers()
        tabBar?.viewControllers?.forEach { vc in
            ((vc as? NavigationController)?.viewControllers.first as? BaseViewController)?.coordinator = self
        }
        tabBar?.modalPresentationStyle = .fullScreen
        navigationController.present(tabBar!, animated: true, completion: nil)
    }
    
    func openColorData(data: ColorModel) {
        guard let navigation = selectedTabNavigationController else { return }
        let vc = ColorDataViewController.instantiate()
        vc.vm = ColorDataViewModel(model: data)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        navigation.present(vc, animated: true, completion: nil)
    }
    
    func openColorScheme() {
        
    }
    
    func openSortingView(withTypeSelected type: SortingType, delegate: SortingViewDelegate) {
        guard let navigation = selectedTabNavigationController else { return }
        let vc = SortingViewController.instantiate()
        vc.setCurrent(sortingType: type)
        vc.coordinator = self
        vc.delegate = delegate
        navigation.modalPresentationStyle = .overCurrentContext
        navigation.present(vc, animated: true, completion: nil)
    }
    
    func openPhoto(_ image: UIImage) {
        guard let navigation = selectedTabNavigationController else { return }
        let vc = ImageOutputViewController.instantiate()
        vc.coordinator = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.image = image
        navigation.present(vc, animated: true, completion: nil)
    }
    
    
    func showError(_ error: Error) {
        guard let navigation = selectedTabNavigationController else { return }
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        navigation.topViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    func showAlert(title: String, message: String) {
        guard let navigation = selectedTabNavigationController else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        navigation.topViewController?.present(alert, animated: true, completion: nil)
    }
    
    func insertLoadingScreen() {
        let loading = LoadingViewController.instantiate()
        loading.view.tag = ViewTags.loadingViewTag.rawValue
        loading.view.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(loading.view)
        UIView.animate(withDuration: 0.1, animations: {
            loading.view.alpha = 1
        })
    }
    
    func removeLoadingScreen() { 
        let loading = UIApplication.shared.keyWindow?.subviews.filter({ $0.tag == ViewTags.loadingViewTag.rawValue }).first
        UIView.animate(withDuration: 0.1, animations: {
            loading?.alpha = 0
        }, completion: { finish in
            loading?.removeFromSuperview()
        })
    }
    
    func dismissViewController() {
        selectedTabNavigationController?.dismiss(animated: true, completion: nil)
    }
    
    private var selectedTabNavigationController: NavigationController? {
        return tabBar?.selectedViewController as? NavigationController
    }
}

enum ViewTags: Int {
    case loadingViewTag = 100
}
