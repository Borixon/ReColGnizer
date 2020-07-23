//
//  CameraControllerProtocol.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

protocol CameraControllerDelegate {
    func stream(image: UIImage)
}
