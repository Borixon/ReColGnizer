//
//  FavoriteViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class FavoriteViewController: BaseViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func printData(_ sender: UIButton) {
        let data = CoreDataManager.shared.getColorsList()
    }
}
