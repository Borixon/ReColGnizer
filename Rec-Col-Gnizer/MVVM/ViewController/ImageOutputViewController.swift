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
    
    let imageHelper = ImageHelper()
    var colorView: UIView? = nil
    var image: UIImage? = nil
    var touchPosition: CGPoint? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        colorView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.addSubview(colorView!)
    }
    
    public func setImage(_ image: UIImage) {
        self.image = image
        if let cgImg = image.cgImage {
            imageHelper.ciImage = CIImage(cgImage: cgImg)
        }
    }
    
    private func setupGestureRecognizer() {
        let recognizer = UIGestureRecognizer()
        recognizer.delegate = self
        view.addGestureRecognizer(recognizer)
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageHelper.setupScaling(imageViewWidth: imageView.bounds.width)
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
        touchPosition = position
        colorView?.frame.origin = CGPoint(x: position.x - 25, y: position.y - 60)
        colorView?.backgroundColor = imageHelper.pixelColor(x: position.x, y: position.y)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: imageView)
        UIView.animate(withDuration: 0.1, animations: {
            self.colorView?.frame.origin = CGPoint(x: position.x - 25, y: position.y - 60)
            self.colorView?.backgroundColor = self.imageHelper.pixelColor(x: position.x, y: position.y)
            
        }, completion: { finish in
            self.touchPosition = position
        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
}
