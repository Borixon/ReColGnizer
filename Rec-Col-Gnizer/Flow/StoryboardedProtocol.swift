//
//  Storyboarded.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import Foundation

protocol StoryboardedProtocol { 
    static func instantiate() -> Self
}

extension StoryboardedProtocol where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        let selfVC = vc as! Self
        return selfVC
    }
    
    static func instantiate(withIdentifier id: String) -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        let selfVC = vc as! Self
        return selfVC
    }
}

