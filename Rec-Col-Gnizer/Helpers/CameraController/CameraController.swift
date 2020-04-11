//
//  CameraController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: NSObject {
    
    var captureSession: AVCaptureSession
    var photoOutput: AVCapturePhotoOutput?
    var cameraDevice: AVCaptureDevice?
    var cameraInput: AVCaptureDeviceInput?
    var cameraOutput: AVCaptureVideoDataOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var photoCaptureCompletionBlock: ((UIImage?, Error?) -> Void)?
    var delegate: CameraControllerDelegate?
    
    override init() {
        self.captureSession = AVCaptureSession()
    }
    
    private func prepareCameraSession() throws {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                mediaType: .video,
                                                                position: .back)
        
        guard let camera = discoverySession.devices.first else { throw CameraError.noCamerasAvailable }
        
        do {
            try camera.lockForConfiguration()
            camera.activeColorSpace = .sRGB
            camera.focusMode = .continuousAutoFocus
            camera.unlockForConfiguration()
        } catch {
            throw error
        }
    
        let cameraInput = try AVCaptureDeviceInput(device: camera)
        
        if captureSession.canAddInput(cameraInput) {
            captureSession.addInput(cameraInput)
        }
        
        self.cameraInput = try AVCaptureDeviceInput(device: camera)
        self.cameraDevice = camera
        
//        cameraOutput = AVCaptureVideoDataOutput()
//        let queue = DispatchQueue.init(label: "VideoDataOutput", qos: .userInitiated, autoreleaseFrequency: .workItem)
//        cameraOutput!.setSampleBufferDelegate(self, queue: queue)
        
//        if captureSession.canAddOutput(cameraOutput!) {
//            captureSession.addOutput(cameraOutput!)
//        }
    }
    
    func startSession(completion: @escaping (Bool, Error?) -> ()) {
        do {
            try prepareCameraSession()
        } catch {
            completion(false, error)
        }
        
        self.photoOutput = AVCapturePhotoOutput()
        self.photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.hevc])], completionHandler: nil)
        
        if captureSession.canAddOutput(self.photoOutput!) { captureSession.addOutput(self.photoOutput!) }
        captureSession.startRunning()
        
        completion(true, nil)
    }
    
    func displayPreview(on subview: UIView)  {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.connection?.videoOrientation = .portrait
        previewLayer?.frame = subview.bounds
        
        if previewLayer != nil {
            subview.layer.insertSublayer(previewLayer!, at: 0)
            subview.layer.layoutSublayers()
        }
    }
    
    func captureImage(completion: @escaping (UIImage?, Error?) -> Void) {
        
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .off
        
        self.photoOutput?.capturePhoto(with: settings, delegate: self)
        self.photoCaptureCompletionBlock = completion
    }
    
}

extension CameraController: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                            resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Swift.Error?) {
        if let error = error { self.photoCaptureCompletionBlock?(nil, error) }
            
        else if let buffer = photoSampleBuffer, let data = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: buffer, previewPhotoSampleBuffer: nil),
            let image = UIImage(data: data) {
            
            self.photoCaptureCompletionBlock?(image, nil)
        }
            
        else {
            self.photoCaptureCompletionBlock?(nil, CameraError.unknown)
        }
    }
}



//
//extension CameraController: AVCaptureVideoDataOutputSampleBufferDelegate {
//    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        let ddd = CMSampleBufferGetDataBuffer(sampleBuffer)
//
//
//        guard let imageData = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
//        CVPixelBufferLockBaseAddress(imageData, .readOnly)
//        let baseAddress = CVPixelBufferGetBaseAddress(imageData);
//
//
//        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageData);
//
//        let width = 10
//        let height = 10
//
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB();
//
//        var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Little.rawValue
//        bitmapInfo |= CGImageAlphaInfo.premultipliedFirst.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
//
//        let context = CGContext.init(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
//
//        let quartzImage = context?.makeImage();
//        print("WT")
//        CVPixelBufferUnlockBaseAddress(imageData, CVPixelBufferLockFlags.readOnly);
//        delegate?.stream(image: UIImage(cgImage: quartzImage!))
//    }
//}
