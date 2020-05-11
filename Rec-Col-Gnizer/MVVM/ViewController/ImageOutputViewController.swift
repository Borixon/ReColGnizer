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
            coordinator?.showAlert(message: error.localizedDescription)
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        coordinator?.popViewController()
    }
    
    @IBAction func checkColorData(_ sender: Any) {
        WebService().getColorFrom(data: vm.requestData).done { model in
            self.coordinator?.openColorData(data: ColorModel(color: model))
        }.catch { error in // todo
            self.coordinator?.showAlert(title: "Error", message: error.localizedDescription)
        }
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
}

extension ImageOutputViewController: ImageOutputViewModelDelegate {
    func animateTouchToPosition() {
        
    }
    
    func receiveColor(_ color: UIColor?) {
        colorView.setColor(color)
    }
}
