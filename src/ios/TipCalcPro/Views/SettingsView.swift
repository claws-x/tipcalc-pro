//
//  SettingsView.swift
//  TipCalcPro
//
//  Created by AIagent on 2026-03-03.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var calculator: CalculatorManager
    @AppStorage("defaultTipPercent") private var defaultTipPercent = 18.0
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("默认设置")) {
                    Stepper(value: $defaultTipPercent, in: 0...50, step: 1) {
                        HStack {
                            Text("默认小费率")
                            Spacer()
                            Text("\(defaultTipPercent, specifier: "%.0f")%")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text("外观")) {
                    Toggle("深色模式", isOn: $isDarkModeEnabled)
                }
                
                Section(header: Text("关于")) {
                    HStack {
                        Text("版本")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    Link(destination: URL(string: "mailto:support@tipcalcpro.com")!) {
                        HStack {
                            Text("联系支持")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        calculator.reset()
                    }) {
                        HStack {
                            Spacer()
                            Text("重置所有数据")
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("设置")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(CalculatorManager())
}
