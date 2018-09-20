//
//  Calculator.swift
//  CountOnMe
//
//  Created by vincent  on 06/09/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation
//Apply protocol tobe able to use alert on the model
protocol ShowAlertDelegate {
    func showAlert(title: String, message: String)
}
//Apply protocol to be able to change text View on the model
protocol ChangeTextDelegate {
   func changeTextView(newText: String)
}

class Calculator {
    // MARK: - Properties
    
    var diplayAlert: ShowAlertDelegate?
    var changeText: ChangeTextDelegate?
    
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var index = 0
    //Calculate property to check if the user entered a correct expression. If not popu up alert appears to warn the user
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    diplayAlert?.showAlert(title: "Erreur", message: "Expression incorrect")
                } else {
                    diplayAlert?.showAlert(title: "Erreur", message: "Démarrez un nouveau calcul !")
                }
                return false

            }
        }
        return true
    }
    //Calculate property to check if the user entered a number. If not popu up alert appears to warn the user
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                diplayAlert?.showAlert(title: "Erreur", message: "Entrez une expression correcte !")
                return false
            }
        }
        return true
    }
    
    // MARK: - Methods
    //Manage plus Operator
    func plusOperator() {
        if canAddOperator {
            operators.append("+")
            stringNumbers.append("")
        }
        updateDisplay()
    }
    //Manage minus Operator
    func minusOperator() {
        if canAddOperator {
            operators.append("-")
            stringNumbers.append("")
        }
        updateDisplay()
    }
    
    //Manage divide Operator bonus
    func divideOperator() {
        if canAddOperator {
            operators.append("÷")
            stringNumbers.append("")
        }
        updateDisplay()
    }
    
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }
    
    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
        
        var total: Double = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }else if operators[i] == "÷" && number != 0 {//bonus
                    total /= number
                }else{
                   diplayAlert?.showAlert(title: "Erreur", message: "Diviser par zéro est impossible")
                }
            }
        }
        let result = String(total)
        changeText?.changeTextView(newText: result)
        
        clear()
    }
    
    func updateDisplay() {
        var text = ""
        for (i, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += operators[i]
            }
            // Add number
            text += stringNumber
        }
        changeText?.changeTextView(newText: text)
    }
    
   
    ///////////////////////////////??
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }//////////////////////////////??
}
