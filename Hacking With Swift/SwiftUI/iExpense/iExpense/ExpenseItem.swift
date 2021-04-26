//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Hayden Davidson on 2/15/21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
