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
    //When touching numberButton using sender equal to numberButton to update display and add this number to the view
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                calculator.addNewNumber(i)
            }
        }
    }
    //actions do with each button using their title tag
    @IBAction func operatorButtonsTapped(_ sender: UIButton) {
        switch sender.title(for: .normal) {
        case "+"?:
            calculator.plusOperator()
        case "-"?:
            calculator.minusOperator()
        case "÷"?:
            calculator.divideOperator()//bonus
        case "="?:
            calculator.calculateTotal()
        case "C"?:
            changeTextView(newText: "0")
            calculator.clear()
        default:
            break
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        //initializing and setting up the views
        super.viewDidLoad()
        calculator.diplayAlert = self
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
    // Extension with delegate Protocol to manage alert pop up in the model
    extension ViewController: ShowAlertDelegate {
            func showAlert(title: String, message: String) {
                showBasicAlert(title: title, message: message)
            }
    }

    // Extension with delegate Protocol to manage text view display in the model
    extension ViewController: ChangeTextDelegate {
        func changeTextView(newText: String) {
            textView.text = newText
        }
    }




