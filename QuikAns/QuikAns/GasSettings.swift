//
//  GasSettings.swift
//  QuikAns
//
//  Created by ios class on 2/26/17.
//  Copyright © 2017 neit. All rights reserved.
//

import UIKit
import os.log

class GasSettings: NSObject, NSCoding {
    
    //MARK: Properties
    
    var Price: Double
    var Mileage: Double
    
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("GasSettings")
    
    
    //MARK: Types
    struct PropertyKey {
        static let Price = "Price"
        static let Mileage = "Mileage"
    }
    
    
    //MARK: Initialization
    
    init?(price: Double, mileage: Double) {
        // Initialize stored properties
        self.Price = price
        self.Mileage = mileage
    }
    
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Price, forKey: PropertyKey.Price)
        aCoder.encode(Mileage, forKey: PropertyKey.Mileage)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The price is to be decoded as a double
        let price = aDecoder.decodeDouble(forKey: PropertyKey.Price)
        
        // The mileage is to be decoded as a double
        let mileage = aDecoder.decodeDouble(forKey: PropertyKey.Mileage)
        
        // Must call designated initializer.
        self.init(price: price, mileage: mileage)
    }
}
