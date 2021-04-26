//
//  ContentView.swift
//  BetterRest
//
//  Created by Hayden Davidson on 2/6/21.
//

import SwiftUI

struct ContentView: View {
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    func calculateBedTime() {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime  = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle =  .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
            
        }catch{
            alertTitle = "error"
            alertMessage = "Sorry! There was an issue calculating your bed time"
        }
//        showingAlert = true
    }
    
    
    
    
    var body: some View {
        NavigationView{
                Form {
                    Section (header: Text("When do you want to wake up?")){
                        
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    Section (header: Text("Desired amount of sleep")){
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                    }
                    Section (header: Text("Daily coffee intake")) {
                        Picker(selection: $coffeeAmount, label: Text("Cups of coffee"), content: {
                            ForEach(1..<21) {num in
                                Text("\(num)")
                            }
                        })
                    }
                    
//                    Challenge not solved yet.     
                    
//                    Section(header: Text("Calculated Bedtime")){
//                        Text("\(alertMessage)")
//                            .font(.largeTitle)
//                    }
                    
                }.navigationTitle("BetterRest")
    //            .navigationBarItems(trailing: Button(action: calculateBedTime, label: {
    //                Text("Calculate")
    //            }))
                .alert(isPresented: $showingAlert, content: {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
