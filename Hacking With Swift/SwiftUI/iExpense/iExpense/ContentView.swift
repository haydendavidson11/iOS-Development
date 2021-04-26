//
//  ContentView.swift
//  iExpense
//
//  Created by Hayden Davidson on 2/12/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAddExpense = false
    @ObservedObject var expenses = Expenses()
    
    
    
    
    var body: some View {
        NavigationView {
            List{
                ForEach(expenses.items) {
                    item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("$\(item.amount, specifier: "%g")")
                            .modifier(amountModifier(amount: item.amount))
                    }
                    
                }
                .onDelete(perform: removeItems)
                
            }
            .navigationBarItems(leading: EditButton(),trailing: Button(action: {
                self.showingAddExpense = true
            }){
                Image(systemName: "plus")
            })
            .navigationTitle("iExpense")
            
        }
        
        
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
        
        
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct amountModifier: ViewModifier {
    var amount: Double
    
    func body(content: Content) -> some View {
        
        if  amount < 10 {
            return content.foregroundColor(.blue)
        } else if amount < 100 {
            return content.foregroundColor(.green)
        }else{
            return content.foregroundColor(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


