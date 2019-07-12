//
//  DesignExtension.swift
//  CoreML App
//
//  Created by Saliou DJALO on 07/07/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    func designProcess() {
        predictionOutletView.layer.cornerRadius = 10
        predictionOutletView.clipsToBounds = true
        
        // petite animation
        predictionOutletView.isHidden = true
        predictionLabel.textColor = .white
        
        doneOutletButton.setTitleColor(.white, for: .normal)
        doneOutletButton.backgroundColor = UIColor(red: 60/255, green: 179/255, blue: 113/255, alpha: 1)
        doneOutletButton.layer.cornerRadius = 5
        doneOutletButton.clipsToBounds = true
    }
    
}
