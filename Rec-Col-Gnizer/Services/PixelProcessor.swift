//
//  ImageHelper.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 02/05/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class PixelProcessor: NSObject {

    private let scale: CGFloat
    private let offsetX: CGFloat
    private let image: CGImage
    private let width: Int
    private let height: Int
    private let colorSpace = CGColorSpaceCreateDeviceRGB()
    private var hex: String?
    
    var hexValue: String {
        if let hex = self.hex {
            return hex
        }
        return "000000"
    }
    
    init(image: CGImage, uiImageSize: CGSize) {
        self.image = image
        self.width = image.width
        self.height = image.height
        self.scale = CGFloat(height) / uiImageSize.width
        self.offsetX = (CGFloat(image.width) - (uiImageSize.height * scale)) / 2
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
        self.hex = hex
        
        return UIColor(hexString: hex)
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
    
}
