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
    //Manage multiply Operator bonus
    func multiplyOperator() {
        if canAddOperator {
            operators.append("x")
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
    
    func mysteryButton() {//Bonus
        let emoticons = ["Bonne chance!","Bravo!","Comment puis-je vous aider?","Comment allez-vous?","Belle journée n'est-ce pas?","Vive les mathématiques!","Un coup de main?","Vous avez l'air perdu..", "Courage!", "Vous y êtes presque!","Vous devriez faire une pause!"]
        let randomIndex = Int(arc4random_uniform(UInt32(emoticons.count)))
        changeText?.changeTextView(newText: emoticons[randomIndex])
    }
    
    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
        
        mathOrder() // we check if we have to perform first priority calculation
        var total: Double = 0
       
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }
        let result = String(total)
        changeText?.changeTextView(newText: result)
    }
    //Manage priority calculate bonus
    func mathOrder() {
        
        let firstOperators:[String] = ["x" , "÷"]              // always have priority to perform calculate before "+" and "-" operators
        var result:Double = 0                                  //.....while we have a second number to perform calcul
        var index = 0
        
        while index < stringNumbers.count - 1 {                                               // we want to repeat the priority orders multiply and divide to calculate..
            if var firstNumber = Double(stringNumbers[index]) {// we check if we have a first number to perform calculate at index "0"
                                                               // stringNumber[(1), 2, 3…] index = 0
                
                while firstOperators.contains(operators[index + 1]) {        //while we have a priority operator after first number
                    if let secondNumber = Double(stringNumbers[index + 1]) { //we check if we have a second number to perform calculate
                                                                             // stringNumber[1, (2), 3…] index = 1
                        if operators[index + 1] == "x" {
                            result = firstNumber * secondNumber              // 1x2
                        } else if
                            operators[index + 1] == "÷" && secondNumber != 0 {
                            result = firstNumber / secondNumber              // 1÷2
                        } else {
                            diplayAlert?.showAlert(title: "", message: "")   // if user try to divide by "0" we pop up error message alert
                        }
                        
                        stringNumbers.remove(at: index + 1)   // when priority math is over then we remove the second numbers and
                        operators.remove(at: index + 1)       // priority operator we used from arrays ([numbers]&[operators])...
                                                              // ...to perform the next calcul
                        firstNumber = result                  // the first number become the result and...
                        stringNumbers[index] = String(result) // ...result is convert to string
                        
                        
                        
                        if index == stringNumbers.count - 1 { // if we don't have any other numbers to perform priority we stop
                            return                             // to perform the priority calculate
                        }
                    }
                }
                index = index + 1                             // we increment +1 to index to perform next calculate with "result"
            }
        }
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
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }
}
