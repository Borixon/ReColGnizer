//
//  IntroViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 08/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, Storyboarded {
    
    var coordinator: Coordinator!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
//            (self.coordinator as? MainCoordinator)?.openMenu()
//        })
    }
}
