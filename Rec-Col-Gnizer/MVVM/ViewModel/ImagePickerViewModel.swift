//
//  CameraPickerViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 18/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class ImagePickerViewModel {
    
    public var controller: ImagePickerViewController!
    public let cameraController = CameraController()
    
    public func startCamera(on view: UIView, completion: @escaping(Bool, Error?) -> ()) {
        DispatchQueue.main.async {
            self.cameraController.startSession(completion: { success, error in
                if success {
                    self.cameraController.displayPreview(on: view)
                    completion(true, nil)
                } else {
                    if error != nil {
                        completion(false, error)
                    } else {
                        completion(false, CameraError.noCamerasAvailable)
                    }
                }
            })
        }
    }
    
    public func takeSnapshot() {
        cameraController.captureImage(completion: { image, error in
            if let snapShot = image {
                self.controller.handle(image: snapShot)
            } else if error != nil {
                // print eyyoy
            } else {
                // Sumtin wong
            }
        })
    }
    
    public func changeFlashState() {
        cameraController.updateFlashState()
    }
    
    public func pauseSession() {
        cameraController.pause()
    }
    
    public func resumeSession() {
        if cameraController.isCameraEnabled {
            cameraController.resume()
        }
    }
    
    public func zooming(_ zoom: CGFloat, _ velocity: CGFloat) {
        cameraController.handle(zoom: zoom, velocity: velocity)
    }
}
