//
//  CoreMLExtension.swift
//  CoreML App
//
//  Created by Saliou DJALO on 11/07/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

import Foundation
import UIKit
import CoreML
import Vision

extension ViewController {
    
    
    func request(data: Data) {
        do {
            let coreMLModel = try VNCoreMLModel(for: MobileNetV2().model)
            let coreMLrequest = VNCoreMLRequest(model: coreMLModel, completionHandler: response)
            let requestHandler = VNImageRequestHandler(data: data, options: [:])
            try requestHandler.perform([coreMLrequest])
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func response(_ request: VNRequest, _ error: Error?) {
        if let results = request.results as? [VNClassificationObservation] {
            // classer par ordre decroissant de Forecast
            let sortedResultats = results.sorted(by: {$0.confidence > $1.confidence})
            if sortedResultats.count > 0 {
                
                // je dois recuperer le tableau sortedResults pour mon view Details
                arrayResult = sortedResultats
                
                let bestResult = sortedResultats[0]
                let attributed = NSMutableAttributedString(string: bestResult.identifier, attributes: [.font: UIFont.boldSystemFont(ofSize: 18)])
                let forecastedValue = Int((bestResult.confidence*100).rounded())
                // ATTENTION : IL S'AGIT d'un NSAttributedString pas d'un NSMutableAttributedString
                let confidence = NSAttributedString(string: "\n Confidence : " + String(forecastedValue) + "%", attributes: [.foregroundColor: UIColor.white])
                attributed.append(confidence)
                
                // et donc a partir de cette instant je peux faire apparaitre mon pop up
                predictionOutletView.isHidden = false
                predictionLabel.attributedText = attributed
                // cette portion de code nous sera utile pour afficher le pop up
                predictionOutletView.center = CGPoint(x: predictionOutletView.center.x, y: predictionOutletView.center.y + 600)
                UIView.animate(withDuration: 1.5) {
                    self.predictionOutletView.center = CGPoint(x: self.predictionOutletView.center.x, y: self.predictionOutletView.center.y - 600)
                }
                
            }
            
        }
    }
    
    
}

