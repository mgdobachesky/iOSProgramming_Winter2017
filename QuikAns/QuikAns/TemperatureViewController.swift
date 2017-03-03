//
//  TemperatureViewController.swift
//  QuikAns
//
//  Created by ios class on 2/20/17.
//  Copyright © 2017 neit. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController, UITextFieldDelegate {
    var Temperature: Double? = nil
    var ConvertTo: String = "celsius"
    
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
            descriptionLabel.text = "degrees fahrenheit is"
        } else if ConvertTo == "fahrenheit" {
            descriptionLabel.text = "degrees celsius is"
        }
        
        calculateAnswer()
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.generatesDecimalNumbers = true
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBAction func setTemperatureValue(_ textField: UITextField) {
        if let temperature = numberFormatter.number(from: textField.text!) as Double? {
            Temperature = temperature
        } else {
            Temperature = nil
        }
        
        calculateAnswer()
    }
    
    func calculateAnswer() {
        if Temperature != nil, ConvertTo == "celsius" {
            let answer: Double = (Temperature! - 32) * (5 / 9)
            answerLabel.text = numberFormatter.string(from: (value: answer) as NSNumber)! + " degrees celsius"
        } else if Temperature != nil, ConvertTo == "fahrenheit" {
            let answer: Double = Temperature! * 1.8 + 32
            answerLabel.text = numberFormatter.string(from: (value: answer) as NSNumber)! + " degrees fahrenheit"
        }
    }
    
    private func loadData() -> String? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: TemperatureSettings.ArchiveURL.path) as? String
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
