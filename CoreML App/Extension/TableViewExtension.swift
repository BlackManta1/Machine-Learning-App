//
//  TableViewExtension.swift
//  CoreML App
//
//  Created by Saliou DJALO on 12/07/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

import Foundation
import UIKit

extension DetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableViewProcess() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = false
        tableView.allowsSelection = false
        addTopRow()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrayResult.count > 0 {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellReuseID")
            cell.textLabel?.text = arrayResult[indexPath.row].identifier
            let forecastedValue = Int((arrayResult[indexPath.row].confidence*100).rounded())
            cell.detailTextLabel?.text = "Confidence : " + String(forecastedValue) + "%"
            return cell
        } else {
            return UITableViewCell()
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "RANKING"
        }
        return ""
    }
    
    func addTopRow() {
        // Pour rajouter une ligne au dessus
        let px = 1 / UIScreen.main.scale
        let frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: px)
        let line = UIView(frame: frame)
        self.tableView.tableHeaderView = line
        line.backgroundColor = self.tableView.separatorColor
    }
    
}
