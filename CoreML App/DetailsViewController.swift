//
//  DetailsViewController.swift
//  CoreML App
//
//  Created by Saliou DJALO on 12/07/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

import UIKit
import CoreML
import Vision

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var arrayResult = [VNClassificationObservation]()
    var photoTook = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewProcess()
        imgView.image = photoTook.image
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
