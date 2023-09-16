//
//  AddView.swift
//  iExpense
//
//  Created by Muhammad Fahmi on 10/09/23.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Bussiness", "Personal"]

    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar{
                Button("Save"){
                    let expense = ExpenseItem(name: name, type: type, amount: amount)
                    expense.type == "Personal" ? expenses.items.append(expense) : expenses.items.append(expense)
                    dismiss()
                    print(expense)
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
