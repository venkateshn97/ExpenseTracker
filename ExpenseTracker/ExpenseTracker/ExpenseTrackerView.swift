//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Venky on 3/17/25.
//

import SwiftUI
import Combine
import Charts

// MARK: - Main View
struct ExpenseTrackerView: View {
    @StateObject private var viewModel = ExpenseViewModel()
    @State private var showAddExpense = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Expense Chart
                Chart(viewModel.getCategoryWiseData().sorted(by: { $0.value > $1.value }), id: \ .key) { category, amount in
                    BarMark(
                        x: .value("Category", category),
                        y: .value("Amount", amount)
                    )
                    .foregroundStyle(Color.blue)
                }
                .frame(height: 250)
                .padding()
                
                // Expense List
                List {
                    ForEach(viewModel.expenses) { expense in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(expense.title)
                                    .font(.headline)
                                Text(expense.category)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("$\(expense.amount, specifier: "%.2f")")
                                .font(.headline)
                        }
                    }
                    .onDelete(perform: viewModel.removeExpense)
                }
                
                // Add Expense Button
                Button(action: { showAddExpense.toggle() }) {
                    Text("Add Expense")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding()
            }
            .navigationTitle("Expense Tracker")
            .toolbar { EditButton() }
            .sheet(isPresented: $showAddExpense) {
                AddExpenseView(viewModel: viewModel)
            }
        }
    }
}


// MARK: - Preview
#Preview {
    ExpenseTrackerView()
}
