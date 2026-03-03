//
//  HistoryView.swift
//  TipCalcPro
//
//  Created by AIagent on 2026-03-03.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var historyManager: HistoryManager
    @State private var showingClearAlert = false
    
    var body: some View {
        NavigationView {
            Group {
                if historyManager.history.isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(historyManager.history) { item in
                            HistoryRowView(item: item)
                        }
                        .onDelete(perform: deleteHistory)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("历史记录")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !historyManager.history.isEmpty {
                        Button(action: { showingClearAlert = true }) {
                            Text("清空")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .alert("确认清空", isPresented: $showingClearAlert) {
                Button("取消", role: .cancel) { }
                Button("清空", role: .destructive) {
                    historyManager.clearHistory()
                }
            } message: {
                Text("确定要清空所有历史记录吗？")
            }
        }
    }
    
    private func deleteHistory(at offsets: IndexSet) {
        historyManager.removeItem(at: offsets)
    }
}

// MARK: - Empty State View
struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "clock.fill")
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.5))
            
            Text("暂无历史记录")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.secondary)
            
            Text("使用计算器后，记录会显示在这里")
                .font(.system(size: 16))
                .foregroundColor(.secondary.opacity(0.7))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - History Row View
struct HistoryRowView: View {
    let item: HistoryItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("账单: $\(item.billAmount, specifier: "%.2f")")
                    .font(.system(size: 16, weight: .medium))
                
                Spacer()
                
                Text("总计: $\(item.totalAmount, specifier: "%.2f")")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(hex: "#5AC8FA"))
            }
            
            HStack {
                Text("小费: \(item.tipPercent, specifier: "%.0f")%")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("\(item.numberOfPeople) 人")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(item.date, style: .date)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    HistoryView()
        .environmentObject(HistoryManager())
}
