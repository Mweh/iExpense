//
//  Expenses.swift
//  iExpense
//
//  Created by Muhammad Fahmi on 10/09/23.
//

import Foundation

class Expenses: ObservableObject{
    @Published var items = [ExpenseItem](){
        didSet{
            if let encode = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encode, forKey: "Items")
            }
        }
    }
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodeItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodeItems
                return
            }
        }
        items = []
    }
}

