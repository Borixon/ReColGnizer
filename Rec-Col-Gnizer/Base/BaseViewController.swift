//
//  BaseViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 11/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController, BaseViewControllerProtocol {
 
    var coordinator: MainCoordinator?
    
    func openLoadingScreen() {
        DispatchQueue.main.async {
            self.coordinator?.insertLoadingScreen()
        }
    }
    
    func hideLoadingScreen() {
        DispatchQueue.main.async {
            self.coordinator?.removeLoadingScreen()
        }
    }
}

protocol BaseViewControllerProtocol {
    func hideLoadingScreen()
    func openLoadingScreen()
    var coordinator: MainCoordinator? { get set }
}
