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
    let pointOffsetY: CGFloat = 40
    var delegate: ImageOutputViewModelDelegate?
    var pinSize: CGSize!
    
    var requestData: HexRequestData {
        return HexRequestData(value: HexModel(value: pixelProcessor.hexValue))
    }
    
    func setup(imageViewSize: CGSize, image: UIImage) throws {
        guard let cgimage = image.cgImage else { throw ImageError.noCGImage }
        pixelProcessor = PixelProcessor(image: cgimage, uiImageSize: imageViewSize)
    }
    
    func receive(_ position: CGPoint) {
        delegate?.receiveColor(pixelProcessor.processColor(x: Int(position.x), y: Int(position.y)))
    }
    
    func pointForPin(position: CGPoint) -> CGPoint {
        return CGPoint(x: position.x - pinSize.width/2, y: position.y - pinSize.height)
    }
    
    func convertPoint(position: inout CGPoint) {
        position.y = position.y - pointOffsetY
    }
}

