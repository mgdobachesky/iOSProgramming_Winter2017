//
//  TaxSettingsViewController.swift
//  QuikAns
//
//  Created by ios class on 2/20/17.
//  Copyright © 2017 neit. All rights reserved.
//

import UIKit
import os.log

class TaxSettingsViewController: UIViewController, UITextFieldDelegate {

    var Rate: Double = 5
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.generatesDecimalNumbers = true
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    @IBOutlet weak var rateDetails: UITextField!
    
    @IBAction func setRateValue(_ textField: UITextField) {
        if let rate = numberFormatter.number(from: textField.text!) as Double? {
            let percentage = rate / 100
            Rate = percentage
            saveRate()
        } else {
            Rate = 5
            saveRate()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load saved data, otherwise load sample data
        if let savedData = loadRate() {
            Rate = savedData * 100
        } else {
            // Load the sample data.
            Rate = 5
        }
        
        rateDetails.text = String(Rate)
    }
    
    private func saveRate() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Rate, toFile: TaxSettings.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Rate successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save rate...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadRate() -> Double? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: TaxSettings.ArchiveURL.path) as? Double
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
