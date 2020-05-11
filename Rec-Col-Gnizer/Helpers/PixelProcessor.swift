//
//  ImageHelper.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 02/05/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class PixelProcessor: NSObject {

    let scale: CGFloat
    let offsetX: CGFloat
    let image: CGImage
    let width: Int
    let height: Int
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    init(image: CGImage, uiImageSize: CGSize) {
        self.image = image
        self.width = image.width
        self.height = image.height
        self.scale = CGFloat(height) / uiImageSize.width
        self.offsetX = (CGFloat(image.width) - (uiImageSize.height * scale)) / 2
    }
    
    private func convertCoordinatesToPixelIndex(_ x: Int, _ y: Int) -> Int {
        let posX = Int(CGFloat(y) * scale) + Int(offsetX)
        let posY = height - Int(CGFloat(x) * scale)
        return (width * posY) + posX
    }
    
    private func converPixelBufferToHex(pixelBuffer: UnsafeMutablePointer<UInt32>, index: Int) -> String {
        let hex = String(format: "%#08x", pixelBuffer[index]).replacingOccurrences(of: "0xff", with: "")
        var charArray = Array(hex)
        charArray.swapAt(0, 4)
        charArray.swapAt(1, 5)
        return String(charArray)
    }
    
    func processColor(x: Int, y: Int) -> UIColor? {
        
        let bytesPerRow = width * 4
        let bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
        guard let imageContext = CGContext(data: nil,
                                           width: width,
                                           height: height,
                                           bitsPerComponent: 8,
                                           bytesPerRow: bytesPerRow,
                                           space: colorSpace,
                                           bitmapInfo: bitmapInfo),
            let rawPointer = imageContext.data
            else { return nil }
        
        let pixelBuffer = rawPointer.bindMemory(to: UInt32.self, capacity: width * height)
        
        imageContext.draw(image, in: CGRect(origin: .zero, size: CGSize(width: width, height: height)))
        let index = convertCoordinatesToPixelIndex(x, y)
        let hex = converPixelBufferToHex(pixelBuffer: pixelBuffer, index: index)
        
        return UIColor(hexString: hex)
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
        
//        self.image = contextRef?.makeImage()
    }
    
}
