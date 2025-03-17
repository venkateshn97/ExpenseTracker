//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Venky on 3/17/25.
//

import Foundation

// MARK: - ViewModel
class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = [] {
        didSet {
            saveExpenses()
        }
    }
    
    private let expensesKey = "expenses_data"
    
    init() {
        loadExpenses()
    }
    
    func addExpense(title: String, amount: Double, category: String, date: Date) {
        let newExpense = Expense(title: title, amount: amount, category: category, date: date)
        expenses.append(newExpense)
    }
    
    func removeExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }
    
    func getTotalExpenses() -> Double {
        return expenses.reduce(0) { $0 + $1.amount }
    }
    
    func getCategoryWiseData() -> [String: Double] {
        var categoryData: [String: Double] = [:]
        for expense in expenses {
            categoryData[expense.category, default: 0] += expense.amount
        }
        return categoryData
    }
    
    private func saveExpenses() {
        if let encoded = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(encoded, forKey: expensesKey)
        }
    }
    
    private func loadExpenses() {
        if let savedData = UserDefaults.standard.data(forKey: expensesKey),
           let decoded = try? JSONDecoder().decode([Expense].self, from: savedData) {
            expenses = decoded
        }
    }
}
