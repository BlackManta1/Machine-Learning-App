//
//  PickerExtension.swift
//  CoreML App
//
//  Created by Saliou DJALO on 10/07/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

import Foundation
import UIKit

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerProcess() {
        // my UI picker
        imgPicker = UIImagePickerController()
        imgPicker?.delegate = self
        imgPicker?.allowsEditing = true
        
    }
    
    // Ajout des protocoles
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imgPicker?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var img:UIImage?
        if let imgEdited = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            img = imgEdited
        } else if let imgOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            img = imgOriginal
        }
        
        if let data = img?.pngData() {
            request(data: data)
        }
        photoTook.image = img
        print("Img Picker Done")
        imgPicker?.dismiss(animated: true, completion: nil)
    }
    
}


