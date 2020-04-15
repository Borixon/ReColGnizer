//
//  CameraCaptureViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 08/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import AVFoundation

class CameraCaptureViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var viewfinder: UIView!
     
    var coordinator: Coordinator!
    let cameraController = CameraController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startCamera()
    }
    
    private func startCamera() {
        DispatchQueue.main.async {
            self.cameraController.startSession(completion: { success, error in
                if success {
                    self.cameraController.delegate = self
                    self.cameraController.displayPreview(on: self.viewfinder)
                } else {
                    // Print Error
                }
            })
        }
    }
    
    private func prepareZoomSlider() {
//        zoomSlider.minimumValue = Float(cameraController.cameraDevice?.minAvailableVideoZoomFactor ?? 1)
//        zoomSlider.maximumValue = Float(cameraController.cameraDevice?.maxAvailableVideoZoomFactor ?? 1)
//        zoomSlider.value = zoomSlider.minimumValue
    }
    
    private func prepareView() {
        
    }
    
    @IBAction func valueChange(_ sender: UISlider) {
//        let zoomValue = CGFloat(sender.value)
//
//        do {
//            try cameraController.cameraDevice?.lockForConfiguration()
//            cameraController.cameraDevice?.videoZoomFactor = zoomValue
//            cameraController.cameraDevice?.unlockForConfiguration()
//        } catch {
//
//        }
    }
    
}

extension CameraCaptureViewController: CameraControllerDelegate {
    func stream(image: UIImage) {

    }
} 
