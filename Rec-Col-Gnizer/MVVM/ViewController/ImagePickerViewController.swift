//
//  CameraCaptureViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 08/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import AVFoundation

final class ImagePickerViewController: BaseViewController {
    
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var viewfinder: UIView!
    @IBOutlet weak var photoButton: UIButton!
    
    var vm = ImagePickerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupPinchGesture()
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.vm.pauseSession()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.vm.resumeSession()
        }
    }
    
    // MARK: Public functions
    public func handle(image: UIImage) {
        coordinator?.openPhoto(image)
    }
    
    public func startCameraSession() {
        DispatchQueue.main.async {
            self.vm.startCameraSession()
        }
    }
   
    // MARK: Private functions
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupPinchGesture() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        view.addGestureRecognizer(pinch)
    }
    
    private func setupViewModel() {
        view.layoutSubviews()
        vm.controller = self
        vm.setupPreview(viewfinder)
    }
    
    private func setButtonImage() {
        if #available(iOS 13.0, *) {
            let bolt: UIImage?
            if vm.isTorchOn {
                bolt = UIImage(systemName: "bolt.fill")
            } else {
                bolt = UIImage(systemName: "bolt")
            }
            flashButton.setBackgroundImage(bolt, for: .normal)
        } else {
            // TODO: iOS 12
        }
    }
    
    // MARK: IBActions and selectors
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        vm.zooming(sender.scale, sender.velocity)
    }
    
    @IBAction func flashAction(_ sender: Any) {
        vm.changeFlashState()
        setButtonImage()
    }
    
    @IBAction func snapshot(_ sender: Any) {
        vm.takeSnapshot()
    }
}
