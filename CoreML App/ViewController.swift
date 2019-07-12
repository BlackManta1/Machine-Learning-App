//
//  ViewController.swift
//  CoreML App
//
//  Created by Saliou DJALO on 07/07/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

import UIKit
import AVFoundation
import CoreML
import Vision

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var predictionOutletView: UIView!
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var doneOutletButton: UIButton!
    
    // nous permet de creer une session pour capture une image
    // un peu comme lapplication Snapchat
    var captureSession: AVCaptureSession?
    var capturePhotoOutput: AVCapturePhotoOutput?
    var captureVideoCapturePreviewLayer: AVCaptureVideoPreviewLayer?
    var cameraPosition = AVCaptureDevice.Position.back
    
    var imgPicker: UIImagePickerController?
    var arrayResult = [VNClassificationObservation]()
    var photoTook = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cameraProcess()
        designProcess()
        imagePickerProcess()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func selectFromLibraryAction(_ sender: Any) {
        print("Check : library")
        if imgPicker != nil {
            self.imgPicker?.sourceType = .photoLibrary
            self.present(self.imgPicker!, animated: true, completion: nil)
        }
    }
    
    @IBAction func takePictureAction(_ sender: Any) {
        //print("Check : take picture")
        if capturePhotoOutput != nil {
            capturePhotoOutput?.capturePhoto(with: getPhotoSettings(), delegate: self)
        }
        
    }
    
    func getPhotoSettings() -> AVCapturePhotoSettings {
        let settings = AVCapturePhotoSettings()
        settings.previewPhotoFormat = settings.embeddedThumbnailPhotoFormat
        return settings
    }
    
    @IBAction func reverseCameraAction(_ sender: Any) {
        //print("Check : reverse camera")
        switch cameraPosition {
        case .front: cameraPosition = .back
        case .back: cameraPosition = .front
        case .unspecified: cameraPosition = .back
        @unknown default: print("Error on reversing camera")
        }
        cameraProcess()
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.predictionOutletView.center = CGPoint(x: self.predictionOutletView.center.x, y: self.predictionOutletView.center.y + 600)
        }
    }
    
    @IBAction func moreDetailsAction(_ sender: Any) {
        performSegue(withIdentifier: "toDetailsViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsViewController" {
            let detailsViewController = segue.destination as! DetailsViewController
            detailsViewController.arrayResult = arrayResult
            detailsViewController.photoTook = photoTook
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let err = error {
            print(err.localizedDescription)
        } else {
            if let data = photo.fileDataRepresentation() {
                request(data: data)
                photoTook.image = UIImage(data: data)
            } else {
                print("Result give no data")
            }
        }
    }
    
}

