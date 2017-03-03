//
//  GasSettingsViewController.swift
//  QuikAns
//
//  Created by ios class on 2/26/17.
//  Copyright © 2017 neit. All rights reserved.
//

import UIKit
import os.log

class GasSettingsViewController: UIViewController, UITextFieldDelegate {
    
    var Price: Double = 2.50
    var Mileage: Double = 25
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.generatesDecimalNumbers = true
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    @IBOutlet weak var mpgDetails: UITextField!
    @IBOutlet weak var gasCostDetails: UITextField!
    
    @IBAction func setPriceValue(_ textField: UITextField) {
        if let price = numberFormatter.number(from: textField.text!) as Double? {
            Price = price
            saveData()
        } else {
            Price = 2.50
            saveData()
        }
    }
    
    @IBAction func setMileageValue(_ textField: UITextField) {
        if let mileage = numberFormatter.number(from: textField.text!) as Double? {
            Mileage = mileage
            saveData()
        } else {
            Mileage = 25
            saveData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load saved data, otherwise load sample data
        if let savedData = loadData() {
            Price = savedData.Price
            Mileage = savedData.Mileage
        } else {
            // Load the sample data.
            Price = 2.50
            Mileage = 25
        }
        
        mpgDetails.text = String(Mileage)
        gasCostDetails.text = String(Price)
    }
    
    private func saveData() {
        let gasData = GasSettings(price: Price, mileage: Mileage)
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(gasData!, toFile: GasSettings.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Gas Settings successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save rate...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadData() -> GasSettings? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: GasSettings.ArchiveURL.path) as? GasSettings
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
