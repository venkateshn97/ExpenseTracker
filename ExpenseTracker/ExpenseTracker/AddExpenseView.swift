//
//  AddExpenseView.swift
//  ExpenseTracker
//
//  Created by Venky on 3/17/25.
//

import SwiftUI

// MARK: - Add Expense View
struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ExpenseViewModel
    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var category: String = "Food"
    @State private var date = Date()
    
    let categories = ["Food", "Transport", "Shopping", "Bills", "Other"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \ .self) { Text($0) }
                }
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            .navigationTitle("Add Expense")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let amountValue = Double(amount) {
                            viewModel.addExpense(title: title, amount: amountValue, category: category, date: date)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
