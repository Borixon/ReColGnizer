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
//        loadingCoordinator?.start()
    }
    
    func hideLoadingScreen() {
//        loadingCoordinator?.finish()
    }
}

protocol BaseViewControllerProtocol {
    func hideLoadingScreen()
    func openLoadingScreen()
    var coordinator: MainCoordinator? { get set }
}
