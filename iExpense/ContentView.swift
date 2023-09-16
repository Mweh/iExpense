//
//  ContentView.swift
//  iExpense
//
//  Created by Muhammad Fahmi on 10/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var number = 1
    @State private var showingAddExpenses = false
    
    var localeCurrency: FloatingPointFormatStyle<Double>.Currency{
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    var body: some View {
        NavigationView{
            List{
                expensesView(for: "Personal")
                expensesView(for: "Bussiness")
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button{
//                    let expense = ExpenseItem(name: "Test\(number)", type: "Personal", amount: 5)
//                    expenses.items.append(expense)
//                    number += 1
                    showingAddExpenses = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpenses){
                AddView(expenses: expenses)
            }
            
        }
    }
    
    func removeItem(at offsets : IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func expensesView(for type: String) -> some View {
        return Section{
            Text(type)
                .font(.headline)
                .font(.title)
            ForEach(expenses.items){ item in // id: \.id gone bcs of Identifiable protocol added
                if item.type == type {
                    HStack{
                        VStack(alignment: .leading){
                            Text("- \(item.name)")
                        }
                        Spacer()
                        Text(item.amount, format: localeCurrency)
                            .foregroundColor(item.amount <= 100_000 ? Color.green : (item.amount <= 1_000_000 ? Color.yellow : Color.red)
                            )
                    }
                }
            }
            .onDelete(perform: removeItem)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
