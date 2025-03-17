//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Venky on 3/17/25.
//

import Foundation

// MARK: - Expense Model
struct Expense: Identifiable, Codable {
    var id = UUID()
    var title: String
    var amount: Double
    var category: String
    var date: Date
}
