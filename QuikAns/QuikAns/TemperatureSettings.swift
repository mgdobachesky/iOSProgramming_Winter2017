//
//  TemperatureSettings.swift
//  QuikAns
//
//  Created by ios class on 2/26/17.
//  Copyright © 2017 neit. All rights reserved.
//

import UIKit
import os.log

class TemperatureSettings: NSObject, NSCoding {
    
    //MARK: Properties
    
    var ConvertTo: String
    
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("TemperatureSettings")
    
    
    //MARK: Types
    struct PropertyKey {
        static let ConvertTo = "ConvertTo"
    }
    
    
    //MARK: Initialization
    
    init?(convertTo: String) {
        // Initialize stored properties
        self.ConvertTo = convertTo
    }
    
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(ConvertTo, forKey: PropertyKey.ConvertTo)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let ConvertTo = aDecoder.decodeObject(forKey: PropertyKey.ConvertTo) as? String else {
            os_log("Unable to decode the conversion string.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(convertTo: ConvertTo)
    }
}

