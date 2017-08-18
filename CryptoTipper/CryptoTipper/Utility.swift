//
//  Utility.swift
//  CryptoTipper
//
//  Created by Rob Enriquez on 8/15/17.
//  Copyright © 2017 Robert Enriquez. All rights reserved.
//

import Foundation

let kTipPercentageKey = "kTipPercentageKey"
let kNumberOfPeopleKey = "kNumberOfPeopleKey"

class Utility: NSObject {
    
    static func currencySymbol() -> String {
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol
//        let currencyCode = locale.currencyCode
        
        return currencySymbol ?? ""
    }
    
    // MARK: UserDefaults
    
    static func saveTipPercentage(value: String) {
        let defaults = UserDefaults.standard
        let doubleValue = Double(value)
        defaults.set(doubleValue, forKey: kTipPercentageKey)
        defaults.synchronize()
    }
    
    static var savedTipPercentage: String {
        let defaults = UserDefaults.standard
        let numValue = defaults.double(forKey: kTipPercentageKey)
        let stringValue = String(format: "%0.f", numValue)
        return stringValue
    }
    
    static func saveNumberOfPeople(value: String) {
        let defaults = UserDefaults.standard
        let doubleValue = Double(value)
        defaults.set(doubleValue, forKey: kNumberOfPeopleKey)
        defaults.synchronize()
    }
    
    static var savedNumberOfPeople: String {
        let defaults = UserDefaults.standard
        let numValue = defaults.double(forKey: kNumberOfPeopleKey) 
        let stringValue = String(format: "%0.f", numValue)
        
        return stringValue
    }
}
