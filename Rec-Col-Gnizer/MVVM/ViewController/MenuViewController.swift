//
//  MenuViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 08/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, Storyboarded {
    
    var coordinator: Coordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = ColorRandomiezer.randomColor
    }
    
    @IBAction func openRGBPicker(_ sender: Any) {
        (coordinator as? MainCoordinator)?.openRGBPicker()
    }
    
}
