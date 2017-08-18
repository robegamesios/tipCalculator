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
let kFirstLaunch = "kFirstLaunch"
let kLastTimeOpened = "kLastTimeOpened"

class Utility: NSObject {

    static let kAppDidEnterBackgroundNotificationKey = "kAppDidEnterBackgroundNotificationKey"
    static let kAppWillEnterForegroundNotificationKey = "kAppWillEnterForegroundNotificationKey"

    static func currencySymbol() -> String {
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol
//        let currencyCode = locale.currencyCode
        
        return currencySymbol ?? ""
    }
    
    // MARK: UserDefaults
    static func setfirstLaunch() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: kFirstLaunch)
        defaults.synchronize()
    }
    
    static var isFirstLaunch: Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: kFirstLaunch)
    }
    
    static func setLastTimeOpened(date: Date) -> Date {
        let defaults = UserDefaults.standard
        let date = Date()
        defaults.set(date, forKey: kLastTimeOpened)
        defaults.synchronize()
        return date
    }
    
    static var lastTimeOpened: Date? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: kLastTimeOpened) as? Date
    }
    
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
