//
//  InterestSettings.swift
//  QuikAns
//
//  Created by ios class on 2/26/17.
//  Copyright © 2017 neit. All rights reserved.
//

import UIKit
import os.log

class InterestSettings: NSObject, NSCoding {
    
    //MARK: Properties
    
    var Rate: Double
    
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("InterestSettings")
    
    
    //MARK: Types
    struct PropertyKey {
        static let Rate = "Rate"
    }
    
    
    //MARK: Initialization
    
    init?(rate: Double) {
        // Initialize stored properties
        self.Rate = rate
    }
    
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Rate, forKey: PropertyKey.Rate)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let rate = aDecoder.decodeObject(forKey: PropertyKey.Rate) as? Double else {
            os_log("Unable to decode the rate.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(rate: rate)
    }
}
