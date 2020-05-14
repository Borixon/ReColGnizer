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
    
    var flashMode: AVCaptureDevice.FlashMode = .off
    var torchMode: AVCaptureDevice.TorchMode = .off
    
    var isCameraEnabled: Bool = false
    
    override init() {
        self.captureSession = AVCaptureSession()
    }
    
    public func pause() {
        captureSession.stopRunning()
    }
    
    public func resume() {
        captureSession.startRunning()
    }
    
    public func handle(zoom: CGFloat, velocity: CGFloat) {
        guard let cam = cameraDevice else { return }
        
        let customVelocityFactor: CGFloat = zoom > 0 ? 0.05 : 200.0
        let zoomComponent = zoom * velocity * customVelocityFactor
        let finalZoomComponent: CGFloat
    
        print("zoom \(zoom)\tvelocity \(velocity)\tcustomZoom \(zoomComponent)")
        
        if (zoomComponent < 0 && cam.videoZoomFactor + zoomComponent > cam.minAvailableVideoZoomFactor) ||
            (zoomComponent > 0 && cam.videoZoomFactor + zoomComponent < cam.maxAvailableVideoZoomFactor) {
            finalZoomComponent = cam.videoZoomFactor + zoomComponent
        } else if zoomComponent > 0 && cam.videoZoomFactor + zoomComponent > cam.maxAvailableVideoZoomFactor {
            finalZoomComponent = cam.maxAvailableVideoZoomFactor
        } else if zoomComponent < 0 && cam.videoZoomFactor + zoomComponent <= cam.minAvailableVideoZoomFactor {
            finalZoomComponent = cam.minAvailableVideoZoomFactor
        } else {
            finalZoomComponent = cam.videoZoomFactor
        }
        
        do {
            try cam.lockForConfiguration()
            cam.videoZoomFactor = finalZoomComponent
            cam.unlockForConfiguration()
        } catch {
            
        }
    }
    
    public func updateFlashState(torchMode: AVCaptureDevice.TorchMode) {
        if torchMode == .off {
            self.torchMode = .on
            flashMode = .on
        } else {
            self.torchMode = .off
            flashMode = .off
        }
        
        do {
            try cameraDevice?.lockForConfiguration()
            cameraDevice?.torchMode = torchMode
            cameraDevice?.unlockForConfiguration()
        } catch {
            
        }
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
    }
    
    func startSession(completion: @escaping (Bool, Error?) -> ()) {
        do {
            try prepareCameraSession()
        } catch {
            completion(false, error)
            return
        }
        
        self.photoOutput = AVCapturePhotoOutput()
        self.photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.hevc])], completionHandler: nil)
        
        if captureSession.canAddOutput(self.photoOutput!) { captureSession.addOutput(self.photoOutput!) }
        captureSession.startRunning()
        isCameraEnabled = true
        
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
        settings.flashMode = flashMode
        photoOutput?.capturePhoto(with: settings, delegate: self)
        photoCaptureCompletionBlock = completion
    }
}

extension CameraController: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                            didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                            previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                            resolvedSettings: AVCaptureResolvedPhotoSettings,
                            bracketSettings: AVCaptureBracketedStillImageSettings?,
                            error: Swift.Error?) {
        if error != nil {
            photoCaptureCompletionBlock?(nil, error!)
        } else if let buffer = photoSampleBuffer,
            let data = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: buffer, previewPhotoSampleBuffer: nil) {
            let image = UIImage(data: data)
            photoCaptureCompletionBlock?(image, nil)
        } else {
            self.photoCaptureCompletionBlock?(nil, CameraError.unknown)
        }
    }
}
