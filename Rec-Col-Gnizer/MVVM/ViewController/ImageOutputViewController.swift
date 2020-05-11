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
    var colorView: UIView! // Zmiana na jakis klase/struktore/view
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        colorView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.addSubview(colorView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutSubviews()
        setupImageView()
        setupViewModel()
        setupGestureRecognizer()
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
//        let data = RgbRequestData(value: RgbModel(r: Int16(r * 255), g: Int16(g * 255), b: Int16(b * 255)))
//        WebService().getColorFrom(data: data).done { model in
//            self.coordinator?.openColorData(data: ColorModel(color: model))
//        }.catch { error in //todo
//            self.coordinator?.showAlert(title: "Error", message: error.localizedDescription)
//        }
    }
}

extension ImageOutputViewController: UIGestureRecognizerDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: imageView)
        vm.receive(position)
        colorView?.frame.origin = CGPoint(x: position.x - 25, y: position.y - 60)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: imageView)
        vm.receive(position)
        UIView.animate(withDuration: 0.1, animations: {
            self.colorView?.frame.origin = CGPoint(x: position.x - 25, y: position.y - 60)

        }, completion: { finish in

        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
}

extension ImageOutputViewController: ImageOutputViewModelDelegate {
    func animateTouchToPosition() {
        
    }
    
    func receiveColor(_ color: UIColor?) {
        colorView?.backgroundColor = color
    }
}
