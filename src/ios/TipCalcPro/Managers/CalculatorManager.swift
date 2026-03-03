//
//  CalculatorManager.swift
//  TipCalcPro
//
//  Created by AIagent on 2026-03-03.
//

import Foundation
import SwiftUI

/// 计算器管理器
class CalculatorManager: ObservableObject {
    // MARK: - Published Properties
    @Published var billAmount: Double = 0.0
    @Published var tipPercent: Double = 18.0
    @Published var numberOfPeople: Int = 1
    @Published var customTipPercent: String = ""
    @Published var isCustomTip: Bool = false
    
    // MARK: - Computed Properties
    var tipAmount: Double {
        billAmount * (tipPercent / 100.0)
    }
    
    var totalAmount: Double {
        billAmount + tipAmount
    }
    
    var perPersonAmount: Double {
        totalAmount / Double(numberOfPeople)
    }
    
    var tipPerPerson: Double {
        tipAmount / Double(numberOfPeople)
    }
    
    // MARK: - Methods
    func updateBillAmount(_ amount: String) {
        if let value = Double(amount) {
            billAmount = value
        } else if amount.isEmpty {
            billAmount = 0.0
        }
    }
    
    func setTipPercent(_ percent: Double) {
        tipPercent = percent
        isCustomTip = false
        customTipPercent = ""
    }
    
    func updateCustomTip(_ percent: String) {
        customTipPercent = percent
        if let value = Double(percent) {
            tipPercent = value
            isCustomTip = true
        }
    }
    
    func updateNumberOfPeople(_ count: Int) {
        numberOfPeople = max(1, count)
    }
    
    func reset() {
        billAmount = 0.0
        tipPercent = 18.0
        numberOfPeople = 1
        customTipPercent = ""
        isCustomTip = false
    }
}

// MARK: - History Item
struct HistoryItem: Identifiable, Codable {
    let id: UUID
    let date: Date
    let billAmount: Double
    let tipPercent: Double
    let totalAmount: Double
    let numberOfPeople: Int
    
    init(
        id: UUID = UUID(),
        date: Date = Date(),
        billAmount: Double,
        tipPercent: Double,
        totalAmount: Double,
        numberOfPeople: Int = 1
    ) {
        self.id = id
        self.date = date
        self.billAmount = billAmount
        self.tipPercent = tipPercent
        self.totalAmount = totalAmount
        self.numberOfPeople = numberOfPeople
    }
}

// MARK: - History Manager
class HistoryManager: ObservableObject {
    @Published var history: [HistoryItem] = []
    
    private let historyKey = "calculation_history"
    private let maxHistoryItems = 10
    
    init() {
        loadHistory()
    }
    
    func addItem(billAmount: Double, tipPercent: Double, totalAmount: Double, numberOfPeople: Int) {
        let item = HistoryItem(
            billAmount: billAmount,
            tipPercent: tipPercent,
            totalAmount: totalAmount,
            numberOfPeople: numberOfPeople
        )
        
        history.insert(item, at: 0)
        
        if history.count > maxHistoryItems {
            history.removeLast()
        }
        
        saveHistory()
    }
    
    func removeItem(at offsets: IndexSet) {
        history.remove(atOffsets: offsets)
        saveHistory()
    }
    
    func clearHistory() {
        history.removeAll()
        saveHistory()
    }
    
    private func saveHistory() {
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: historyKey)
        }
    }
    
    private func loadHistory() {
        guard let data = UserDefaults.standard.data(forKey: historyKey),
              let items = try? JSONDecoder().decode([HistoryItem].self, from: data) else {
            return
        }
        history = items
    }
}
