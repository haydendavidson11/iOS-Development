//
//  AddView.swift
//  iExpense
//
//  Created by Hayden Davidson on 2/16/21.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var errorMessage = ""
    @State private var errorTitle = ""
    @State private var showAlert = false
    
    static let types = ["Personal", "Business"]

    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showAlert = true
    }
    
    var body: some View {
        NavigationView {
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                
            }.navigationTitle("Add New Expense")
            .navigationBarItems(trailing:
                    Button("Save"){
                        if let actualAmount = Double(self.amount){
                            let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                            self.expenses.items.append(item)
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            wordError(title: "Invalid amount", message: "Please enter a number")
                        }
                   }
            )
        }.alert(isPresented: $showAlert) {
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK"))
        )}
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
