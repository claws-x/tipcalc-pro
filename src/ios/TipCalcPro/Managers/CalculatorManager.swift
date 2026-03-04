//
//  CalculatorManager.swift
//  TipCalcPro
//
//  Created by AIagent on 2026-03-03.
//

import Foundation
import SwiftUI

/// 计算器管理器 - 真实计算逻辑
class CalculatorManager: ObservableObject {
    // MARK: - Published Properties
    @Published var billAmount: Double = 0.0
    @Published var tipPercent: Double = 18.0
    @Published var numberOfPeople: Int = 1
    @Published var customTipPercent: String = ""
    @Published var isCustomTip: Bool = false
    @Published var includeTax: Bool = false
    @Published var taxRate: Double = 10.0
    
    // MARK: - Computed Properties - 真实计算
    var tipAmount: Double {
        let baseAmount = includeTax ? billAmount * (1 + taxRate / 100) : billAmount
        return baseAmount * (tipPercent / 100.0)
    }
    
    var totalAmount: Double {
        let baseAmount = includeTax ? billAmount * (1 + taxRate / 100) : billAmount
        return baseAmount + tipAmount
    }
    
    var perPersonAmount: Double {
        guard numberOfPeople > 0 else { return 0 }
        return totalAmount / Double(numberOfPeople)
    }
    
    var tipPerPerson: Double {
        guard numberOfPeople > 0 else { return 0 }
        return tipAmount / Double(numberOfPeople)
    }
    
    // MARK: - Constants
    private let historyKey = "calculation_history"
    private let settingsKey = "calculator_settings"
    
    // MARK: - History
    @Published var history: [CalculationRecord] = []
    
    func addToHistory() {
        let record = CalculationRecord(
            billAmount: billAmount,
            tipPercent: tipPercent,
            totalAmount: totalAmount,
            numberOfPeople: numberOfPeople,
            date: Date()
        )
        history.insert(record, at: 0)
        
        // 只保留最近 50 条
        if history.count > 50 {
            history.removeLast(history.count - 50)
        }
        
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
              let records = try? JSONDecoder().decode([CalculationRecord].self, from: data) else {
            return
        }
        history = records
    }
    
    // MARK: - Settings
    func saveSettings() {
        let settings = CalculatorSettings(
            defaultTipPercent: tipPercent,
            includeTax: includeTax,
            taxRate: taxRate
        )
        if let data = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: settingsKey)
        }
    }
    
    func loadSettings() {
        guard let data = UserDefaults.standard.data(forKey: settingsKey),
              let settings = try? JSONDecoder().decode(CalculatorSettings.self, from: data) else {
            return
        }
        tipPercent = settings.defaultTipPercent
        includeTax = settings.includeTax
        taxRate = settings.taxRate
    }
    
    // MARK: - Initialization
    init() {
        loadHistory()
        loadSettings()
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

// MARK: - Data Models
struct CalculationRecord: Identifiable, Codable {
    let id: UUID
    let billAmount: Double
    let tipPercent: Double
    let totalAmount: Double
    let numberOfPeople: Int
    let date: Date
    
    init(
        id: UUID = UUID(),
        billAmount: Double,
        tipPercent: Double,
        totalAmount: Double,
        numberOfPeople: Int,
        date: Date = Date()
    ) {
        self.id = id
        self.billAmount = billAmount
        self.tipPercent = tipPercent
        self.totalAmount = totalAmount
        self.numberOfPeople = numberOfPeople
        self.date = date
    }
}

struct CalculatorSettings: Codable {
    var defaultTipPercent: Double
    var includeTax: Bool
    var taxRate: Double
}
