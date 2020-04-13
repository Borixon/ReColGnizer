//
//  IntroViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 08/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var mainTitle: UILabel!
    var coordinator: Coordinator!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, delay: 2, options: .curveEaseOut, animations: {
            self.mainTitle.alpha = 0
        }, completion: { finish in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
                (self.coordinator as? MainCoordinator)?.openTabBar()
            })
        })
    }
}
