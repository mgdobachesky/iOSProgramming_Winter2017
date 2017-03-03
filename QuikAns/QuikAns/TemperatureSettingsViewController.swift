//
//  TemperatureSettingsViewController.swift
//  QuikAns
//
//  Created by ios class on 2/26/17.
//  Copyright © 2017 neit. All rights reserved.
//

import UIKit
import os.log

class TemperatureSettingsViewController: UIViewController, UITextFieldDelegate {
    
    var ConvertTo: String = "celsius"
    
    @IBOutlet weak var convertToDetails: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load saved data, otherwise load sample data
        if let savedData = loadData() {
            ConvertTo = savedData
        } else {
            // Load the sample data.
            ConvertTo = "celsius"
        }
        
        if ConvertTo == "celsius" {
            convertToDetails.selectedSegmentIndex = 0
        } else if ConvertTo == "fahrenheit" {
            convertToDetails.selectedSegmentIndex = 1
        }
    }
    
    @IBAction func setConvertToValue(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            ConvertTo = "celsius"
        case 1:
            ConvertTo = "fahrenheit"
        default:
            break
        }
        
        saveData()
    }
    
    private func saveData() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(ConvertTo, toFile: TemperatureSettings.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("ConvertTo successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save rate...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadData() -> String? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: TemperatureSettings.ArchiveURL.path) as? String
    }
    
}
