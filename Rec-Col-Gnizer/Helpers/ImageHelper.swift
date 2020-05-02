//
//  ImageHelper.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 02/05/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class ImageHelper: NSObject {

    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    var imageWidth: Int = 0
    var scale: CGFloat = 1
    var image: CGImage? = nil
    var ciImage: CIImage? = nil
    
    
    // TODO: so muhc to do... :(
    func pixelColor(x: CGFloat, y: CGFloat) -> UIColor? {
        guard let inputImage = ciImage else { return nil }
        let width = inputImage.extent.size.width
        let height = inputImage.extent.size.height
        let extentVector = CIVector(x: x * scale, y: y * scale, z: width, w: height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
    
    func setupScaling(imageViewWidth: CGFloat) {
        guard let imageWidth = image?.width else { return }
        self.imageWidth = imageWidth
        scale = CGFloat(imageWidth) / imageViewWidth
    }
    
    func addImage(_ image: CGImage?, fromPosition: UIImage.Orientation = .right) {
        guard let cgImage = image else { return }
        guard let colorSpace = cgImage.colorSpace else { return }
        
        let originalWidth = cgImage.width
        let originalHeight = cgImage.height
        let bitsPerComponent = cgImage.bitsPerComponent
        let bytesPerRow = cgImage.bytesPerRow
        let bitmapInfo = cgImage.bitmapInfo
        
        let degreesToRotate: Double = 270
        let radians = degreesToRotate * Double.pi / 180.0
        
        let width: Int = originalHeight
        let height: Int = originalWidth
        let contextRef = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        contextRef?.translateBy(x: CGFloat(width) / 2.0, y: CGFloat(height) / 2.0)
        
        contextRef?.rotate(by: CGFloat(radians))
        contextRef?.translateBy(x: -CGFloat(height) / 2.0, y: -CGFloat(width) / 2.0)
        contextRef?.draw(cgImage, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(originalWidth), height: CGFloat(originalHeight)))
        
        self.image = contextRef?.makeImage()
    }
    
    func getPixelColor(forPosition position: CGPoint) -> UIColor? {
        guard let img = self.image else { return nil }
        let data = img.dataProvider!.data
        guard let pixelBytes = CFDataGetBytePtr(data) else { return nil }
        let y = img.height - Int(position.x * scale)
        let x = Int(position.y * scale)
        let pixelInfo: Int = ((imageWidth * y) + x) * 4

        r = CGFloat(pixelBytes[pixelInfo]) / CGFloat(255.0)
        g = CGFloat(pixelBytes[pixelInfo+1]) / CGFloat(255.0)
        b = CGFloat(pixelBytes[pixelInfo+2]) / CGFloat(255.0)
        a = CGFloat(pixelBytes[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(displayP3Red: r, green: g, blue: b, alpha: a)
    }
}
