//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    
    let calculator = Calculator()
    
    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                calculator.addNewNumber(i)
            }
        }
    }
    
    @IBAction func operatorButtonsTapped(_ sender: UIButton) {
        switch sender.title(for: .normal) {
        case "+"?:
            calculator.plusOperator()
        case "-"?:
            calculator.minusOperator()
        case "="?:
            calculator.calculateTotal()
        default:
            break
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        //initializing and setting up the views
        super.viewDidLoad()
        calculator.showAlert = self
        calculator.changeText = self
    }
}
    // MARK: - Extensions

    extension ViewController {
        private func showBasicAlert(title: String, message: String) {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
    }

    extension ViewController: ShowAlertDelegate {
        //custom Alert pop up: each alert has it own message
        func showIncorrectForm() {
            showBasicAlert(title: "Zéro!", message: "Expression incorrecte !")
        }
    
        func showIncompleteForm() {
            showBasicAlert(title: "Zéro!", message: "Entrez une expression corecte")
        }
    
        func showStartNewCalcul() {
            showBasicAlert(title: "Zéro!", message: "Démarrez un nouveau calcul !")
        }
    }

    extension ViewController: ChangeTextDelegate {
        func changeTextView(newText: String) {
            textView.text = newText
        }
    }




