//
//  CameraPickerViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 18/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import AVFoundation

class ImagePickerViewModel {
    
    let nibName = "SliderCell"
    var controller: ImagePickerViewController!
    let cameraController = CameraController()
    private var torchMode: AVCaptureDevice.TorchMode = .off
    private var error: Error?
    
    public var isTorchOn: Bool {
        return torchMode == .on ? true : false
    }
    
    public func setupPreview(_ view: UIView) {
        if cameraController.isCameraEnabled {
            cameraController.displayPreview(on: view)
        } else if error != nil {
            // TODO: Print error
        }
    }
    
    public func startCameraSession() {
        DispatchQueue.main.async {
            self.cameraController.startSession(completion: { _, error in
                if error != nil {
                    self.error = error
                } else {
                    self.error = CameraError.noCamerasAvailable
                }
            })
        }
    }
    
    public func takeSnapshot() {
        cameraController.captureImage(completion: { image, error in
            if let snapShot = image {
                self.controller.handle(image: snapShot)
            } else if error != nil {
                // TODO: print eyyoy
            } else {
                // TODO: Sumtin wong
            }
        })
    }
    
    public func changeFlashState() {
        torchMode = (torchMode == .on ? .off : .on)
        cameraController.updateFlashState(torchMode: torchMode)
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
