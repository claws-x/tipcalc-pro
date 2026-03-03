//
//  TipCalcProTests.swift
//  TipCalcProTests
//
//  Created by AIagent on 2026-03-03.
//

import XCTest
@testable import TipCalcPro

final class TipCalcProTests: XCTestCase {
    
    var calculator: CalculatorManager!
    var historyManager: HistoryManager!
    
    override func setUpWithError() throws {
        calculator = CalculatorManager()
        historyManager = HistoryManager()
    }
    
    override func tearDownWithError() throws {
        calculator = nil
        historyManager = nil
    }
    
    // MARK: - Calculation Tests
    
    func testTipCalculation() throws {
        calculator.billAmount = 100.0
        calculator.tipPercent = 18.0
        
        XCTAssertEqual(calculator.tipAmount, 18.0, accuracy: 0.01)
        XCTAssertEqual(calculator.totalAmount, 118.0, accuracy: 0.01)
    }
    
    func testTipCalculation15Percent() throws {
        calculator.billAmount = 100.0
        calculator.setTipPercent(15)
        
        XCTAssertEqual(calculator.tipAmount, 15.0, accuracy: 0.01)
        XCTAssertEqual(calculator.totalAmount, 115.0, accuracy: 0.01)
    }
    
    func testTipCalculation20Percent() throws {
        calculator.billAmount = 100.0
        calculator.setTipPercent(20)
        
        XCTAssertEqual(calculator.tipAmount, 20.0, accuracy: 0.01)
        XCTAssertEqual(calculator.totalAmount, 120.0, accuracy: 0.01)
    }
    
    func testSplitBill() throws {
        calculator.billAmount = 100.0
        calculator.tipPercent = 20.0
        calculator.numberOfPeople = 4
        
        XCTAssertEqual(calculator.perPersonAmount, 30.0, accuracy: 0.01)
        XCTAssertEqual(calculator.tipPerPerson, 5.0, accuracy: 0.01)
    }
    
    func testCustomTipPercent() throws {
        calculator.billAmount = 100.0
        calculator.updateCustomTip("25")
        
        XCTAssertEqual(calculator.tipPercent, 25.0, accuracy: 0.01)
        XCTAssertEqual(calculator.isCustomTip, true)
    }
    
    // MARK: - Manager Tests
    
    func testCalculatorReset() throws {
        calculator.billAmount = 100.0
        calculator.tipPercent = 20.0
        calculator.numberOfPeople = 5
        
        calculator.reset()
        
        XCTAssertEqual(calculator.billAmount, 0.0)
        XCTAssertEqual(calculator.tipPercent, 18.0)
        XCTAssertEqual(calculator.numberOfPeople, 1)
    }
    
    func testHistoryAddItem() throws {
        let initialCount = historyManager.history.count
        
        historyManager.addItem(
            billAmount: 100.0,
            tipPercent: 18.0,
            totalAmount: 118.0,
            numberOfPeople: 2
        )
        
        XCTAssertEqual(historyManager.history.count, initialCount + 1)
    }
    
    func testHistoryMaxLimit() throws {
        // Add 15 items (exceeds max of 10)
        for i in 0..<15 {
            historyManager.addItem(
                billAmount: Double(i),
                tipPercent: 18.0,
                totalAmount: Double(i * 1.18),
                numberOfPeople: 1
            )
        }
        
        XCTAssertEqual(historyManager.history.count, 10)
    }
    
    func testHistoryClear() throws {
        historyManager.addItem(
            billAmount: 100.0,
            tipPercent: 18.0,
            totalAmount: 118.0,
            numberOfPeople: 1
        )
        
        historyManager.clearHistory()
        
        XCTAssertTrue(historyManager.history.isEmpty)
    }
    
    // MARK: - Performance Tests
    
    func testCalculationPerformance() throws {
        self.measure {
            for _ in 0..<100 {
                calculator.billAmount = 100.0
                calculator.tipPercent = 18.0
                _ = calculator.tipAmount
                _ = calculator.totalAmount
            }
        }
    }
}
