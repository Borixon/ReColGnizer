//
//  ImageOutputViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 27/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class ImageOutputViewController: BaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet var gestureRecognizer: UIGestureRecognizer!
    
    let vm = ImageOutputViewModel()
    var colorView: PinViewController!
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPinColorView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutSubviews()
        setupImageView()
        setupViewModel()
        setupGestureRecognizer()
    }
    
    private func setupCheckButton() {
        checkButton.layer.zPosition = 1
    }
    
    private func setupPinColorView() {
        colorView = PinViewController()
        view.addSubview(colorView.view)
        addChild(colorView)
        vm.pinSize = colorView.viewSize
        colorView.view.frame.origin = CGPoint(x: -100, y: -100)
    }
    
    private func setupGestureRecognizer() {
        gestureRecognizer.delegate = self
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
    }
    
    public func setupViewModel() {
        do {
            vm.delegate = self
            try vm.setup(imageViewSize: imageView.bounds.size, image: image)
        } catch {
            coordinator?.showError(error)
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        coordinator?.popViewController()
    }
    
    @IBAction func checkColorData(_ sender: Any) {
        openLoadingScreen()
        vm.checkColor()
    }
}

extension ImageOutputViewController: UIGestureRecognizerDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var position = touch.location(in: imageView)
        vm.convertPoint(position: &position)
        vm.receive(position)
        colorView.view.frame.origin = vm.pointForPin(position: position)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var position = touch.location(in: imageView)
        vm.convertPoint(position: &position)
        vm.receive(position)
        UIView.animate(withDuration: 0.1, animations: {
            self.colorView.view.frame.origin = self.vm.pointForPin(position: position)
        })
    }
}

extension ImageOutputViewController: ImageOutputViewModelDelegate {
    func show(color: ColorModel?, error: Error?) {
        hideLoadingScreen()
        if let color = color {
            self.coordinator?.openColorData(data: color)
        } else if let error = error {
            self.coordinator?.showError(error)
        }
    }
    
    func receiveColor(_ color: UIColor?) {
        colorView.setColor(color)
    }
}
