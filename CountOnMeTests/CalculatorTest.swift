//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by vincent  on 06/09/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

enum Operators {
    case minus, plus
}

class CalculatorTest: XCTestCase {
    
    // MARK: - Properties
    var calculator: Calculator!
    //each time the "operator" property has to change we call "setOperators() with Operators case we need
    var operators : Operators = .plus {
        didSet {
            setOperators(operators)
        }
    }
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    //method to select the operator between different case(minus, plus)
    func setOperators(_ operators : Operators) {
        switch operators {
        case .minus:
            calculator.minusOperator()
        case .plus:
            calculator.plusOperator()
        }
    }
    
    func testGivenIsIncorrectForm_WhenExpressionIsCorrect_ThenIsExpressionCorrectReturnTrue() {
        calculator.addNewNumber(8)
        XCTAssertTrue(calculator.isExpressionCorrect)
    }
    func testGivenIsCorrectForm_WhenExpressionIsWrong_ThenIsExpressionCorrectReturnFalse() {
        calculator.addNewNumber(8)
        calculator.minusOperator()
        calculator.calculateTotal()
        
        XCTAssertFalse(calculator.isExpressionCorrect)
    }
    
    func testGivenIsCorrectForm_WhenExpressionIsMissingNumber_ThenIsExpressionCorrectReturnFalse() {
        
        calculator.minusOperator()
        calculator.calculateTotal()
        
        XCTAssertFalse(calculator.isExpressionCorrect)
    }
    
    func testGivenAddOperator_WhenFormIsComplete_ThenExpressionCorrectReturnTrue() {
        calculator.addNewNumber(8)
        XCTAssertTrue(calculator.canAddOperator)
    }
    func testGivenCantAddOperator_WhenFormIsIncomplete_ThenExpressionCorrectReturnFalse() {
        XCTAssertFalse(calculator.canAddOperator)
    }
    
    func testGivenAddNewNumber_WhenStringNumberIsEmpty_ThenNewNumberIsAddedToStringNumber() {
        calculator.addNewNumber(8)
        
        XCTAssert(calculator.stringNumbers[calculator.stringNumbers.count-1] == "8")
        
    }
    
    func testGivenOperations_WhenStringNumberIsAddedAndOperatorsUsed_ThenCalculatorDoOperations() {
        calculator.addNewNumber(8)
        calculator.minusOperator()
        calculator.addNewNumber(8)
        calculator.plusOperator()
        calculator.addNewNumber(8)
        calculator.divideOperator()
        calculator.addNewNumber(8)
        calculator.calculateTotal()
        
        
    }
    
    
    
}
