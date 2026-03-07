//
//  ContentView.swift
//  TipCalc Pro
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount: String = ""
    @State private var tipPercentage: Double = 15
    @State private var numberOfPeople: Int = 1
    @State private var showHistory = false
    
    var billValue: Double {
        Double(billAmount) ?? 0
    }
    
    var tipAmount: Double {
        billValue * (tipPercentage / 100)
    }
    
    var totalAmount: Double {
        billValue + tipAmount
    }
    
    var perPersonAmount: Double {
        totalAmount / Double(max(numberOfPeople, 1))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("账单金额")) {
                    TextField("输入金额", text: $billAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("小费比例")) {
                    HStack {
                        Text("\(Int(tipPercentage))%")
                        Slider(value: $tipPercentage, in: 0...30, step: 1)
                    }
                    
                    HStack {
                        ForEach([10, 15, 18, 20, 25], id: \.self) { percent in
                            Button("\(percent)%") {
                                tipPercentage = Double(percent)
                            }
                        }
                    }
                }
                
                Section(header: Text("分摊人数")) {
                    Stepper("\(numberOfPeople) 人", value: $numberOfPeople, in: 1...20)
                }
                
                Section(header: Text("计算结果")) {
                    HStack {
                        Text("小费金额")
                        Spacer()
                        Text("¥\(tipAmount, specifier: "%.2f")")
                            .fontWeight(.semibold)
                    }
                    
                    HStack {
                        Text("总计")
                        Spacer()
                        Text("¥\(totalAmount, specifier: "%.2f")")
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                    }
                    
                    HStack {
                        Text("每人应付")
                        Spacer()
                        Text("¥\(perPersonAmount, specifier: "%.2f")")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                }
                
                Section {
                    Button(action: { showHistory = true }) {
                        HStack {
                            Image(systemName: "clock")
                            Text("历史记录")
                        }
                    }
                }
            }
            .navigationTitle("TipCalc Pro")
            .sheet(isPresented: $showHistory) {
                HistoryView()
            }
        }
    }
}

struct HistoryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var history: [HistoryItem] = []
    
    struct HistoryItem: Identifiable {
        let id = UUID()
        let date: Date
        let amount: Double
        let tip: Double
        let total: Double
    }
    
    var body: some View {
        NavigationView {
            List {
                Text("暂无历史记录")
                    .foregroundColor(.secondary)
            }
            .navigationTitle("历史记录")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("完成") { dismiss() }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
