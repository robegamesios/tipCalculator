//
//  CalculatorVC.swift
//  CryptoTipper
//
//  Created by Rob Enriquez on 8/14/17.
//  Copyright © 2017 Robert Enriquez. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputTaxTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var eachPersonStringLabel: UILabel!
    @IBOutlet weak var eachPersonPaysLabel: UILabel!
    @IBOutlet weak var tipRateLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    
    var percentTip: Double {
        get {
            let tipString = tipRateLabel.text ?? "15"
            let percentTipValue = Double(tipString) ?? 15.00
            return percentTipValue
        }
        
        set(newValue) {
            tipRateLabel.text = "\(newValue)"
        }
    }
    
    var splitCount: Double {
        get {
            let count = splitLabel.text ?? "1"
            let countValue = Double(count) ?? 1.0
            return countValue
        }
        
        set(newValue) {
            splitLabel.text = "\(newValue)"
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addNotificationObservers()
        setDefaults()
        setupView()
        //Show keyboard on appear
        if inputTextField.canBecomeFirstResponder {
            inputTextField.becomeFirstResponder()
        }
        updateTotal()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        super.viewDidDisappear(animated)
    }
    
    // MARK: Setup
    
    func setupTextFields() {
        inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector
            (textFieldDidChange), for: .editingChanged)
        
        inputTaxTextField.delegate = self
        inputTaxTextField.addTarget(self, action: #selector
            (textFieldDidChange), for: .editingChanged)
    }
    
    func setupView() {
        tipRateLabel.text = Utility.savedTipPercentage
        splitLabel.text = Utility.savedNumberOfPeople
        checkNumberOfPeople()
    }
    
    // MARK: Control Events
    
    func textFieldDidChange() {
        updateTotal()
    }
    
    // MARK: IBActions
    
    @IBAction func lessTipButtonTapped(_ sender: UIButton) {
        if percentTip == 0 {return}
        percentTip -= 1
        tipRateLabel.text = String(format: "%.0f", percentTip)
        updateTotal()
    }
    
    @IBAction func moreTipButtonTapped(_ sender: UIButton) {
        if percentTip == 100 {return}
        percentTip += 1
        tipRateLabel.text = String(format: "%.0f", percentTip)
        updateTotal()
    }
    
    @IBAction func lessPeopleButtonTapped(_ sender: UIButton) {
        if splitCount == 1 {return}
        splitCount -= 1
        splitLabel.text = String(format: "%.0f",splitCount)
        updateTotal()
    }
    
    @IBAction func morePeopleButtonTapped(_ sender: UIButton) {
        if splitCount == 100 {return}
        splitCount += 1
        splitLabel.text = String(format: "%0.f",splitCount)
        updateTotal()
    }
    
    // MARK: Textfield delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let startIndex = textField.text?.range(of: ".")?.lowerBound
        
        if string == "" {
            //backspace key
            return true
        }

        if startIndex != nil {
            //prevent double dot entry
            if string == "." {
                return false
            }
            //limit entry after decimal mark to 2 places
            guard let stringEndIndex = textField.text?.endIndex,
                let distance = textField.text?.distance(from: stringEndIndex, to: startIndex!), Swift.abs(distance) < 3 else {
                    return false
            }
        }
        return true
    }

    // MARK: Helpers
    
    func updateTotal() {
        checkNumberOfPeople()

        let inputValue = inputTextField.text ?? "0"
        let inputAmount = Double(inputValue) ?? 0.00
        
        let inputTaxValue = inputTaxTextField.text ?? "0"
        let inputTaxAmount = Double(inputTaxValue) ?? 0.00
        
        let tipAmount = inputAmount * (percentTip / 100.0)
        let totalAmount = inputAmount + inputTaxAmount + tipAmount

        tipAmountLabel.text = String(format: "\(Utility.currencySymbol())%.2f", tipAmount)
        totalAmountLabel.text = String(format: "\(Utility.currencySymbol())%.2f", totalAmount)
        eachPersonPaysLabel.text = String(format: "\(Utility.currencySymbol())%.2f", totalAmount/splitCount)
    }
    
    func checkNumberOfPeople() {
        if splitCount > 1 {
            eachPersonStringLabel.text = "Each person pays"
        } else {
            eachPersonStringLabel.text = "You pay"
        }
    }
    
    func setDefaults() {
        if !Utility.isFirstLaunch {
            Utility.saveTipPercentage(value: "15")
            Utility.saveNumberOfPeople(value: "2")
            Utility.setfirstLaunch()
        }
    }
    
    func resetLastTimeOpened(notification: Notification) -> Void {
        let currentDate = Date()
        _ = Utility.setLastTimeOpened(date: currentDate)
    }
    
    func resetEntries(notification: Notification) -> Void {
        if inputTextField.canBecomeFirstResponder {
            inputTextField.becomeFirstResponder()
        }
        
        let currentDate = Date()
        guard let lastTimeOpened = Utility.lastTimeOpened else {
            return
        }
        
        if currentDate.timeIntervalSince(lastTimeOpened) >= 10 * 60 { // 10 minutes
            inputTextField.text = ""
            inputTaxTextField.text = ""
        }
    }
    
    func addNotificationObservers() {
        let nc = NotificationCenter.default
        nc.addObserver(forName:Notification.Name(rawValue: Utility.kAppDidEnterBackgroundNotificationKey),
                       object:nil, queue:nil,
                       using:resetLastTimeOpened)
        nc.addObserver(forName:Notification.Name(rawValue: Utility.kAppWillEnterForegroundNotificationKey),
                       object:nil, queue:nil,
                       using:resetEntries)
    }
}

