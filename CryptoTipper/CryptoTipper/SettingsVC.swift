//
//  SettingsVC.swift
//  CryptoTipper
//
//  Created by Rob Enriquez on 8/17/17.
//  Copyright © 2017 Robert Enriquez. All rights reserved.
//

import UIKit
import CountryPicker

class SettingsVC: UIViewController, UITextFieldDelegate, CountryPickerDelegate {
    
    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var numberOfPeopleTextField: UITextField!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var picker: CountryPicker!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        tipPercentageTextField.delegate = self
        numberOfPeopleTextField.delegate = self
        
        tipPercentageTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        numberOfPeopleTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        tipPercentageTextField.text = Utility.savedTipPercentage
        numberOfPeopleTextField.text = Utility.savedNumberOfPeople

        let code = Utility.savedCountryCode
        currencyButton.setTitle(code, for: .normal)
    }
    
    func setupCountryPicker() {
        //init Picker
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = false
        picker.isHidden = false
        picker.setCountry(Utility.savedCountryCode)
    }
    
    // MARK: Control Events
    
    func textFieldDidChange() {
        let tipString = tipPercentageTextField.text ?? "15"
        let tipValue = Double(tipString) ?? 15.0
        
        if tipValue > 1000.0 {
            showAlert(message: "That's a lot tip! Type something less.")
        }
        
        let numberOfPeopleString = numberOfPeopleTextField.text ?? "1"
        let numberOfPeopleValue = Double(numberOfPeopleString) ?? 15.0
        
        if numberOfPeopleValue > 100.0 {
            showAlert(message: "That's a people! Type something less.")
        }
    }
    
    // MARK: IBActions
    
    @IBAction func currencyButtonTapped(_ sender: UIButton) {
        showPicker()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        var tipValue = tipPercentageTextField.text ?? "15"
        if tipPercentageTextField.text == "" {
            tipValue = "0"
        }
        Utility.saveTipPercentage(value: tipValue)
        
        var numberOfPeopleValue = numberOfPeopleTextField.text ?? "1"
        if let checkValue = Double(numberOfPeopleValue),
            checkValue < 1 {
            numberOfPeopleValue = "1"
        }
        
        if numberOfPeopleTextField.text == "" {
            numberOfPeopleValue = "1"
        }
        
        Utility.saveNumberOfPeople(value: numberOfPeopleValue)
        
        let code = currencyButton.titleLabel?.text ?? ""
        Utility.saveCountryCode(value: code)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: CountryPicker delegate
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        currencyButton.setTitle(countryCode, for: .normal)
    }
    
    // MARK: Helpers
    
    func showAlert(message: String) {
        let actionSheetController: UIAlertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        actionSheetController.addAction(okAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func showPicker() {
        if tipPercentageTextField.isFirstResponder {
            tipPercentageTextField.resignFirstResponder()
        }
        
        if numberOfPeopleTextField.isFirstResponder {
            numberOfPeopleTextField.resignFirstResponder()
        }
        
        setupCountryPicker()
    }
}
