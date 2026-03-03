//
//  ContentView.swift
//  TipCalcPro
//
//  Created by AIagent on 2026-03-03.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var calculator = CalculatorManager()
    @StateObject private var historyManager = HistoryManager()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CalculatorView()
                .environmentObject(calculator)
                .tabItem {
                    Image(systemName: "calculator")
                    Text("计算")
                }
                .tag(0)
            
            HistoryView()
                .environmentObject(historyManager)
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("历史")
                }
                .tag(1)
            
            SettingsView()
                .environmentObject(calculator)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("设置")
                }
                .tag(2)
        }
        .accentColor(Color(hex: "#5AC8FA"))
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    ContentView()
}
