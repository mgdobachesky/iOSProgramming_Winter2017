//
//  InterestViewController.swift
//  QuikAns
//
//  Created by ios class on 2/20/17.
//  Copyright © 2017 neit. All rights reserved.
//

import UIKit

class InterestViewController: UIViewController, UITextFieldDelegate {
    
    var Principal: Double? = nil
    var Rate: Double? = nil
    var Time: Double? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load saved data, otherwise load sample data
        if let savedData = loadRate() {
            Rate = savedData
        } else {
            // Load the sample data.
            Rate = 0.0425
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
    
    @IBAction func setPrincipalValue(_ textField: UITextField) {
        if let principal = numberFormatter.number(from: textField.text!) as Double? {
            Principal = principal
        } else {
            Principal = nil
        }
        
        calculateAnswer()
    }
    
    @IBAction func setTimeValue(_ textField: UITextField) {
        if let time = numberFormatter.number(from: textField.text!) as Double? {
            Time = time
        } else {
            Time = nil
        }
        
        calculateAnswer()
    }
    
    func calculateAnswer() {
        if Principal != nil, Rate != nil, Time != nil {
            let answer: Double = (Principal! * (1 + (Rate! * Time!))) - Principal!
            answerLabel.text = "$" + numberFormatter.string(from: (value: answer) as NSNumber)! + " of interest"
        } else {
            answerLabel.text = "???"
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
