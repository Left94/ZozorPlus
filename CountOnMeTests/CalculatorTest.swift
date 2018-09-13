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
        setOperators(operators)//test each operator's case
        calculator.calculateTotal()
        
        XCTAssertFalse(calculator.isExpressionCorrect)
    }
    
    
    func testGivenAddOperator_WhenFormIsComplete_ThenExpressionCorrectReturnTrue() {
        calculator.addNewNumber(8)
        XCTAssertTrue(calculator.canAddOperator)
    }
    func testGivenCantAddOperator_WhenFormIsIncomplete_ThenExpressionCorrectReturnFalse() {
    }
    
    
    
    
    
    
    func testGiven_When_Then() {
        
    }
}
