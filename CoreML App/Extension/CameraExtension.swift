//
//  CameraExtension.swift
//  CoreML App
//
//  Created by Saliou DJALO on 07/07/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

// cest beaucoup mieux de passer par des extension le code est plus propre

import Foundation
import UIKit
import AVFoundation

extension ViewController {
    
    func cameraProcess() {
        // juste je remove ce quil y a avant, avant de vraiment commencer pour eviter tout bug possible
        captureVideoCapturePreviewLayer?.removeFromSuperlayer()
        captureSession = AVCaptureSession() // initialisation
        if let myCaptureSession = captureSession {
            // device creation
            if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPosition) {
                do {
                    let input = try AVCaptureDeviceInput(device: device)
                    if myCaptureSession.canAddInput(input) {
                        myCaptureSession.addInput(input)
                        capturePhotoOutput = AVCapturePhotoOutput()
                        if let myCapturePhotoOutput = capturePhotoOutput {
                            if myCaptureSession.canAddOutput(myCapturePhotoOutput) {
                                myCaptureSession.addOutput(myCapturePhotoOutput)
                                captureVideoCapturePreviewLayer = AVCaptureVideoPreviewLayer(session: myCaptureSession)
                                captureVideoCapturePreviewLayer?.videoGravity = .resizeAspectFill
                                captureVideoCapturePreviewLayer?.connection?.videoOrientation = .portrait
                                if let myCaptureVideoCapturePreviewLayer = captureVideoCapturePreviewLayer {
                                    myCaptureVideoCapturePreviewLayer.frame = cameraView.bounds
                                    cameraView.layer.addSublayer(myCaptureVideoCapturePreviewLayer)
                                    // here : how to take a picture
                                    captureSession?.startRunning()
                                }
                            }
                        }
                    }
                } catch let err {
                    print(err.localizedDescription)
                }
            }
        }
    }
}
