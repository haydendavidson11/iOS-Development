//
//  ContentView.swift
//  WeSplit
//
//  Created by Hayden Davidson on 2/2/21.
//

import SwiftUI

//Challenge solution not implemented on any text

struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func LargeBlueText() -> some View {
        self.modifier(LargeBlueTitle())
    }
}

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
         
        return grandTotal
    }
    
    
        
    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
//                    Challenge to make picker a textfield
//                    TextField("Number of People", value: $numberOfPeople, formatter: NumberFormatter())
//                        .keyboardType(.decimalPad)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                }
                Section(header: Text("How much tip do you want to leave?")){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Amount Per Person")){
                    Text("$\(totalPerPerson, specifier: "%.2f") ")
                }
                Section(header: Text("Grand Total")){
                    Text("$\(grandTotal, specifier: "%.2f")")
                        .foregroundColor(tipPercentage == 4 ? .red : .blue)
                        
                }
            }.navigationTitle("WeSplit")
            
        }
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


