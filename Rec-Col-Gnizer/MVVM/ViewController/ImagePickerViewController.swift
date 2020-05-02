//
//  CameraCaptureViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 08/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import AVFoundation

class ImagePickerViewController: BaseViewController {
    
    @IBOutlet weak var viewfinder: UIView!
    @IBOutlet weak var photoButton: UIButton!
    
    var vm = ImagePickerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.controller = self
        setupPinchGesture()
        setupCamera()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        vm.pauseSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vm.resumeSession()
    }
    
    private func setupPinchGesture() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        view.addGestureRecognizer(pinch)
    }
    
    private func setupCamera() {
        vm.startCamera(on: viewfinder, completion: { success, error in
            if error != nil {
                
            }
        })
    }
    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        vm.zooming(sender.scale, sender.velocity)
    }
    
    @IBAction func snapshot(_ sender: Any) {
        vm.takeSnapshot()
    }
    
    public func handle(image: UIImage) {
        coordinator?.openPhoto(image)
    }
}
