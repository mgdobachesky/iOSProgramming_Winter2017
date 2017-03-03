//
//  InterestSettingsViewController.swift
//  QuikAns
//
//  Created by ios class on 2/26/17.
//  Copyright © 2017 neit. All rights reserved.
//

import UIKit
import os.log

class InterestSettingsViewController: UIViewController, UITextFieldDelegate {
    
    var Rate: Double = 4.25
    @IBOutlet weak var rateDetails: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load saved data, otherwise load sample data
        if let savedData = loadRate() {
            Rate = savedData * 100
        } else {
            // Load the sample data.
            Rate = 4.25
        }
        
        rateDetails.text = String(Rate)
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.generatesDecimalNumbers = true
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    @IBAction func setRateValue(_ textField: UITextField) {
        if let rate = numberFormatter.number(from: textField.text!) as Double? {
            let percentage = rate / 100
            Rate = percentage
            saveRate()
        } else {
            Rate = 4.25
            saveRate()
        }
    }
    
    private func saveRate() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Rate, toFile: InterestSettings.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Rate successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save rate...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadRate() -> Double? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: InterestSettings.ArchiveURL.path) as? Double
    }
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    
}
