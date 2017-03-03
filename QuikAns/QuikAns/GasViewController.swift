//
//  GasViewController.swift
//  QuikAns
//
//  Created by ios class on 2/20/17.
//  Copyright © 2017 neit. All rights reserved.
//

import UIKit

class GasViewController: UIViewController, UITextFieldDelegate {
    var Price: Double? = nil
    var Mileage: Double? = nil
    var Distance: Double? = nil
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.generatesDecimalNumbers = true
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }()
    
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
        
        calculateAnswer()
    }
    
    @IBOutlet var answerLabel: UILabel!
    
    @IBAction func setDistanceValue(_ textField: UITextField) {
        if let distance = numberFormatter.number(from: textField.text!) as Double? {
            Distance = distance
        } else {
            Distance = nil
        }
        
        calculateAnswer()
    }
    
    func calculateAnswer() {
        if Price != nil, Mileage != nil, Distance != nil {
            let answer: Double = (Distance! / Mileage!) * Price!
            answerLabel.text = "$" + numberFormatter.string(from: (value: answer) as NSNumber)!
        } else {
            answerLabel.text = "???"
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
