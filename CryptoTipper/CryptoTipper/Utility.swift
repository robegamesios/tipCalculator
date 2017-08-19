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
let kCurrencyCode = "kCurrencyCode"

class Utility: NSObject {

    static let kAppDidEnterBackgroundNotificationKey = "kAppDidEnterBackgroundNotificationKey"
    static let kAppWillEnterForegroundNotificationKey = "kAppWillEnterForegroundNotificationKey"

    // MARK: Locales
    
    static func currencySymbol(code: String) -> (String, String) {
        let localeIds = Locale.availableIdentifiers
        for localeId in localeIds {
            let locale = Locale(identifier: localeId)
            
            if locale.regionCode != nil {
                if locale.regionCode == code,
                    let symbol = locale.currencySymbol,
                    let currCode = locale.currencyCode {
                    return (symbol, currCode)
                }
            }
        }
        return ("?", "?")
    }
    
    static func countryName(countryCode: String) -> String? {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: countryCode) ?? ""
    }
    
    // MARK: Formatters
    
    static func formatNumber(code: String, value: Double) -> String {
        let number = NSNumber(value: value)
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        
        // localize to your grouping and decimal separator
        let localeIds = Locale.availableIdentifiers
        for localeId in localeIds {
            let locale = Locale(identifier: localeId)
            
            if locale.regionCode != nil {
                if locale.regionCode == code {
                    currencyFormatter.locale = locale
                    if let formattedNumber = currencyFormatter.string(from: number) {
                        return formattedNumber
                    }
                }
            }
        }
        return ""
    }

    static func formatNumber(formatter: NumberFormatter, code: String, value: Double) -> String {
        let number = NSNumber(value: value)
        
        // localize to your grouping and decimal separator
        let localeIds = Locale.availableIdentifiers
        for localeId in localeIds {
            let locale = Locale(identifier: localeId)
            
            if locale.regionCode != nil {
                if locale.regionCode == code {
                    formatter.locale = locale
                    if let formattedNumber = formatter.string(from: number) {
                        return formattedNumber
                    }
                }
            }
        }
        return ""
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
    
    static func saveCountryCode(value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: kCurrencyCode)
        defaults.synchronize()
    }
    
    static var savedCountryCode: String {
        let defaults = UserDefaults.standard
        guard let stringValue = defaults.object(forKey: kCurrencyCode) as? String else {
            return ""
        }
        return stringValue
    }
}
