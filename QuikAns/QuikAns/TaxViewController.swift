//
//  TaxViewController.swift
//  QuikAns
//
//  Created by ios class on 2/20/17.
//  Copyright © 2017 neit. All rights reserved.
//

import UIKit
import os.log

class TaxViewController: UIViewController, UITextFieldDelegate {
    
    var Total: Double? = nil
    var Rate: Double? = nil
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.generatesDecimalNumbers = true
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    @IBOutlet var answerLabel: UILabel!
    
    @IBAction func setTotalValue(_ textField: UITextField) {
        if let total = numberFormatter.number(from: textField.text!) as Double? {
            Total = total
        } else {
            Total = nil
        }
        
        calculateAnswer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load saved data, otherwise load sample data
        if let savedData = loadRate() {
            Rate = savedData
        } else {
            // Load the sample data.
            Rate = 0.05
        }
        
        calculateAnswer()
    }
    
    func calculateAnswer() {
        if Total != nil, Rate != nil {
            let answer: Double = Total! * Rate!
            answerLabel.text = "$" + numberFormatter.string(from: (value: answer) as NSNumber)!
        } else {
            answerLabel.text = "???"
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
