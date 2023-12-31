//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Muhammad Fahmi on 10/09/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
