//
//  CalculatorView.swift
//  TipCalcPro
//
//  Created by AIagent on 2026-03-03.
//

import SwiftUI

struct CalculatorView: View {
    @EnvironmentObject var calculator: CalculatorManager
    @EnvironmentObject var historyManager: HistoryManager
    @FocusState private var isAmountFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                // 账单金额
                Section(header: Text("账单金额")) {
                    HStack {
                        Text("$")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        
                        TextField("0.00", text: $calculator.customTipPercent)
                            .keyboardType(.decimalPad)
                            .focused($isAmountFocused)
                            .font(.title2)
                        
                        Spacer()
                    }
                }
                
                // 小费率选择
                Section(header: Text("小费率")) {
                    HStack(spacing: 12) {
                        TipButton(percent: 15, isSelected: calculator.tipPercent == 15 && !calculator.isCustomTip) {
                            calculator.setTipPercent(15)
                        }
                        
                        TipButton(percent: 18, isSelected: calculator.tipPercent == 18 && !calculator.isCustomTip) {
                            calculator.setTipPercent(18)
                        }
                        
                        TipButton(percent: 20, isSelected: calculator.tipPercent == 20 && !calculator.isCustomTip) {
                            calculator.setTipPercent(20)
                        }
                    }
                    .padding(.vertical, 8)
                    
                    // 自定义小费率
                    HStack {
                        Text("自定义")
                            .foregroundColor(.secondary)
                        
                        TextField("百分比", text: $calculator.customTipPercent)
                            .keyboardType(.decimalPad)
                            .onChange(of: calculator.customTipPercent) { newValue in
                                calculator.updateCustomTip(newValue)
                            }
                        
                        Text("%")
                            .foregroundColor(.secondary)
                    }
                }
                
                // 人数
                Section(header: Text("人数")) {
                    Stepper(value: $calculator.numberOfPeople, in: 1...20) {
                        HStack {
                            Text("人数")
                            Spacer()
                            Text("\(calculator.numberOfPeople) 人")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                // 计算结果
                Section(header: Text("计算结果")) {
                    ResultRow(title: "小费金额", value: calculator.tipAmount, prefix: "$")
                    ResultRow(title: "总计", value: calculator.totalAmount, prefix: "$", isBold: true)
                    
                    if calculator.numberOfPeople > 1 {
                        Divider()
                        ResultRow(title: "每人应付", value: calculator.perPersonAmount, prefix: "$")
                        ResultRow(title: "每人小费", value: calculator.tipPerPerson, prefix: "$")
                    }
                }
                
                // 重置按钮
                Section {
                    Button(action: {
                        withAnimation {
                            calculator.reset()
                        }
                    }) {
                        HStack {
                            Spacer()
                            Text("重置")
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("TipCalc Pro")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Tip Button
struct TipButton: View {
    let percent: Int
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("\(percent)%")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(isSelected ? .white : Color(hex: "#5AC8FA"))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(isSelected ? Color(hex: "#5AC8FA") : Color(hex: "#5AC8FA").opacity(0.1))
                .cornerRadius(8)
        }
    }
}

// MARK: - Result Row
struct ResultRow: View {
    let title: String
    let value: Double
    let prefix: String
    var isBold: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text("\(prefix)\(value, specifier: "%.2f")")
                .font(.system(size: isBold ? 24 : 18, weight: isBold ? .bold : .regular))
        }
    }
}

#Preview {
    CalculatorView()
        .environmentObject(CalculatorManager())
        .environmentObject(HistoryManager())
}
