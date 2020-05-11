//
//  ImageOutputViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 06/05/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

protocol ImageOutputViewModelDelegate {
    func animateTouchToPosition()
    func receiveColor(_ color: UIColor?)
}

class ImageOutputViewModel {
    
    private var pixelProcessor: PixelProcessor!
    var delegate: ImageOutputViewModelDelegate?
    
    func setup(imageViewSize: CGSize, image: UIImage) throws {
        guard let cgimage = image.cgImage else { throw ImageError.noCGImage }
        pixelProcessor = PixelProcessor(image: cgimage, uiImageSize: imageViewSize)
    }
    
    func receive(_ position: CGPoint) {
        delegate?.receiveColor(pixelProcessor.processColor(x: Int(position.x), y: Int(position.y)))
    }
}

