//
//  SettingsVC.swift
//  CryptoTipper
//
//  Created by Rob Enriquez on 8/17/17.
//  Copyright © 2017 Robert Enriquez. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var numberOfPeopleTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setupView() {
        tipPercentageTextField.delegate = self
        numberOfPeopleTextField.delegate = self
        
        tipPercentageTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        numberOfPeopleTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        tipPercentageTextField.text = Utility.savedTipPercentage
        numberOfPeopleTextField.text = Utility.savedNumberOfPeople
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
        
        self.navigationController?.popViewController(animated: true)
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

}
